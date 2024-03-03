const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target_query: std.Target.Query = .{};
    const target = b.resolveTargetQuery(target_query);
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "llvm", 
        .root_source_file = .{.path = "src/llvm.zig"},
        .target = target,
        .optimize = optimize
    });

    lib.defineCMacro("_FILE_OFFSET_BITS", "64");
    lib.defineCMacro("__STDC_CONSTANT_MACROS", null);
    lib.defineCMacro("__STDC_FORMAT_MACROS", null);
    lib.defineCMacro("__STDC_LIMIT_MACROS", null);
    lib.linkSystemLibrary("z");
    lib.linkLibC();
    switch (target.result.os.tag) {
        .linux => lib.linkSystemLibrary("LLVM-17"), // Ubuntu
        .macos => {
            lib.addLibraryPath(.{ .path = "/usr/local/opt/llvm/lib" });
            lib.linkSystemLibrary("LLVM");
        },
        else => lib.linkSystemLibrary("LLVM"),
    }

    b.installArtifact(lib);

    _ = try b.modules.put("llvm", &lib.root_module);

    _ = b.addModule("clang", .{
        .root_source_file = .{
            .path = "src/clang.zig",
        },
    });

    const examples = b.option(bool, "Examples", "Build all examples [default: false]") orelse false;
    if (examples) {
        buildExample(b, target, .{
            .filepath = "examples/sum_module.zig",
            .target = target.query,
            .optimize = optimize,
        });
        buildExample(b, target, .{
            .filepath = "examples/factorial_module.zig",
            .target = target.query,
            .optimize = optimize,
        });
    }

    buildTests(b, target);
}

fn buildExample(b: *std.Build, target: std.Build.ResolvedTarget, i: BuildInfo) void {
    const exe = b.addExecutable(.{
        .name = i.filename(),
        .root_source_file = .{ .path = i.filepath },
        .target = target,
        .optimize = i.optimize,
    });
    exe.root_module.addImport("llvm", b.modules.get("llvm").?);

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

    llvm_tests.root_module.addImport("llvm", b.modules.get("llvm").?);

    // TODO: CI build LLVM tests with clang
    // llvm_tests.step.dependOn(&clang_tests.step);
    const run_llvm_tests = b.addRunArtifact(llvm_tests);
    const test_llvm_step = b.step("test", "Run LLVM-binding tests");
    test_llvm_step.dependOn(&run_llvm_tests.step);
}
