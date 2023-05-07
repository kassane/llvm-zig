const LLVMtype = @import("types.zig");

pub extern fn LLVMVerifyModule(M: LLVMtype.LLVMModuleRef, Action: LLVMtype.LLVMVerifierFailureAction, OutMessage: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMVerifyFunction(Fn: LLVMtype.LLVMValueRef, Action: LLVMtype.LLVMVerifierFailureAction) LLVMtype.LLVMBool;
pub extern fn LLVMViewFunctionCFG(Fn: LLVMtype.LLVMValueRef) void;
pub extern fn LLVMViewFunctionCFGOnly(Fn: LLVMtype.LLVMValueRef) void;
