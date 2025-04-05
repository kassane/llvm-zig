const orc = @import("../orc.zig");
pub const createDynamicLibrarySearchGeneratorForProcess = orc.LLVMOrcCreateDynamicLibrarySearchGeneratorForProcess;
pub const createDynamicLibrarySearchGeneratorForPath = orc.LLVMOrcCreateDynamicLibrarySearchGeneratorForPath;
pub const createStaticLibrarySearchGeneratorForPath = orc.LLVMOrcCreateStaticLibrarySearchGeneratorForPath;
pub const dispose = orc.LLVMOrcDisposeDefinitionGenerator;
pub const createCustomCAPIDefinitionGenerator = orc.LLVMOrcCreateCustomCAPIDefinitionGenerator;
