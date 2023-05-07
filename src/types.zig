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
pub const LLVMBinaryType = enum(c_int) {
    LLVMBinaryTypeArchive, // Archive file.
    LLVMBinaryTypeMachOUniversalBinary, // Mach-O Universal Binary file.
    LLVMBinaryTypeCOFFImportFile, // COFF Import file.
    LLVMBinaryTypeIR, // LLVM IR.
    LLVMBinaryTypeWinRes, // Windows resource (.res) file.
    LLVMBinaryTypeCOFF, // COFF Object file.
    LLVMBinaryTypeELF32L, // ELF 32-bit, little endian.
    LLVMBinaryTypeELF32B, // ELF 32-bit, big endian.
    LLVMBinaryTypeELF64L, // ELF 64-bit, little endian.
    LLVMBinaryTypeELF64B, // ELF 64-bit, big endian.
    LLVMBinaryTypeMachO32L, // MachO 32-bit, little endian.
    LLVMBinaryTypeMachO32B, // MachO 32-bit, big endian.
    LLVMBinaryTypeMachO64L, // MachO 64-bit, little endian.
    LLVMBinaryTypeMachO64B, // MachO 64-bit, big endian.
    LLVMBinaryTypeWasm, // Web Assembly.
    LLVMBinaryTypeOffload, // Offloading fatbinary.

};
pub const LLVMBinaryRef = ?*LLVMOpaqueBinary;
pub const LLVMAttributeIndex = usize;
pub const LLVMAtomicOrdering = enum(c_int) {
    LLVMAtomicOrderingNotAtomic = 0,
    LLVMAtomicOrderingUnordered = 1,
    LLVMAtomicOrderingMonotonic = 2,
    LLVMAtomicOrderingAcquire = 4,
    LLVMAtomicOrderingRelease = 5,
    LLVMAtomicOrderingAcquireRelease = 6,
    LLVMAtomicOrderingSequentiallyConsistent = 7,
};
pub const LLVMAtomicRMWBinOp = enum(c_int) {
    LLVMAtomicRMWBinOpXchg, // Set the new value and return the one old
    LLVMAtomicRMWBinOpAdd, // Add a value and return the old one
    LLVMAtomicRMWBinOpSub, // Subtract a value and return the old one
    LLVMAtomicRMWBinOpAnd, // And a value and return the old one
    LLVMAtomicRMWBinOpNand, // Not-And a value and return the old one
    LLVMAtomicRMWBinOpOr, // OR a value and return the old one
    LLVMAtomicRMWBinOpXor, // Xor a value and return the old one
    LLVMAtomicRMWBinOpMax, // Sets the value if it's greater than the
    // original using a signed comparison and return
    // the old one
    LLVMAtomicRMWBinOpMin, // Sets the value if it's Smaller than the
    // original using a signed comparison and return
    // the old one
    LLVMAtomicRMWBinOpUMax, // Sets the value if it's greater than the
    // original using an unsigned comparison and return
    // the old one
    LLVMAtomicRMWBinOpUMin, // Sets the value if it's greater than the
    //  original using an unsigned comparison and return
    //  the old one
    LLVMAtomicRMWBinOpFAdd, // Add a floating point value and return the
    //  old one
    LLVMAtomicRMWBinOpFSub, // Subtract a floating point value and return the
    // old one
    LLVMAtomicRMWBinOpFMax, // Sets the value if it's greater than the
    // original using an floating point comparison and
    // return the old one
    LLVMAtomicRMWBinOpFMin, // Sets the value if it's smaller than the
    // original using an floating point comparison and
    // return the old one
};
pub const LLVMDiagnosticSeverity = enum(c_int) {
    LLVMDSError,
    LLVMDSWarning,
    LLVMDSRemark,
    LLVMDSNote,
};
pub const LLVMModuleFlagBehavior = enum(c_int) {
    LLVMModuleFlagBehaviorError,
    LLVMModuleFlagBehaviorWarning,
    LLVMModuleFlagBehaviorRequire,
    LLVMModuleFlagBehaviorOverride,
    LLVMModuleFlagBehaviorAppend,
    LLVMModuleFlagBehaviorAppendUnique,
};
pub const LLVMInlineAsmDialect = enum(c_int) {
    LVMInlineAsmDialectATT,
    LLVMInlineAsmDialectIntel,
};
pub const LLVMTypeKind = enum(c_int) {
    LLVMVoidTypeKind, // type with no size
    LLVMHalfTypeKind, // 16 bit floating point type
    LLVMFloatTypeKind, // 32 bit floating point type
    LLVMDoubleTypeKind, // 64 bit floating point type
    LLVMX86_FP80TypeKind, // 80 bit floating point type (X87)
    LLVMFP128TypeKind, // 128 bit floating point type (112-bit mantissa
    LLVMPPC_FP128TypeKind, // 128 bit floating point type (two 64-bits)
    LLVMLabelTypeKind, // Labels
    LLVMIntegerTypeKind, // Arbitrary bit width integers
    LLVMFunctionTypeKind, // Functions
    LLVMStructTypeKind, // Structures
    LLVMArrayTypeKind, // Arrays
    LLVMPointerTypeKind, // Pointers
    LLVMVectorTypeKind, // Fixed width SIMD vector type
    LLVMMetadataTypeKind, // Metadata
    LLVMX86_MMXTypeKind, // X86 MMX
    LLVMTokenTypeKind, // Tokens
    LLVMScalableVectorTypeKind, // Scalable SIMD vector type
    LLVMBFloatTypeKind, // 16 bit brain floating point type
    LLVMX86_AMXTypeKind, // X86 AMX
    LLVMTargetExtTypeKind, // Target extension type
};

