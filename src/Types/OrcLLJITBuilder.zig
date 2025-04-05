const lljit = @import("../lljit.zig");
pub const create = lljit.LLVMOrcCreateLLJITBuilder;
pub const dispose = lljit.LLVMOrcDisposeLLJITBuilder;
pub const setJITTargetMachineBuilder = lljit.LLVMOrcLLJITBuilderSetJITTargetMachineBuilder;
pub const setObjectLinkingLayerCreator = lljit.LLVMOrcLLJITBuilderSetObjectLinkingLayerCreator;
