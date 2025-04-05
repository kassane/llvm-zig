const executionEngine = @import("../executionEngine.zig");
pub const createOfInt = executionEngine.LLVMCreateGenericValueOfInt;
pub const createOfPointer = executionEngine.LLVMCreateGenericValueOfPointer;
pub const createOfFloat = executionEngine.LLVMCreateGenericValueOfFloat;
pub const intWidth = executionEngine.LLVMGenericValueIntWidth;
pub const toInt = executionEngine.LLVMGenericValueToInt;
pub const toPointer = executionEngine.LLVMGenericValueToPointer;
pub const dispose = executionEngine.LLVMDisposeGenericValue;