pub const LLVMLinkage = enum(c_int) {
    LLVMExternalLinkage, // Externally visible function
    LLVMAvailableExternallyLinkage,
    LLVMLinkOnceAnyLinkage, // Keep one copy of function when linking (inline
    LLVMLinkOnceODRLinkage, // Same, but only replaced by something equivalent.
    LLVMLinkOnceODRAutoHideLinkage, // Obsolete
    LLVMWeakAnyLinkage, // Keep one copy of function when linking (weak)
    LLVMWeakODRLinkage, // Same, but only replaced by something equivalent.
    LLVMAppendingLinkage, // Special purpose, only applies to global arrays
    LLVMInternalLinkage, // Rename collisions when linking (static functions)
    LLVMPrivateLinkage, // Like Internal, but omit from symbol table
    LLVMDLLImportLinkage, // Obsolete
    LLVMDLLExportLinkage, // Obsolete
    LLVMExternalWeakLinkage, // ExternalWeak linkage description
    LLVMGhostLinkage, // Obsolete
    LLVMCommonLinkage, // Tentative definitions
    LLVMLinkerPrivateLinkage, // Like Private, but linker removes.
    LLVMLinkerPrivateWeakLinkage, // Like LinkerPrivate, but is weak.
};

pub const LLVMVisibility = enum(c_int) {
    LLVMDefaultVisibility, // The GV is visible
    LLVMHiddenVisibility, // The GV is hidden
    LLVMProtectedVisibility, // The GV is protected
};

pub const LLVMUnnamedAddr = enum(c_int) {
    LLVMNoUnnamedAddr, // Address of the GV is significant.
    LLVMLocalUnnamedAddr, // Address of the GV is locally insignificant.
    LLVMGlobalUnnamedAddr, // Address of the GV is globally insignificant.
};

pub const LLVMDLLStorageClass = enum(c_int) {
    LLVMDefaultStorageClass = 0,
    LLVMDLLImportStorageClass = 1, // Function to be imported from DLL.
    LLVMDLLExportStorageClass = 2, // Function to be accessible from DLL.
};

