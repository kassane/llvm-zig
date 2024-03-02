const std = @import("std");

pub fn build(b: *std.Build) void {
    const target_query: std.Target.Query = .{};
    const target = b.resolveTargetQuery(target_query);
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("llvm", .{
        .root_source_file = .{
            .path = "src/llvm.zig",
        },
    });
    _ = b.addModule("clang", .{
        .root_source_file = .{
            .path = "src/clang.zig",
        },
    });

    buildTests(b, target);

    const examples = b.option(bool, "Examples", "Build all examples [default: false]") orelse false;

    if (examples) {
        buildExample(b, target, .{
            .filepath = "examples/sum_module.zig",
            .target = target.query,
            .optimize = optimize,
        });
        buildExample(b, target, .{
            .filepath = "examples/fatorial_module.zig",
            .target = target.query,
            .optimize = optimize,
        });
    }
}

fn buildExample(b: *std.Build, target: std.Build.ResolvedTarget, i: BuildInfo) void {
    const exe = b.addExecutable(.{
        .name = i.filename(),
        .root_source_file = .{ .path = i.filepath },
        .target = target,
        .optimize = i.optimize,
    });
    exe.defineCMacro("_FILE_OFFSET_BITS", "64");
    exe.defineCMacro("__STDC_CONSTANT_MACROS", null);
    exe.defineCMacro("__STDC_FORMAT_MACROS", null);
    exe.defineCMacro("__STDC_LIMIT_MACROS", null);
    exe.root_module.addImport("llvm", b.modules.get("llvm").?);
    exe.linkSystemLibrary("z");
    switch (target.result.os.tag) {
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

fn buildTests(b: *std.Build, target: std.Build.ResolvedTarget) void {
    const llvm_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/llvm.zig" },
        .target = target,
        .optimize = .Debug,
        .name = "llvm-tests",
    });
    const clang_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/clang.zig" },
        .target = target,
        .optimize = .Debug,
        .name = "clang-tests",
    });
    switch (target.result.os.tag) {
        .linux => clang_tests.linkSystemLibrary("clang-17"), // Ubuntu
        .macos => {
            clang_tests.addLibraryPath(.{ .path = "/usr/local/opt/llvm/lib" });
            clang_tests.linkSystemLibrary("clang");
        },
        else => clang_tests.linkSystemLibrary("clang"),
    }
    clang_tests.linkLibC();

    llvm_tests.defineCMacro("_FILE_OFFSET_BITS", "64");
    llvm_tests.defineCMacro("__STDC_CONSTANT_MACROS", null);
    llvm_tests.defineCMacro("__STDC_FORMAT_MACROS", null);
    llvm_tests.defineCMacro("__STDC_LIMIT_MACROS", null);
    llvm_tests.root_module.addImport("llvm", b.modules.get("llvm").?);
    llvm_tests.linkSystemLibrary("z");
    switch (target.result.os.tag) {
        .linux => llvm_tests.linkSystemLibrary("LLVM-17"), // Ubuntu
        .macos => {
            llvm_tests.addLibraryPath(.{ .path = "/usr/local/opt/llvm/lib" });
            llvm_tests.linkSystemLibrary("LLVM");
        },
        else => llvm_tests.linkSystemLibrary("LLVM"),
    }
    llvm_tests.linkLibC();

    // TODO: CI build LLVM tests with clang
    // llvm_tests.step.dependOn(&clang_tests.step);
    const run_llvm_tests = b.addRunArtifact(llvm_tests);
    const test_llvm_step = b.step("test", "Run LLVM-binding tests");
    test_llvm_step.dependOn(&run_llvm_tests.step);
}
