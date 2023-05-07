const LLVMtype = @import("types.zig");

pub extern fn LLVMParseIRInContext(ContextRef: LLVMtype.LLVMContextRef, MemBuf: LLVMtype.LLVMMemoryBufferRef, OutM: [*c]LLVMtype.LLVMModuleRef, OutMessage: [*c][*c]u8) LLVMtype.LLVMBool;