pub const LLVMCallConv = enum(c_int) {
    LLVMCCallConv = 0,
    LLVMFastCallConv = 8,
    LLVMColdCallConv = 9,
    LLVMGHCCallConv = 10,
    LLVMHiPECallConv = 11,
    LLVMWebKitJSCallConv = 12,
    LLVMAnyRegCallConv = 13,
    LLVMPreserveMostCallConv = 14,
    LLVMPreserveAllCallConv = 15,
    LLVMSwiftCallConv = 16,
    LLVMCXXFASTTLSCallConv = 17,
    LLVMX86StdcallCallConv = 64,
    LLVMX86FastcallCallConv = 65,
    LLVMARMAPCSCallConv = 66,
    LLVMARMAAPCSCallConv = 67,
    LLVMARMAAPCSVFPCallConv = 68,
    LLVMMSP430INTRCallConv = 69,
    LLVMX86ThisCallCallConv = 70,
    LLVMPTXKernelCallConv = 71,
    LLVMPTXDeviceCallConv = 72,
    LLVMSPIRFUNCCallConv = 75,
    LLVMSPIRKERNELCallConv = 76,
    LLVMIntelOCLBICallConv = 77,
    LLVMX8664SysVCallConv = 78,
    LLVMWin64CallConv = 79,
    LLVMX86VectorCallCallConv = 80,
    LLVMHHVMCallConv = 81,
    LLVMHHVMCCallConv = 82,
    LLVMX86INTRCallConv = 83,
    LLVMAVRINTRCallConv = 84,
    LLVMAVRSIGNALCallConv = 85,
    LLVMAVRBUILTINCallConv = 86,
    LLVMAMDGPUVSCallConv = 87,
    LLVMAMDGPUGSCallConv = 88,
    LLVMAMDGPUPSCallConv = 89,
    LLVMAMDGPUCSCallConv = 90,
    LLVMAMDGPUKERNELCallConv = 91,
    LLVMX86RegCallCallConv = 92,
    LLVMAMDGPUHSCallConv = 93,
    LLVMMSP430BUILTINCallConv = 94,
    LLVMAMDGPULSCallConv = 95,
    LLVMAMDGPUESCallConv = 96,
};

pub const LLVMValueKind = enum(c_int) {
    LLVMArgumentValueKind,
    LLVMBasicBlockValueKind,
    LLVMMemoryUseValueKind,
    LLVMMemoryDefValueKind,
    LLVMMemoryPhiValueKind,

    LLVMFunctionValueKind,
    LLVMGlobalAliasValueKind,
    LLVMGlobalIFuncValueKind,
    LLVMGlobalVariableValueKind,
    LLVMBlockAddressValueKind,
    LLVMConstantExprValueKind,
    LLVMConstantArrayValueKind,
    LLVMConstantStructValueKind,
    LLVMConstantVectorValueKind,

    LLVMUndefValueValueKind,
    LLVMConstantAggregateZeroValueKind,
    LLVMConstantDataArrayValueKind,
    LLVMConstantDataVectorValueKind,
    LLVMConstantIntValueKind,
    LLVMConstantFPValueKind,
    LLVMConstantPointerNullValueKind,
    LLVMConstantTokenNoneValueKind,

    LLVMMetadataAsValueValueKind,
    LLVMInlineAsmValueKind,

    LLVMInstructionValueKind,
    LLVMPoisonValueValueKind,
    LLVMConstantTargetNoneValueKind,
};

pub const LLVMIntPredicate = enum(c_int) {
    LLVMIntEQ = 32, // equal
    LLVMIntNE, // not equal
    LLVMIntUGT, // unsigned greater than
    LLVMIntUGE, // unsigned greater or equal
    LLVMIntULT, // unsigned less than
    LLVMIntULE, // unsigned less or equal
    LLVMIntSGT, // signed greater than
    LLVMIntSGE, // signed greater or equal
    LLVMIntSLT, // signed less than
    LLVMIntSLE, // signed less or equal
};

