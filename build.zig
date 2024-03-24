const std = @import("std");

pub fn build(b: *std.Build) void {
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

    lib.installHeader("alloc.h", "alloc.h");
    lib.installHeader("net.h", "net.h");
    lib.installHeader("hiredis.h", "hiredis.h");
    lib.installHeader("sds.h", "sds.h");
    lib.installHeader("async.h", "async.h");
    lib.installHeader("read.h", "read.h");
    lib.installHeader("sockcompat.h", "sockcompat.h");
    b.installArtifact(lib);
}
