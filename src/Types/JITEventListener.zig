
const executionEngine = @import("../executionEngine.zig");
pub const createGDBRegistrationListener = executionEngine.LLVMCreateGDBRegistrationListener;
pub const createIntel = executionEngine.LLVMCreateIntelJITEventListener;
pub const createOProfile = executionEngine.LLVMCreateOProfileJITEventListener;
pub const createPerf = executionEngine.LLVMCreatePerfJITEventListener;
