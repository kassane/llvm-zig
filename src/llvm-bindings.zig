pub const analysis = @import("analysis.zig");
pub const blake3 = @import("blake3.zig");
pub const bitreader = @import("bitreader.zig");
pub const bitwriter = @import("bitwriter.zig");
pub const core = @import("core.zig");
pub const debug = @import("debuginfo.zig");
pub const disasm = @import("disassembler.zig");
pub const engine = @import("executionEngine.zig");
pub const errors = @import("errors.zig");
pub const error_handling = @import("error_handling.zig");
pub const irreader = @import("irreader.zig");
pub const linker = @import("linker.zig");
pub const lto = @import("lto.zig");
pub const jit = @import("lljit.zig");
pub const orc = @import("orc.zig");
pub const orcee = @import("orcee.zig");
pub const remarks = @import("remarks.zig");
pub const support = @import("support.zig");
pub const target = @import("target.zig");
pub const target_machine = @import("target_machine.zig");
pub const transform = @import("transform.zig");
pub const types = @import("types.zig");

const std = @import("std");

test "all LLVM modules" {
    _ = analysis;
    _ = blake3;
    _ = bitreader;
    _ = bitwriter;
    _ = core;
    _ = debug;
    _ = disasm;
    _ = engine;
    _ = errors;
    _ = error_handling;
    _ = irreader;
    _ = linker;
    _ = lto;
    _ = jit;
    _ = orc;
    _ = orcee;
    _ = remarks;
    _ = support;
    _ = target;
    _ = target_machine;
    _ = transform;
}

test "PassBuilder options create and dispose" {
    const opts = transform.LLVMCreatePassBuilderOptions();
    try std.testing.expect(opts != null);
    transform.LLVMDisposePassBuilderOptions(opts);
}

test "TargetMachineOptions create and dispose" {
    const opts = target_machine.LLVMCreateTargetMachineOptions();
    try std.testing.expect(opts != null);
    target_machine.LLVMDisposeTargetMachineOptions(opts);
}

test "LLVMRunPasses with verify pipeline returns success" {
    const mod = core.LLVMModuleCreateWithName("test_passes");
    defer core.LLVMDisposeModule(mod);
    const opts = transform.LLVMCreatePassBuilderOptions();
    defer transform.LLVMDisposePassBuilderOptions(opts);
    const err = transform.LLVMRunPasses(mod, "verify", null, opts);
    defer if (err != null) errors.LLVMConsumeError(err);
    try std.testing.expect(err == null);
}

test "LLVMCantFail with success (null) error does not panic" {
    // null is the LLVM success value for LLVMErrorRef
    errors.LLVMCantFail(null);
}

// In LLVM 21, new debug format (RemoveDIs) is always enabled; the setter is a no-op.
test "new debug format is always enabled in LLVM 21" {
    const mod = core.LLVMModuleCreateWithName("test_dbg_fmt");
    defer core.LLVMDisposeModule(mod);
    try std.testing.expect(core.LLVMIsNewDbgInfoFormat(mod) != 0);
}