pub const LLVMRealPredicate = enum(c_int) {
    LLVMRealPredicateFalse, // Always false (always folded)
    LLVMRealOEQ, // True if ordered and equal
    LLVMRealOGT, // True if ordered and greater than
    LLVMRealOGE, // True if ordered and greater than or equal
    LLVMRealOLT, // True if ordered and less than
    LLVMRealOLE, // True if ordered and less than or equal
    LLVMRealONE, // True if ordered and operands are unequal
    LLVMRealORD, // True if ordered (no nans)
    LLVMRealUNO, // True if unordered: isnan(X) | isnan(Y)
    LLVMRealUEQ, // True if unordered or equal
    LLVMRealUGT, // True if unordered or greater than
    LLVMRealUGE, // True if unordered, greater than, or equal
    LLVMRealULT, // True if unordered or less than
    LLVMRealULE, // True if unordered, less than, or equal
    LLVMRealUNE, // True if unordered or not equal
    LLVMRealPredicateTrue, // Always true (always folded)
};
pub const LLVMOpcode = enum(c_int) {
    // Terminator Instructions
    LLVMRet = 1,
    LLVMBr = 2,
    LLVMSwitch = 3,
    LLVMIndirectBr = 4,
    LLVMInvoke = 5,
    // removed 6 due to API changes
    LLVMUnreachable = 7,
    LLVMCallBr = 67,

    // Standard Unary Operators
    LLVMFNeg = 66,

    // Standard Binary Operators
    LLVMAdd = 8,
    LLVMFAdd = 9,
    LLVMSub = 10,
    LLVMFSub = 11,
    LLVMMul = 12,
    LLVMFMul = 13,
    LLVMUDiv = 14,
    LLVMSDiv = 15,
    LLVMFDiv = 16,
    LLVMURem = 17,
    LLVMSRem = 18,
    LLVMFRem = 19,

    // Logical Operators
    LLVMShl = 20,
    LLVMLShr = 21,
    LLVMAShr = 22,
    LLVMAnd = 23,
    LLVMOr = 24,
    LLVMXor = 25,

    // Memory Operators
    LLVMAlloca = 26,
    LLVMLoad = 27,
    LLVMStore = 28,
    LLVMGetElementPtr = 29,

    // Cast Operators
    LLVMTrunc = 30,
    LLVMZExt = 31,
    LLVMSExt = 32,
    LLVMFPToUI = 33,
    LLVMFPToSI = 34,
    LLVMUIToFP = 35,
    LLVMSIToFP = 36,
    LLVMFPTrunc = 37,
    LLVMFPExt = 38,
    LLVMPtrToInt = 39,
    LLVMIntToPtr = 40,
    LLVMBitCast = 41,
    LLVMAddrSpaceCast = 60,

    // Other Operators
    LLVMICmp = 42,
    LLVMFCmp = 43,
    LLVMPHI = 44,
    LLVMCall = 45,
    LLVMSelect = 46,
    LLVMUserOp1 = 47,
    LLVMUserOp2 = 48,
    LLVMVAArg = 49,
    LLVMExtractElement = 50,
    LLVMInsertElement = 51,
    LLVMShuffleVector = 52,
    LLVMExtractValue = 53,
    LLVMInsertValue = 54,
    LLVMFreeze = 68,

    // Atomic operators
    LLVMFence = 55,
    LLVMAtomicCmpXchg = 56,
    LLVMAtomicRMW = 57,

    // Exception Handling Operators
    LLVMResume = 58,
    LLVMLandingPad = 59,
    LLVMCleanupRet = 61,
    LLVMCatchRet = 62,
    LLVMCatchPad = 63,
    LLVMCleanupPad = 64,
    LLVMCatchSwitch = 65,
};

pub const LLVMLandingPadClauseTy = enum(c_int) {
    LLVMLandingPadCatch, // A catch clause
    LLVMLandingPadFilter, // A filter clause
};

