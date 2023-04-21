pub const LLVMBool = c_int;
pub const LLVMOpaqueMemoryBuffer = opaque {};
pub const LLVMMemoryBufferRef = ?*LLVMOpaqueMemoryBuffer;
pub const LLVMOpaqueContext = opaque {};
pub const LLVMContextRef = ?*LLVMOpaqueContext;
pub const LLVMOpaqueModule = opaque {};
pub const LLVMModuleRef = ?*LLVMOpaqueModule;
pub const LLVMOpaqueType = opaque {};
pub const LLVMTypeRef = ?*LLVMOpaqueType;
pub const LLVMOpaqueValue = opaque {};
pub const LLVMValueRef = ?*LLVMOpaqueValue;
pub const LLVMOpaqueBasicBlock = opaque {};
pub const LLVMBasicBlockRef = ?*LLVMOpaqueBasicBlock;
pub const LLVMOpaqueMetadata = opaque {};
pub const LLVMMetadataRef = ?*LLVMOpaqueMetadata;
pub const LLVMOpaqueNamedMDNode = opaque {};
pub const LLVMNamedMDNodeRef = ?*LLVMOpaqueNamedMDNode;
pub const LLVMOpaqueValueMetadataEntry = opaque {};
pub const LLVMValueMetadataEntry = LLVMOpaqueValueMetadataEntry;
pub const LLVMOpaqueBuilder = opaque {};
pub const LLVMBuilderRef = ?*LLVMOpaqueBuilder;
pub const LLVMOpaqueDIBuilder = opaque {};
pub const LLVMDIBuilderRef = ?*LLVMOpaqueDIBuilder;
pub const LLVMOpaqueModuleProvider = opaque {};
pub const LLVMModuleProviderRef = ?*LLVMOpaqueModuleProvider;
pub const LLVMOpaquePassManager = opaque {};
pub const LLVMPassManagerRef = ?*LLVMOpaquePassManager;
pub const LLVMOpaquePassRegistry = opaque {};
pub const LLVMPassRegistryRef = ?*LLVMOpaquePassRegistry;
pub const LLVMOpaqueUse = opaque {};
pub const LLVMUseRef = ?*LLVMOpaqueUse;
pub const LLVMOpaqueAttributeRef = opaque {};
pub const LLVMAttributeRef = ?*LLVMOpaqueAttributeRef;
pub const LLVMOpaqueDiagnosticInfo = opaque {};
pub const LLVMDiagnosticInfoRef = ?*LLVMOpaqueDiagnosticInfo;
pub const LLVMComdat = opaque {};
pub const LLVMComdatRef = ?*LLVMComdat;
pub const LLVMOpaqueModuleFlagEntry = opaque {};
pub const LLVMModuleFlagEntry = LLVMOpaqueModuleFlagEntry;
pub const LLVMOpaqueJITEventListener = opaque {};
pub const LLVMJITEventListenerRef = ?*LLVMOpaqueJITEventListener;
pub const LLVMOpaqueBinary = opaque {};
pub const LLVMBinaryRef = ?*LLVMOpaqueBinary;

// Errors
pub const LLVMOpaqueError = opaque {};
pub const LLVMErrorRef = ?*LLVMOpaqueError;
pub const LLVMErrorTypeId = ?*const anyopaque;

// LTO
pub const lto_codegen_model = c_uint;
pub const LLVMOpaqueLTOModule = opaque {};
pub const lto_module_t = ?*LLVMOpaqueLTOModule;
pub const LLVMOpaqueLTOCodeGenerator = opaque {};
pub const lto_code_gen_t = ?*LLVMOpaqueLTOCodeGenerator;
pub const LLVMOpaqueThinLTOCodeGenerator = opaque {};
pub const thinlto_code_gen_t = ?*LLVMOpaqueThinLTOCodeGenerator;
pub const lto_codegen_diagnostic_severity_t = c_uint;
pub const LLVMOpaqueLTOInput = opaque {};
pub const lto_input_t = ?*LLVMOpaqueLTOInput;
pub const lto_bool_t = bool;
pub const lto_symbol_attributes = c_uint;
pub const lto_debug_model = c_uint;

// Disassembler
pub const LLVMDisasmContextRef = ?*anyopaque;

// DebugInfo
pub const LLVMMetadataKind = c_uint;
pub const LLVMDWARFTypeEncoding = c_uint;
