const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    const examples = b.option(bool, "examples", "Build all examples [default: false]") orelse false;

    if (examples) {
        buildExample(b, .{
            .filepath = "examples/sum_module.zig",
            .target = target,
            .optimize = optimize,
        });
    }

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/llvm.zig" },
        .target = target,
        .optimize = optimize,
    });
    unit_tests.defineCMacro("_FILE_OFFSET_BITS", "64");
    unit_tests.defineCMacro("__STDC_CONSTANT_MACROS", null);
    unit_tests.defineCMacro("__STDC_FORMAT_MACROS", null);
    unit_tests.defineCMacro("__STDC_LIMIT_MACROS", null);
    unit_tests.linkSystemLibrary("z");
    switch (target.getOsTag()) {
        .linux => unit_tests.linkSystemLibrary("LLVM-16"), // Ubuntu
        .macos => {
            unit_tests.addLibraryPath("/usr/local/opt/llvm/lib");
            unit_tests.linkSystemLibrary("LLVM");
        },
        else => unit_tests.linkSystemLibrary("LLVM"),
    }
    unit_tests.linkLibC();

    const run_unit_tests = b.addRunArtifact(unit_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
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
    exe.addModule("llvm", module(b));
    exe.linkSystemLibrary("z");
    switch (i.target.getOsTag()) {
        .linux => exe.linkSystemLibrary("LLVM-16"), // Ubuntu
        .macos => {
            exe.addLibraryPath("/usr/local/opt/llvm/lib");
            exe.linkSystemLibrary("LLVM");
        },
        else => exe.linkSystemLibrary("LLVM"),
    }
    exe.linkLibC();

    // This declares intent for the executable to be installed into the
    // standard location when the user invokes the "install" step (the default
    // step when running `zig build`).
    b.installArtifact(exe);

    // This *creates* a RunStep in the build graph, to be executed when another
    // step is evaluated that depends on it. The next line below will establish
    // such a dependency.
    const run_cmd = b.addRunArtifact(exe);

    // By making the run step depend on the install step, it will be run from the
    // installation directory rather than directly from within the cache directory.
    // This is not necessary, however, if the application depends on other installed
    // files, this ensures they will be present and in the expected location.
    run_cmd.step.dependOn(b.getInstallStep());

    // This allows the user to pass arguments to the application in the build
    // command itself, like this: `zig build run -- arg1 arg2 etc`
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    const run_step = b.step(i.filename(), b.fmt("Run the {s}", .{i.filename()}));
    run_step.dependOn(&run_cmd.step);
}

pub fn module(b: *std.Build) *std.Build.Module {
    return b.createModule(.{
        .source_file = .{
            .path = "src/llvm.zig",
        },
    });
}

const BuildInfo = struct {
    filepath: []const u8,
    target: std.zig.CrossTarget,
    optimize: std.builtin.OptimizeMode,

    fn filename(self: BuildInfo) []const u8 {
        var split = std.mem.split(u8, std.fs.path.basename(self.filepath), ".");
        return split.first();
    }
};