pub const LLVMThreadLocalMode = enum(c_int) {
    LLVMNotThreadLocal = 0,
    LLVMGeneralDynamicTLSModel,
    LLVMLocalDynamicTLSModel,
    LLVMInitialExecTLSModel,
    LLVMLocalExecTLSModel,
};

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

pub const LLVMDIFlags = enum(c_int) {
    LLVMDIFlagZero = 0,
    LLVMDIFlagPrivate = 1,
    LLVMDIFlagProtected = 2,
    LLVMDIFlagPublic = 3,
    LLVMDIFlagFwdDecl = 1 << 2,
    LLVMDIFlagAppleBlock = 1 << 3,
    LLVMDIFlagReservedBit4 = 1 << 4,
    LLVMDIFlagVirtual = 1 << 5,
    LLVMDIFlagArtificial = 1 << 6,
    LLVMDIFlagExplicit = 1 << 7,
    LLVMDIFlagPrototyped = 1 << 8,
    LLVMDIFlagObjcClassComplete = 1 << 9,
    LLVMDIFlagObjectPointer = 1 << 10,
    LLVMDIFlagVector = 1 << 11,
    LLVMDIFlagStaticMember = 1 << 12,
    LLVMDIFlagLValueReference = 1 << 13,
    LLVMDIFlagRValueReference = 1 << 14,
    LLVMDIFlagReserved = 1 << 15,
    LLVMDIFlagSingleInheritance = 1 << 16,
    LLVMDIFlagMultipleInheritance = 2 << 16,
    LLVMDIFlagVirtualInheritance = 3 << 16,
    LLVMDIFlagIntroducedVirtual = 1 << 18,
    LLVMDIFlagBitField = 1 << 19,
    LLVMDIFlagNoReturn = 1 << 20,
    LLVMDIFlagTypePassByValue = 1 << 22,
    LLVMDIFlagTypePassByReference = 1 << 23,
    LLVMDIFlagEnumClass = 1 << 24,
    LLVMDIFlagThunk = 1 << 25,
    LLVMDIFlagNonTrivial = 1 << 26,
    LLVMDIFlagBigEndian = 1 << 27,
    LLVMDIFlagLittleEndian = 1 << 28,
    LLVMDIFlagIndirectVirtualBase = (1 << 2) | (1 << 5),
};

pub const LLVMDWARFMacinfoRecordType = enum(c_int) {
    LLVMDWARFMacinfoRecordTypeDefine = 0x01,
    LLVMDWARFMacinfoRecordTypeMacro = 0x02,
    LLVMDWARFMacinfoRecordTypeStartFile = 0x03,
    LLVMDWARFMacinfoRecordTypeEndFile = 0x04,
    LLVMDWARFMacinfoRecordTypeVendorExt = 0xff,
};

