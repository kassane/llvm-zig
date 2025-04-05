const orc = @import("../orc.zig");
pub const getDefaultResourceTracker = orc.LLVMOrcJITDylibGetDefaultResourceTracker;
pub const define = orc.LLVMOrcJITDylibDefine;
pub const clear = orc.LLVMOrcJITDylibClear;
pub const addGenerator = orc.LLVMOrcJITDylibAddGenerator;
