const std = @import("std");

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
pub const initialization = @import("initialization.zig");
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
    _ = initialization;
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

    const testing = std.testing;
    testing.refAllDeclsRecursive(@This());
}
