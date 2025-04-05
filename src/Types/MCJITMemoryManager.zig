const executionEngine = @import("../executionEngine.zig");
pub const createSimple = executionEngine.LLVMCreateSimpleMCJITMemoryManager;
pub const dispose = executionEngine.LLVMDisposeMCJITMemoryManager;
