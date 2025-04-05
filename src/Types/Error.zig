const errors = @import("../errors.zig");
pub const getErrorTypeId = errors.LLVMGetErrorTypeId;
pub const consume = errors.LLVMConsumeError;
pub const getErrorMessage = errors.LLVMGetErrorMessage;
pub const createString = errors.LLVMCreateStringError;
