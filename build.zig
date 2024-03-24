const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Create static library
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "hirediz",
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.addCSourceFiles(&.{"hiredis.c"}, &.{
        "-std=c99",
        "-Wall",
        "-Os",
        "-g",
    });

    lib.installHeader("hiredis.h", "hiredis.h");
    b.installArtifact(lib);
}
