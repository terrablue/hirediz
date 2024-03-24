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
    lib.addCSourceFiles(&.{ "alloc.c", "net.c", "hiredis.c", "sds.c", "async.c", "read.c", "sockcompat.c" }, &.{
        "-std=c99",
        "-Wall",
        "-Os",
        "-g",
    });

    lib.installHeader("hiredis.h", "hiredis.h");
    lib.installHeader("read.h", "read.h");
    lib.installHeader("sds.h", "sds.h");
    lib.installHeader("alloc.h", "alloc.h");
    b.installArtifact(lib);
}
