const orc = @import("../orc.zig");
pub const addObjectFile = orc.LLVMOrcObjectLayerAddObjectFile;
pub const addObjectFileWithRT = orc.LLVMOrcObjectLayerAddObjectFileWithRT;
pub const emit = orc.LLVMOrcObjectLayerEmit;
pub const dispose = orc.LLVMOrcDisposeObjectLayer;