pub const LLVMDWARFSourceLanguage = enum(c_int) {
    LLVMDWARFSourceLanguageC89,
    LLVMDWARFSourceLanguageC,
    LLVMDWARFSourceLanguageAda83,
    LLVMDWARFSourceLanguageC_plus_plus,
    LLVMDWARFSourceLanguageCobol74,
    LLVMDWARFSourceLanguageCobol85,
    LLVMDWARFSourceLanguageFortran77,
    LLVMDWARFSourceLanguageFortran90,
    LLVMDWARFSourceLanguagePascal83,
    LLVMDWARFSourceLanguageModula2,
    // New in DWARF v3:
    LLVMDWARFSourceLanguageJava,
    LLVMDWARFSourceLanguageC99,
    LLVMDWARFSourceLanguageAda95,
    LLVMDWARFSourceLanguageFortran95,
    LLVMDWARFSourceLanguagePLI,
    LLVMDWARFSourceLanguageObjC,
    LLVMDWARFSourceLanguageObjC_plus_plus,
    LLVMDWARFSourceLanguageUPC,
    LLVMDWARFSourceLanguageD,
    // New in DWARF v4:
    LLVMDWARFSourceLanguagePython,
    // New in DWARF v5:
    LLVMDWARFSourceLanguageOpenCL,
    LLVMDWARFSourceLanguageGo,
    LLVMDWARFSourceLanguageModula3,
    LLVMDWARFSourceLanguageHaskell,
    LLVMDWARFSourceLanguageC_plus_plus_03,
    LLVMDWARFSourceLanguageC_plus_plus_11,
    LLVMDWARFSourceLanguageOCaml,
    LLVMDWARFSourceLanguageRust,
    LLVMDWARFSourceLanguageC11,
    LLVMDWARFSourceLanguageSwift,
    LLVMDWARFSourceLanguageJulia,
    LLVMDWARFSourceLanguageDylan,
    LLVMDWARFSourceLanguageC_plus_plus_14,
    LLVMDWARFSourceLanguageFortran03,
    LLVMDWARFSourceLanguageFortran08,
    LLVMDWARFSourceLanguageRenderScript,
    LLVMDWARFSourceLanguageBLISS,
    LLVMDWARFSourceLanguageKotlin,
    LLVMDWARFSourceLanguageZig,
    LLVMDWARFSourceLanguageCrystal,
    LLVMDWARFSourceLanguageC_plus_plus_17,
    LLVMDWARFSourceLanguageC_plus_plus_20,
    LLVMDWARFSourceLanguageC17,
    LLVMDWARFSourceLanguageFortran18,
    LLVMDWARFSourceLanguageAda2005,
    LLVMDWARFSourceLanguageAda2012,
    // Vendor extensions:
    LLVMDWARFSourceLanguageMips_Assembler,
    LLVMDWARFSourceLanguageGOOGLE_RenderScript,
    LLVMDWARFSourceLanguageBORLAND_Delphi,
};

pub const LLVMDWARFEmissionKind = enum(c_int) {
    LLVMDWARFEmissionNone = 0,
    LLVMDWARFEmissionFull,
    LLVMDWARFEmissionLineTablesOnly,
};

pub const X = enum(c_int) {
    LLVMMDStringMetadataKind,
    LLVMConstantAsMetadataMetadataKind,
    LLVMLocalAsMetadataMetadataKind,
    LLVMDistinctMDOperandPlaceholderMetadataKind,
    LLVMMDTupleMetadataKind,
    LLVMDILocationMetadataKind,
    LLVMDIExpressionMetadataKind,
    LLVMDIGlobalVariableExpressionMetadataKind,
    LLVMGenericDINodeMetadataKind,
    LLVMDISubrangeMetadataKind,
    LLVMDIEnumeratorMetadataKind,
    LLVMDIBasicTypeMetadataKind,
    LLVMDIDerivedTypeMetadataKind,
    LLVMDICompositeTypeMetadataKind,
    LLVMDISubroutineTypeMetadataKind,
    LLVMDIFileMetadataKind,
    LLVMDICompileUnitMetadataKind,
    LLVMDISubprogramMetadataKind,
    LLVMDILexicalBlockMetadataKind,
    LLVMDILexicalBlockFileMetadataKind,
    LLVMDINamespaceMetadataKind,
    LLVMDIModuleMetadataKind,
    LLVMDITemplateTypeParameterMetadataKind,
    LLVMDITemplateValueParameterMetadataKind,
    LLVMDIGlobalVariableMetadataKind,
    LLVMDILocalVariableMetadataKind,
    LLVMDILabelMetadataKind,
    LLVMDIObjCPropertyMetadataKind,
    LLVMDIImportedEntityMetadataKind,
    LLVMDIMacroMetadataKind,
    LLVMDIMacroFileMetadataKind,
    LLVMDICommonBlockMetadataKind,
    LLVMDIStringTypeMetadataKind,
    LLVMDIGenericSubrangeMetadataKind,
    LLVMDIArgListMetadataKind,
    LLVMDIAssignIDMetadataKind,
};
// typedef unsigned LLVMMetadataKind;
// typedef unsigned LLVMDWARFTypeEncoding;
pub const LLVMMetadataKind = c_uint;
pub const LLVMDWARFTypeEncoding = c_uint;

