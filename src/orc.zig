const LLVMtype = @import("types.zig");

pub const LLVMJITSymbolTargetFlags = u8;
pub const LLVMOrcJITTargetAddress = u64;
pub const LLVMOrcExecutorAddress = u64;

pub const LLVMJITSymbolGenericFlags = enum(c_int) {
    LLVMJITSymbolGenericFlagsNone = 0,
    LLVMJITSymbolGenericFlagsExported = 1 << 0,
    LLVMJITSymbolGenericFlagsWeak = 1 << 1,
    LLVMJITSymbolGenericFlagsCallable = 1 << 2,
    LLVMJITSymbolGenericFlagsMaterializationSideEffectsOnly = 1 << 3,
};

pub const LLVMJITSymbolFlags = extern struct {
    GenericFlags: u8,
    TargetFlags: u8,
};

pub const LLVMJITEvaluatedSymbol = extern struct {
    Address: LLVMOrcExecutorAddress,
    Flags: LLVMJITSymbolFlags,
};

pub const LLVMOrcOpaqueExecutionSession = opaque {};
pub const LLVMOrcExecutionSessionRef = ?*LLVMOrcOpaqueExecutionSession;
pub const LLVMOrcErrorReporterFunction = ?*const fn (?*anyopaque, LLVMtype.LLVMErrorRef) callconv(.C) void;
pub const LLVMOrcOpaqueSymbolStringPool = opaque {};
pub const LLVMOrcSymbolStringPoolRef = ?*LLVMOrcOpaqueSymbolStringPool;
pub const LLVMOrcOpaqueSymbolStringPoolEntry = opaque {};
pub const LLVMOrcSymbolStringPoolEntryRef = ?*LLVMOrcOpaqueSymbolStringPoolEntry;
pub const LLVMOrcCSymbolFlagsMapPair = extern struct {
    Name: LLVMOrcSymbolStringPoolEntryRef,
    Flags: LLVMJITSymbolFlags,
};
pub const LLVMOrcCSymbolFlagsMapPairs = [*c]LLVMOrcCSymbolFlagsMapPair;
pub const LLVMOrcCSymbolMapPair = extern struct {
    Name: LLVMOrcSymbolStringPoolEntryRef,
    Sym: LLVMJITEvaluatedSymbol,
};
pub const LLVMOrcCSymbolMapPairs = [*c]LLVMOrcCSymbolMapPair;
pub const LLVMOrcCSymbolAliasMapEntry = extern struct {
    Name: LLVMOrcSymbolStringPoolEntryRef,
    Flags: LLVMJITSymbolFlags,
};
pub const LLVMOrcCSymbolAliasMapPair = extern struct {
    Name: LLVMOrcSymbolStringPoolEntryRef,
    Entry: LLVMOrcCSymbolAliasMapEntry,
};
pub const LLVMOrcCSymbolAliasMapPairs = [*c]LLVMOrcCSymbolAliasMapPair;
pub const LLVMOrcOpaqueJITDylib = opaque {};
pub const LLVMOrcJITDylibRef = ?*LLVMOrcOpaqueJITDylib;
pub const LLVMOrcCSymbolsList = extern struct {
    Symbols: [*c]LLVMOrcSymbolStringPoolEntryRef,
    Length: usize,
};
pub const LLVMOrcCDependenceMapPair = extern struct {
    JD: LLVMOrcJITDylibRef,
    Names: LLVMOrcCSymbolsList,
};
pub const LLVMOrcCDependenceMapPairs = [*c]LLVMOrcCDependenceMapPair;
pub const LLVMOrcLookupKind = enum(c_int) {
    LLVMOrcLookupKindStatic,
    LLVMOrcLookupKindDLSym,
};

