const LLVMtype = @import("types.zig");

pub extern fn LLVMGetErrorTypeId(Err: LLVMtype.LLVMErrorRef) LLVMtype.LLVMErrorTypeId;
pub extern fn LLVMConsumeError(Err: LLVMtype.LLVMErrorRef) void;
pub extern fn LLVMGetErrorMessage(Err: LLVMtype.LLVMErrorRef) ?*u8;
pub extern fn LLVMDisposeErrorMessage(ErrMsg: [*:0]u8) void;
pub extern fn LLVMGetStringErrorTypeId() LLVMtype.LLVMErrorTypeId;
/// Create a StringError.
pub extern fn LLVMCreateStringError(ErrMst: [*:0]const u8) LLVMtype.LLVMErrorRef;
