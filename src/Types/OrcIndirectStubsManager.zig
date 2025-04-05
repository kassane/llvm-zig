const orc = @import("../orc.zig");
pub const createLocal = orc.LLVMOrcCreateLocalIndirectStubsManager;
pub const dispose = orc.LLVMOrcDisposeIndirectStubsManager;