pub const LLVMOrcJITDylibLookupFlags = enum(c_int) {
    LLVMOrcJITDylibLookupFlagsMatchExportedSymbolsOnly,
    LLVMOrcJITDylibLookupFlagsMatchAllSymbols,
};
pub const LLVMOrcCJITDylibSearchOrderElement = extern struct {
    JD: LLVMOrcJITDylibRef,
    JDLookupFlags: LLVMOrcJITDylibLookupFlags,
};
pub const LLVMOrcCJITDylibSearchOrder = [*c]LLVMOrcCJITDylibSearchOrderElement;
pub const LLVMOrcSymbolLookupFlags = enum(c_int) {
    LLVMOrcSymbolLookupFlagsRequiredSymbol,
    LLVMOrcSymbolLookupFlagsWeaklyReferencedSymbol,
};
pub const LLVMOrcCLookupSetElement = extern struct {
    Name: LLVMOrcSymbolStringPoolEntryRef,
    LookupFlags: LLVMOrcSymbolLookupFlags,
};
pub const LLVMOrcCLookupSet = [*c]LLVMOrcCLookupSetElement;
pub const LLVMOrcOpaqueMaterializationUnit = opaque {};
pub const LLVMOrcMaterializationUnitRef = ?*LLVMOrcOpaqueMaterializationUnit;
pub const LLVMOrcOpaqueMaterializationResponsibility = opaque {};
pub const LLVMOrcMaterializationResponsibilityRef = ?*LLVMOrcOpaqueMaterializationResponsibility;
pub const LLVMOrcMaterializationUnitMaterializeFunction = ?*const fn (?*anyopaque, LLVMOrcMaterializationResponsibilityRef) callconv(.C) void;
pub const LLVMOrcMaterializationUnitDiscardFunction = ?*const fn (?*anyopaque, LLVMOrcJITDylibRef, LLVMOrcSymbolStringPoolEntryRef) callconv(.C) void;
pub const LLVMOrcMaterializationUnitDestroyFunction = ?*const fn (?*anyopaque) callconv(.C) void;
pub const LLVMOrcOpaqueResourceTracker = opaque {};
pub const LLVMOrcResourceTrackerRef = ?*LLVMOrcOpaqueResourceTracker;
pub const LLVMOrcOpaqueDefinitionGenerator = opaque {};
pub const LLVMOrcDefinitionGeneratorRef = ?*LLVMOrcOpaqueDefinitionGenerator;
pub const LLVMOrcOpaqueLookupState = opaque {};
pub const LLVMOrcLookupStateRef = ?*LLVMOrcOpaqueLookupState;
pub const LLVMOrcCAPIDefinitionGeneratorTryToGenerateFunction = ?*const fn (LLVMOrcDefinitionGeneratorRef, ?*anyopaque, [*c]LLVMOrcLookupStateRef, LLVMOrcLookupKind, LLVMOrcJITDylibRef, LLVMOrcJITDylibLookupFlags, LLVMOrcCLookupSet, usize) callconv(.C) LLVMtype.LLVMErrorRef;
pub const LLVMOrcDisposeCAPIDefinitionGeneratorFunction = ?*const fn (?*anyopaque) callconv(.C) void;
pub const LLVMOrcSymbolPredicate = ?*const fn (?*anyopaque, LLVMOrcSymbolStringPoolEntryRef) callconv(.C) c_int;
pub const LLVMOrcOpaqueThreadSafeContext = opaque {};
pub const LLVMOrcThreadSafeContextRef = ?*LLVMOrcOpaqueThreadSafeContext;
pub const LLVMOrcOpaqueThreadSafeModule = opaque {};
pub const LLVMOrcThreadSafeModuleRef = ?*LLVMOrcOpaqueThreadSafeModule;
pub const LLVMOrcGenericIRModuleOperationFunction = ?*const fn (?*anyopaque, LLVMtype.LLVMModuleRef) callconv(.C) LLVMtype.LLVMErrorRef;
pub const LLVMOrcOpaqueJITTargetMachineBuilder = opaque {};
pub const LLVMOrcJITTargetMachineBuilderRef = ?*LLVMOrcOpaqueJITTargetMachineBuilder;
pub const LLVMOrcOpaqueObjectLayer = opaque {};
pub const LLVMOrcObjectLayerRef = ?*LLVMOrcOpaqueObjectLayer;
pub const LLVMOrcOpaqueObjectLinkingLayer = opaque {};
pub const LLVMOrcObjectLinkingLayerRef = ?*LLVMOrcOpaqueObjectLinkingLayer;
pub const LLVMOrcOpaqueIRTransformLayer = opaque {};
pub const LLVMOrcIRTransformLayerRef = ?*LLVMOrcOpaqueIRTransformLayer;
pub const LLVMOrcIRTransformLayerTransformFunction = ?*const fn (?*anyopaque, [*c]LLVMOrcThreadSafeModuleRef, LLVMOrcMaterializationResponsibilityRef) callconv(.C) LLVMtype.LLVMErrorRef;
pub const LLVMOrcOpaqueObjectTransformLayer = opaque {};
pub const LLVMOrcObjectTransformLayerRef = ?*LLVMOrcOpaqueObjectTransformLayer;
pub const LLVMOrcObjectTransformLayerTransformFunction = ?*const fn (?*anyopaque, [*c]LLVMtype.LLVMMemoryBufferRef) callconv(.C) LLVMtype.LLVMErrorRef;
pub const LLVMOrcOpaqueIndirectStubsManager = opaque {};
pub const LLVMOrcIndirectStubsManagerRef = ?*LLVMOrcOpaqueIndirectStubsManager;
pub const LLVMOrcOpaqueLazyCallThroughManager = opaque {};
pub const LLVMOrcLazyCallThroughManagerRef = ?*LLVMOrcOpaqueLazyCallThroughManager;
pub const LLVMOrcOpaqueDumpObjects = opaque {};
pub const LLVMOrcDumpObjectsRef = ?*LLVMOrcOpaqueDumpObjects;
pub extern fn LLVMOrcExecutionSessionSetErrorReporter(ES: LLVMOrcExecutionSessionRef, ReportError: LLVMOrcErrorReporterFunction, Ctx: ?*anyopaque) void;
pub extern fn LLVMOrcExecutionSessionGetSymbolStringPool(ES: LLVMOrcExecutionSessionRef) LLVMOrcSymbolStringPoolRef;
pub extern fn LLVMOrcSymbolStringPoolClearDeadEntries(SSP: LLVMOrcSymbolStringPoolRef) void;
pub extern fn LLVMOrcExecutionSessionIntern(ES: LLVMOrcExecutionSessionRef, Name: [*c]const u8) LLVMOrcSymbolStringPoolEntryRef;
pub const LLVMOrcExecutionSessionLookupHandleResultFunction = ?*const fn (LLVMtype.LLVMErrorRef, LLVMOrcCSymbolMapPairs, usize, ?*anyopaque) callconv(.C) void;
pub extern fn LLVMOrcExecutionSessionLookup(ES: LLVMOrcExecutionSessionRef, K: LLVMOrcLookupKind, SearchOrder: LLVMOrcCJITDylibSearchOrder, SearchOrderSize: usize, Symbols: LLVMOrcCLookupSet, SymbolsSize: usize, HandleResult: LLVMOrcExecutionSessionLookupHandleResultFunction, Ctx: ?*anyopaque) void;
pub extern fn LLVMOrcRetainSymbolStringPoolEntry(S: LLVMOrcSymbolStringPoolEntryRef) void;
pub extern fn LLVMOrcReleaseSymbolStringPoolEntry(S: LLVMOrcSymbolStringPoolEntryRef) void;
pub extern fn LLVMOrcSymbolStringPoolEntryStr(S: LLVMOrcSymbolStringPoolEntryRef) [*c]const u8;
pub extern fn LLVMOrcReleaseResourceTracker(RT: LLVMOrcResourceTrackerRef) void;
pub extern fn LLVMOrcResourceTrackerTransferTo(SrcRT: LLVMOrcResourceTrackerRef, DstRT: LLVMOrcResourceTrackerRef) void;
pub extern fn LLVMOrcResourceTrackerRemove(RT: LLVMOrcResourceTrackerRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcDisposeDefinitionGenerator(DG: LLVMOrcDefinitionGeneratorRef) void;
pub extern fn LLVMOrcDisposeMaterializationUnit(MU: LLVMOrcMaterializationUnitRef) void;
pub extern fn LLVMOrcCreateCustomMaterializationUnit(Name: [*c]const u8, Ctx: ?*anyopaque, Syms: LLVMOrcCSymbolFlagsMapPairs, NumSyms: usize, InitSym: LLVMOrcSymbolStringPoolEntryRef, Materialize: LLVMOrcMaterializationUnitMaterializeFunction, Discard: LLVMOrcMaterializationUnitDiscardFunction, Destroy: LLVMOrcMaterializationUnitDestroyFunction) LLVMOrcMaterializationUnitRef;
pub extern fn LLVMOrcAbsoluteSymbols(Syms: LLVMOrcCSymbolMapPairs, NumPairs: usize) LLVMOrcMaterializationUnitRef;
pub extern fn LLVMOrcLazyReexports(LCTM: LLVMOrcLazyCallThroughManagerRef, ISM: LLVMOrcIndirectStubsManagerRef, SourceRef: LLVMOrcJITDylibRef, CallableAliases: LLVMOrcCSymbolAliasMapPairs, NumPairs: usize) LLVMOrcMaterializationUnitRef;
pub extern fn LLVMOrcDisposeMaterializationResponsibility(MR: LLVMOrcMaterializationResponsibilityRef) void;
pub extern fn LLVMOrcMaterializationResponsibilityGetTargetDylib(MR: LLVMOrcMaterializationResponsibilityRef) LLVMOrcJITDylibRef;
pub extern fn LLVMOrcMaterializationResponsibilityGetExecutionSession(MR: LLVMOrcMaterializationResponsibilityRef) LLVMOrcExecutionSessionRef;
pub extern fn LLVMOrcMaterializationResponsibilityGetSymbols(MR: LLVMOrcMaterializationResponsibilityRef, NumPairs: [*c]usize) LLVMOrcCSymbolFlagsMapPairs;
pub extern fn LLVMOrcDisposeCSymbolFlagsMap(Pairs: LLVMOrcCSymbolFlagsMapPairs) void;
pub extern fn LLVMOrcMaterializationResponsibilityGetInitializerSymbol(MR: LLVMOrcMaterializationResponsibilityRef) LLVMOrcSymbolStringPoolEntryRef;
pub extern fn LLVMOrcMaterializationResponsibilityGetRequestedSymbols(MR: LLVMOrcMaterializationResponsibilityRef, NumSymbols: [*c]usize) [*c]LLVMOrcSymbolStringPoolEntryRef;
pub extern fn LLVMOrcDisposeSymbols(Symbols: [*c]LLVMOrcSymbolStringPoolEntryRef) void;
pub extern fn LLVMOrcMaterializationResponsibilityNotifyResolved(MR: LLVMOrcMaterializationResponsibilityRef, Symbols: LLVMOrcCSymbolMapPairs, NumPairs: usize) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcMaterializationResponsibilityNotifyEmitted(MR: LLVMOrcMaterializationResponsibilityRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcMaterializationResponsibilityDefineMaterializing(MR: LLVMOrcMaterializationResponsibilityRef, Pairs: LLVMOrcCSymbolFlagsMapPairs, NumPairs: usize) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcMaterializationResponsibilityFailMaterialization(MR: LLVMOrcMaterializationResponsibilityRef) void;
pub extern fn LLVMOrcMaterializationResponsibilityReplace(MR: LLVMOrcMaterializationResponsibilityRef, MU: LLVMOrcMaterializationUnitRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcMaterializationResponsibilityDelegate(MR: LLVMOrcMaterializationResponsibilityRef, Symbols: [*c]LLVMOrcSymbolStringPoolEntryRef, NumSymbols: usize, Result: [*c]LLVMOrcMaterializationResponsibilityRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcMaterializationResponsibilityAddDependencies(MR: LLVMOrcMaterializationResponsibilityRef, Name: LLVMOrcSymbolStringPoolEntryRef, Dependencies: LLVMOrcCDependenceMapPairs, NumPairs: usize) void;
pub extern fn LLVMOrcMaterializationResponsibilityAddDependenciesForAll(MR: LLVMOrcMaterializationResponsibilityRef, Dependencies: LLVMOrcCDependenceMapPairs, NumPairs: usize) void;
pub extern fn LLVMOrcExecutionSessionCreateBareJITDylib(ES: LLVMOrcExecutionSessionRef, Name: [*c]const u8) LLVMOrcJITDylibRef;
pub extern fn LLVMOrcExecutionSessionCreateJITDylib(ES: LLVMOrcExecutionSessionRef, Result: [*c]LLVMOrcJITDylibRef, Name: [*c]const u8) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcExecutionSessionGetJITDylibByName(ES: LLVMOrcExecutionSessionRef, Name: [*c]const u8) LLVMOrcJITDylibRef;
pub extern fn LLVMOrcJITDylibCreateResourceTracker(JD: LLVMOrcJITDylibRef) LLVMOrcResourceTrackerRef;
pub extern fn LLVMOrcJITDylibGetDefaultResourceTracker(JD: LLVMOrcJITDylibRef) LLVMOrcResourceTrackerRef;
pub extern fn LLVMOrcJITDylibDefine(JD: LLVMOrcJITDylibRef, MU: LLVMOrcMaterializationUnitRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcJITDylibClear(JD: LLVMOrcJITDylibRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcJITDylibAddGenerator(JD: LLVMOrcJITDylibRef, DG: LLVMOrcDefinitionGeneratorRef) void;
pub extern fn LLVMOrcCreateCustomCAPIDefinitionGenerator(F: LLVMOrcCAPIDefinitionGeneratorTryToGenerateFunction, Ctx: ?*anyopaque, Dispose: LLVMOrcDisposeCAPIDefinitionGeneratorFunction) LLVMOrcDefinitionGeneratorRef;
pub extern fn LLVMOrcLookupStateContinueLookup(S: LLVMOrcLookupStateRef, Err: LLVMtype.LLVMErrorRef) void;
pub extern fn LLVMOrcCreateDynamicLibrarySearchGeneratorForProcess(Result: [*c]LLVMOrcDefinitionGeneratorRef, GlobalPrefx: u8, Filter: LLVMOrcSymbolPredicate, FilterCtx: ?*anyopaque) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcCreateDynamicLibrarySearchGeneratorForPath(Result: [*c]LLVMOrcDefinitionGeneratorRef, FileName: [*c]const u8, GlobalPrefix: u8, Filter: LLVMOrcSymbolPredicate, FilterCtx: ?*anyopaque) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcCreateStaticLibrarySearchGeneratorForPath(Result: [*c]LLVMOrcDefinitionGeneratorRef, ObjLayer: LLVMOrcObjectLayerRef, FileName: [*c]const u8, TargetTriple: [*c]const u8) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcCreateNewThreadSafeContext() LLVMOrcThreadSafeContextRef;
pub extern fn LLVMOrcThreadSafeContextGetContext(TSCtx: LLVMOrcThreadSafeContextRef) LLVMtype.LLVMContextRef;
pub extern fn LLVMOrcDisposeThreadSafeContext(TSCtx: LLVMOrcThreadSafeContextRef) void;
pub extern fn LLVMOrcCreateNewThreadSafeModule(M: LLVMtype.LLVMModuleRef, TSCtx: LLVMOrcThreadSafeContextRef) LLVMOrcThreadSafeModuleRef;
pub extern fn LLVMOrcDisposeThreadSafeModule(TSM: LLVMOrcThreadSafeModuleRef) void;
pub extern fn LLVMOrcThreadSafeModuleWithModuleDo(TSM: LLVMOrcThreadSafeModuleRef, F: LLVMOrcGenericIRModuleOperationFunction, Ctx: ?*anyopaque) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcJITTargetMachineBuilderDetectHost(Result: [*c]LLVMOrcJITTargetMachineBuilderRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcJITTargetMachineBuilderCreateFromTargetMachine(TM: LLVMtype.LLVMTargetMachineRef) LLVMOrcJITTargetMachineBuilderRef;
pub extern fn LLVMOrcDisposeJITTargetMachineBuilder(JTMB: LLVMOrcJITTargetMachineBuilderRef) void;
pub extern fn LLVMOrcJITTargetMachineBuilderGetTargetTriple(JTMB: LLVMOrcJITTargetMachineBuilderRef) [*c]u8;
pub extern fn LLVMOrcJITTargetMachineBuilderSetTargetTriple(JTMB: LLVMOrcJITTargetMachineBuilderRef, TargetTriple: [*c]const u8) void;
pub extern fn LLVMOrcObjectLayerAddObjectFile(ObjLayer: LLVMOrcObjectLayerRef, JD: LLVMOrcJITDylibRef, ObjBuffer: LLVMtype.LLVMMemoryBufferRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcObjectLayerAddObjectFileWithRT(ObjLayer: LLVMOrcObjectLayerRef, RT: LLVMOrcResourceTrackerRef, ObjBuffer: LLVMtype.LLVMMemoryBufferRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcObjectLayerEmit(ObjLayer: LLVMOrcObjectLayerRef, R: LLVMOrcMaterializationResponsibilityRef, ObjBuffer: LLVMtype.LLVMMemoryBufferRef) void;
pub extern fn LLVMOrcDisposeObjectLayer(ObjLayer: LLVMOrcObjectLayerRef) void;
pub extern fn LLVMOrcIRTransformLayerEmit(IRTransformLayer: LLVMOrcIRTransformLayerRef, MR: LLVMOrcMaterializationResponsibilityRef, TSM: LLVMOrcThreadSafeModuleRef) void;
pub extern fn LLVMOrcIRTransformLayerSetTransform(IRTransformLayer: LLVMOrcIRTransformLayerRef, TransformFunction: LLVMOrcIRTransformLayerTransformFunction, Ctx: ?*anyopaque) void;
pub extern fn LLVMOrcObjectTransformLayerSetTransform(ObjTransformLayer: LLVMOrcObjectTransformLayerRef, TransformFunction: LLVMOrcObjectTransformLayerTransformFunction, Ctx: ?*anyopaque) void;
pub extern fn LLVMOrcCreateLocalIndirectStubsManager(TargetTriple: [*c]const u8) LLVMOrcIndirectStubsManagerRef;
pub extern fn LLVMOrcDisposeIndirectStubsManager(ISM: LLVMOrcIndirectStubsManagerRef) void;
pub extern fn LLVMOrcCreateLocalLazyCallThroughManager(TargetTriple: [*c]const u8, ES: LLVMOrcExecutionSessionRef, ErrorHandlerAddr: LLVMOrcJITTargetAddress, LCTM: [*c]LLVMOrcLazyCallThroughManagerRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcDisposeLazyCallThroughManager(LCTM: LLVMOrcLazyCallThroughManagerRef) void;
pub extern fn LLVMOrcCreateDumpObjects(DumpDir: [*c]const u8, IdentifierOverride: [*c]const u8) LLVMOrcDumpObjectsRef;
pub extern fn LLVMOrcDisposeDumpObjects(DumpObjects: LLVMOrcDumpObjectsRef) void;
pub extern fn LLVMOrcDumpObjects_CallOperator(DumpObjects: LLVMOrcDumpObjectsRef, ObjBuffer: [*c]LLVMtype.LLVMMemoryBufferRef) LLVMtype.LLVMErrorRef;
