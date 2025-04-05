const orc = @import("../orc.zig");
pub const detectHost = orc.LLVMOrcJITTargetMachineBuilderDetectHost;
pub const createFromTargetMachine = orc.LLVMOrcJITTargetMachineBuilderCreateFromTargetMachine;
pub const dispose = orc.LLVMOrcDisposeJITTargetMachineBuilder;
pub const getTargetTriple = orc.LLVMOrcJITTargetMachineBuilderGetTargetTriple;
pub const setTargetTriple = orc.LLVMOrcJITTargetMachineBuilderSetTargetTriple;