// Analysis
pub const LLVMVerifierFailureAction = enum(c_int) {
    LLVMAbortProcessAction, // verifier will print to stderr and abort()
    LLVMPrintMessageAction, // verifier will print to stderr and return 1
    LLVMReturnStatusAction, // verifier will just return 1
};

// Object
pub const LLVMOpaqueSectionIterator = opaque {};
pub const LLVMSectionIteratorRef = ?*LLVMOpaqueSectionIterator;
pub const LLVMOpaqueSymbolIterator = opaque {};
pub const LLVMSymbolIteratorRef = ?*LLVMOpaqueSymbolIterator;
pub const LLVMOpaqueRelocationIterator = opaque {};
pub const LLVMRelocationIteratorRef = ?*LLVMOpaqueRelocationIterator;
pub const LLVMOpaqueObjectFile = opaque {};
pub const LLVMObjectFileRef = ?*LLVMOpaqueObjectFile;

// JIT
pub const LLVMOpaqueGenericValue = opaque {};
pub const LLVMGenericValueRef = ?*LLVMOpaqueGenericValue;
pub const LLVMOpaqueExecutionEngine = opaque {};
pub const LLVMExecutionEngineRef = ?*LLVMOpaqueExecutionEngine;
pub const LLVMOpaqueMCJITMemoryManager = opaque {};
pub const LLVMMCJITMemoryManagerRef = ?*LLVMOpaqueMCJITMemoryManager;
pub const LLVMOrcOpaqueLLJITBuilder = opaque {};
pub const LLVMOrcLLJITBuilderRef = ?*LLVMOrcOpaqueLLJITBuilder;
pub const LLVMOrcOpaqueLLJIT = opaque {};
pub const LLVMOrcLLJITRef = ?*LLVMOrcOpaqueLLJIT;

// Target
pub const LLVMOpaqueTargetData = opaque {};
pub const LLVMTargetDataRef = ?*LLVMOpaqueTargetData;
pub const LLVMOpaqueTargetLibraryInfotData = opaque {};
pub const LLVMTargetLibraryInfoRef = ?*LLVMOpaqueTargetLibraryInfotData;
pub const LLVMTarget = opaque {};
pub const LLVMTargetRef = ?*LLVMTarget;

// Target Machine
pub const LLVMOpaqueTargetMachine = opaque {};
pub const LLVMTargetMachineRef = ?*LLVMOpaqueTargetMachine;

pub const LLVMCodeGenOptLevel = enum(c_int) {
    LLVMCodeGenLevelNone,
    LLVMCodeGenLevelLess,
    LLVMCodeGenLevelDefault,
    LLVMCodeGenLevelAggressive,
};

pub const LLVMRelocMode = enum(c_int) {
    LLVMRelocDefault,
    LLVMRelocStatic,
    LLVMRelocPIC,
    LLVMRelocDynamicNoPic,
    LLVMRelocROPI,
    LLVMRelocRWPI,
    LLVMRelocROPI_RWPI,
};

pub const LLVMCodeModel = enum(c_int) {
    LLVMCodeModelDefault,
    LLVMCodeModelJITDefault,
    LLVMCodeModelTiny,
    LLVMCodeModelSmall,
    LLVMCodeModelKernel,
    LLVMCodeModelMedium,
    LLVMCodeModelLarge,
};

pub const LLVMCodeGenFileType = enum(c_int) {
    LLVMAssemblyFile,
    LLVMObjectFile,
};

// Linker
pub const LLVMLinkerMode = enum(c_int) {
    LLVMLinkerDestroySource = 0,
    LLVMLinkerPreserveSource_Removed = 1,
};
