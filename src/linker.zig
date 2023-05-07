const LLVMtype = @import("types.zig");

pub extern fn LLVMLinkModules2(Dest: LLVMtype.LLVMModuleRef, Src: LLVMtype.LLVMModuleRef) LLVMtype.LLVMBool;
