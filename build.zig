const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("llvm", .{
        .source_file = .{
            .path = "src/llvm.zig",
        },
    });
    _ = b.addModule("clang", .{
        .source_file = .{
            .path = "src/clang.zig",
        },
    });

    const examples = b.option(bool, "Examples", "Build all examples [default: false]") orelse false;

    if (examples) {
        buildExample(b, .{
            .filepath = "examples/sum_module.zig",
            .target = target,
            .optimize = optimize,
        });
        buildExample(b, .{
            .filepath = "examples/fatorial_module.zig",
            .target = target,
            .optimize = optimize,
        });
    }
}

fn buildExample(b: *std.Build, i: BuildInfo) void {
    const exe = b.addExecutable(.{
        .name = i.filename(),
        .root_source_file = .{ .path = i.filepath },
        .target = i.target,
        .optimize = i.optimize,
    });
    exe.defineCMacro("_FILE_OFFSET_BITS", "64");
    exe.defineCMacro("__STDC_CONSTANT_MACROS", null);
    exe.defineCMacro("__STDC_FORMAT_MACROS", null);
    exe.defineCMacro("__STDC_LIMIT_MACROS", null);
    exe.addModule("llvm", b.modules.get("llvm").?);
    exe.linkSystemLibrary("z");
    switch (i.target.getOsTag()) {
        .linux => exe.linkSystemLibrary("LLVM-17"), // Ubuntu
        .macos => {
            exe.addLibraryPath(.{ .path = "/usr/local/opt/llvm/lib" });
            exe.linkSystemLibrary("LLVM");
        },
        else => exe.linkSystemLibrary("LLVM"),
    }
    exe.linkLibC();

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step(i.filename(), b.fmt("Run the {s}", .{i.filename()}));
    run_step.dependOn(&run_cmd.step);
}

const BuildInfo = struct {
    filepath: []const u8,
    target: std.zig.CrossTarget,
    optimize: std.builtin.OptimizeMode,

    fn filename(self: BuildInfo) []const u8 {
        var split = std.mem.splitSequence(u8, std.fs.path.basename(self.filepath), ".");
        return split.first();
    }
};
