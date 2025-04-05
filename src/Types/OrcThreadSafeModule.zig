const orc = @import("../orc.zig");
pub const createNew = orc.LLVMOrcCreateNewThreadSafeModule;
pub const dispose = orc.LLVMOrcDisposeThreadSafeModule;
pub const withModuleDo = orc.LLVMOrcThreadSafeModuleWithModuleDo;
