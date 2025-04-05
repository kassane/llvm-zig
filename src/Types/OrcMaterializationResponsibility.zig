const orc = @import("../orc.zig");
pub const dispose = orc.LLVMOrcDisposeMaterializationResponsibility;
pub const getTargetDylib = orc.LLVMOrcMaterializationResponsibilityGetTargetDylib;
pub const getExecutionSession = orc.LLVMOrcMaterializationResponsibilityGetExecutionSession;
pub const getSymbols = orc.LLVMOrcMaterializationResponsibilityGetSymbols;
pub const getInitializerSymbol = orc.LLVMOrcMaterializationResponsibilityGetInitializerSymbol;
pub const getRequestedSymbols = orc.LLVMOrcMaterializationResponsibilityGetRequestedSymbols;
pub const notifyResolved = orc.LLVMOrcMaterializationResponsibilityNotifyResolved;
pub const notifyEmitted = orc.LLVMOrcMaterializationResponsibilityNotifyEmitted;
pub const defineMaterializing = orc.LLVMOrcMaterializationResponsibilityDefineMaterializing;
pub const failMaterialization = orc.LLVMOrcMaterializationResponsibilityFailMaterialization;
pub const replace = orc.LLVMOrcMaterializationResponsibilityReplace;
pub const delegate = orc.LLVMOrcMaterializationResponsibilityDelegate;
pub const addDependencies = orc.LLVMOrcMaterializationResponsibilityAddDependencies;
pub const addDependenciesForAll = orc.LLVMOrcMaterializationResponsibilityAddDependenciesForAll;
