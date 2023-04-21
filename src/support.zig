const LLVMtype = @import("types.zig");

pub extern fn LLVMLoadLibraryPermanently(Filename: [*c]const u8) LLVMtype.LLVMBool;
pub extern fn LLVMParseCommandLineOptions(argc: c_int, argv: [*c]const [*c]const u8, Overview: [*c]const u8) void;
pub extern fn LLVMSearchForAddressOfSymbol(symbolName: [*c]const u8) ?*anyopaque;
pub extern fn LLVMAddSymbol(symbolName: [*c]const u8, symbolValue: ?*anyopaque) void;
