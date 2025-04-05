const orc = @import("../orc.zig");
pub const createNew = orc.LLVMOrcCreateNewThreadSafeContext;
pub const getContext = orc.LLVMOrcThreadSafeContextGetContext;
pub const dispose = orc.LLVMOrcDisposeThreadSafeContext;
