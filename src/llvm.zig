const std = @import("std");

pub const errors = @import("errors.zig");
pub const error_handling = @import("error_handling.zig");
pub const core = @import("core.zig");
pub const lto = @import("lto.zig");
pub const debug = @import("debuginfo.zig");
pub const disasm = @import("disassembler.zig");

test {
    _ = errors;
    _ = error_handling;
    _ = core;
    _ = lto;
    _ = debug;
    _ = disasm;

    const testing = std.testing;
    testing.refAllDeclsRecursive(@This());
}
