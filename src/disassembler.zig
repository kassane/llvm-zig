const LLVMtype = @import("types.zig");

pub const LLVMOpInfoCallback = ?*const fn (?*anyopaque, u64, u64, u64, u64, c_int, ?*anyopaque) callconv(.C) c_int;
pub const LLVMOpInfoSymbol1 = extern struct {
    Present: u64,
    Name: [*:0]const u8,
    Value: u64,
};
pub const LLVMOpInfo1 = extern struct {
    AddSymbol: LLVMOpInfoSymbol1,
    SubtractSymbol: LLVMOpInfoSymbol1,
    Value: u64,
    VariantKind: u64,
};
pub const LLVMSymbolLookupCallback = ?*const fn (?*anyopaque, u64, [*c]u64, u64, [*c][*c]const u8) callconv(.C) [*:0]const u8;
pub extern fn LLVMCreateDisasm(TripleName: [*:0]const u8, DisInfo: ?*anyopaque, TagType: c_int, GetOpInfo: LLVMOpInfoCallback, SymbolLookUp: LLVMSymbolLookupCallback) LLVMtype.LLVMDisasmContextRef;
pub extern fn LLVMCreateDisasmCPU(Triple: [*:0]const u8, CPU: [*:0]const u8, DisInfo: ?*anyopaque, TagType: c_int, GetOpInfo: LLVMOpInfoCallback, SymbolLookUp: LLVMSymbolLookupCallback) LLVMtype.LLVMDisasmContextRef;
pub extern fn LLVMCreateDisasmCPUFeatures(Triple: [*:0]const u8, CPU: [*:0]const u8, Features: [*:0]const u8, DisInfo: ?*anyopaque, TagType: c_int, GetOpInfo: LLVMOpInfoCallback, SymbolLookUp: LLVMSymbolLookupCallback) LLVMtype.LLVMDisasmContextRef;
pub extern fn LLVMSetDisasmOptions(DC: LLVMtype.LLVMDisasmContextRef, Options: u64) c_int;
pub extern fn LLVMDisasmDispose(DC: LLVMtype.LLVMDisasmContextRef) void;
pub extern fn LLVMDisasmInstruction(DC: LLVMtype.LLVMDisasmContextRef, Bytes: [*c]u8, BytesSize: u64, PC: u64, OutString: [*c]u8, OutStringSize: usize) usize;

pub const LLVMDisassembler_VariantKind_None = @as(c_int, 0);
pub const LLVMDisassembler_VariantKind_ARM_HI16 = @as(c_int, 1);
pub const LLVMDisassembler_VariantKind_ARM_LO16 = @as(c_int, 2);
pub const LLVMDisassembler_VariantKind_ARM64_PAGE = @as(c_int, 1);
pub const LLVMDisassembler_VariantKind_ARM64_PAGEOFF = @as(c_int, 2);
pub const LLVMDisassembler_VariantKind_ARM64_GOTPAGE = @as(c_int, 3);
pub const LLVMDisassembler_VariantKind_ARM64_GOTPAGEOFF = @as(c_int, 4);
pub const LLVMDisassembler_VariantKind_ARM64_TLVP = @as(c_int, 5);
pub const LLVMDisassembler_VariantKind_ARM64_TLVOFF = @as(c_int, 6);
pub const LLVMDisassembler_ReferenceType_InOut_None = @as(c_int, 0);
pub const LLVMDisassembler_ReferenceType_In_Branch = @as(c_int, 1);
pub const LLVMDisassembler_ReferenceType_In_PCrel_Load = @as(c_int, 2);
pub const LLVMDisassembler_ReferenceType_In_ARM64_ADRP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x100000001, .hexadecimal);
pub const LLVMDisassembler_ReferenceType_In_ARM64_ADDXri = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x100000002, .hexadecimal);
pub const LLVMDisassembler_ReferenceType_In_ARM64_LDRXui = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x100000003, .hexadecimal);
pub const LLVMDisassembler_ReferenceType_In_ARM64_LDRXl = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x100000004, .hexadecimal);
pub const LLVMDisassembler_ReferenceType_In_ARM64_ADR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x100000005, .hexadecimal);
pub const LLVMDisassembler_ReferenceType_Out_SymbolStub = @as(c_int, 1);
pub const LLVMDisassembler_ReferenceType_Out_LitPool_SymAddr = @as(c_int, 2);
pub const LLVMDisassembler_ReferenceType_Out_LitPool_CstrAddr = @as(c_int, 3);
pub const LLVMDisassembler_ReferenceType_Out_Objc_CFString_Ref = @as(c_int, 4);
pub const LLVMDisassembler_ReferenceType_Out_Objc_Message = @as(c_int, 5);
pub const LLVMDisassembler_ReferenceType_Out_Objc_Message_Ref = @as(c_int, 6);
pub const LLVMDisassembler_ReferenceType_Out_Objc_Selector_Ref = @as(c_int, 7);
pub const LLVMDisassembler_ReferenceType_Out_Objc_Class_Ref = @as(c_int, 8);
pub const LLVMDisassembler_ReferenceType_DeMangled_Name = @as(c_int, 9);

pub const LLVMDisassembler_Option_UseMarkup = @as(c_int, 1);
pub const LLVMDisassembler_Option_PrintImmHex = @as(c_int, 2);
pub const LLVMDisassembler_Option_AsmPrinterVariant = @as(c_int, 4);
pub const LLVMDisassembler_Option_SetInstrComments = @as(c_int, 8);
pub const LLVMDisassembler_Option_PrintLatency = @as(c_int, 16);
