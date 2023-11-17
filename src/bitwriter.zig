const LLVMtype = @import("types.zig");

pub extern fn LLVMWriteBitcodeToFile(M: LLVMtype.LLVMModuleRef, Path: [*:0]const u8) c_int;
pub extern fn LLVMWriteBitcodeToFD(M: LLVMtype.LLVMModuleRef, FD: c_int, ShouldClose: c_int, Unbuffered: c_int) c_int;
pub extern fn LLVMWriteBitcodeToFileHandle(M: LLVMtype.LLVMModuleRef, Handle: c_int) c_int;
pub extern fn LLVMWriteBitcodeToMemoryBuffer(M: LLVMtype.LLVMModuleRef) LLVMtype.LLVMMemoryBufferRef;
