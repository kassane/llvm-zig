const LLVMtype = @import("types.zig");

pub extern fn LLVMParseBitcode(MemBuf: LLVMtype.LLVMMemoryBufferRef, OutModule: [*c]LLVMtype.LLVMModuleRef, OutMessage: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMParseBitcode2(MemBuf: LLVMtype.LLVMMemoryBufferRef, OutModule: [*c]LLVMtype.LLVMModuleRef) LLVMtype.LLVMBool;
pub extern fn LLVMParseBitcodeInContext(ContextRef: LLVMtype.LLVMContextRef, MemBuf: LLVMtype.LLVMMemoryBufferRef, OutModule: [*c]LLVMtype.LLVMModuleRef, OutMessage: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMParseBitcodeInContext2(ContextRef: LLVMtype.LLVMContextRef, MemBuf: LLVMtype.LLVMMemoryBufferRef, OutModule: [*c]LLVMtype.LLVMModuleRef) LLVMtype.LLVMBool;
pub extern fn LLVMGetBitcodeModuleInContext(ContextRef: LLVMtype.LLVMContextRef, MemBuf: LLVMtype.LLVMMemoryBufferRef, OutM: [*c]LLVMtype.LLVMModuleRef, OutMessage: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMGetBitcodeModuleInContext2(ContextRef: LLVMtype.LLVMContextRef, MemBuf: LLVMtype.LLVMMemoryBufferRef, OutM: [*c]LLVMtype.LLVMModuleRef) LLVMtype.LLVMBool;
pub extern fn LLVMGetBitcodeModule(MemBuf: LLVMtype.LLVMMemoryBufferRef, OutM: [*c]LLVMtype.LLVMModuleRef, OutMessage: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMGetBitcodeModule2(MemBuf: LLVMtype.LLVMMemoryBufferRef, OutM: [*c]LLVMtype.LLVMModuleRef) LLVMtype.LLVMBool;
