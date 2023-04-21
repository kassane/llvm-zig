const LLVMtype = @import("types.zig");
const LLVMorc = @import("orc.zig");

pub extern fn LLVMAddAnalysisPasses(T: LLVMtype.LLVMTargetMachineRef, PM: LLVMtype.LLVMPassManagerRef) void;
pub const LLVMOrcJITTargetAddress = u64;
pub const LLVMOrcExecutorAddress = u64;
pub const LLVMJITSymbolGenericFlagsNone: c_int = 0;
pub const LLVMJITSymbolGenericFlagsExported: c_int = 1;
pub const LLVMJITSymbolGenericFlagsWeak: c_int = 2;
pub const LLVMJITSymbolGenericFlagsCallable: c_int = 4;
pub const LLVMJITSymbolGenericFlagsMaterializationSideEffectsOnly: c_int = 8;
pub const LLVMJITSymbolGenericFlags = c_uint;
pub const LLVMJITSymbolTargetFlags = u8;
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
pub const LLVMOrcLookupKindStatic: c_int = 0;
pub const LLVMOrcLookupKindDLSym: c_int = 1;
pub const LLVMOrcLookupKind = c_uint;
pub const LLVMOrcJITDylibLookupFlagsMatchExportedSymbolsOnly: c_int = 0;
pub const LLVMOrcJITDylibLookupFlagsMatchAllSymbols: c_int = 1;
pub const LLVMOrcJITDylibLookupFlags = c_uint;
pub const LLVMOrcCJITDylibSearchOrderElement = extern struct {
    JD: LLVMOrcJITDylibRef,
    JDLookupFlags: LLVMOrcJITDylibLookupFlags,
};
pub const LLVMOrcCJITDylibSearchOrder = [*c]LLVMOrcCJITDylibSearchOrderElement;
pub const LLVMOrcSymbolLookupFlagsRequiredSymbol: c_int = 0;
pub const LLVMOrcSymbolLookupFlagsWeaklyReferencedSymbol: c_int = 1;
pub const LLVMOrcSymbolLookupFlags = c_uint;
pub const LLVMOrcCLookupSetElement = extern struct {
    Name: LLVMOrcSymbolStringPoolEntryRef,
    LookupFlags: LLVMOrcSymbolLookupFlags,
};

pub const LLVMOrcLLJITBuilderObjectLinkingLayerCreatorFunction = ?*const fn (?*anyopaque, LLVMOrcExecutionSessionRef, [*c]const u8) callconv(.C) LLVMorc.LLVMOrcObjectLayerRef;
pub const LLVMOrcOpaqueLLJITBuilder = opaque {};
pub const LLVMOrcLLJITBuilderRef = ?*LLVMOrcOpaqueLLJITBuilder;
pub const LLVMOrcOpaqueLLJIT = opaque {};
pub const LLVMOrcLLJITRef = ?*LLVMOrcOpaqueLLJIT;
pub extern fn LLVMOrcCreateLLJITBuilder() LLVMorc.LLVMOrcLLJITBuilderRef;
pub extern fn LLVMOrcDisposeLLJITBuilder(Builder: LLVMOrcLLJITBuilderRef) void;
pub extern fn LLVMOrcLLJITBuilderSetJITTargetMachineBuilder(Builder: LLVMOrcLLJITBuilderRef, JTMB: LLVMorc.LLVMOrcJITTargetMachineBuilderRef) void;
pub extern fn LLVMOrcLLJITBuilderSetObjectLinkingLayerCreator(Builder: LLVMOrcLLJITBuilderRef, F: LLVMOrcLLJITBuilderObjectLinkingLayerCreatorFunction, Ctx: ?*anyopaque) void;
pub extern fn LLVMOrcCreateLLJIT(Result: [*c]LLVMOrcLLJITRef, Builder: LLVMOrcLLJITBuilderRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcDisposeLLJIT(J: LLVMOrcLLJITRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcLLJITGetExecutionSession(J: LLVMOrcLLJITRef) LLVMorc.LLVMOrcExecutionSessionRef;
pub extern fn LLVMOrcLLJITGetMainJITDylib(J: LLVMOrcLLJITRef) LLVMorc.LLVMOrcJITDylibRef;
pub extern fn LLVMOrcLLJITGetTripleString(J: LLVMOrcLLJITRef) [*c]const u8;
pub extern fn LLVMOrcLLJITGetGlobalPrefix(J: LLVMOrcLLJITRef) u8;
pub extern fn LLVMOrcLLJITMangleAndIntern(J: LLVMOrcLLJITRef, UnmangledName: [*c]const u8) LLVMorc.LLVMOrcSymbolStringPoolEntryRef;
pub extern fn LLVMOrcLLJITAddObjectFile(J: LLVMOrcLLJITRef, JD: LLVMOrcJITDylibRef, ObjBuffer: LLVMtype.LLVMMemoryBufferRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcLLJITAddObjectFileWithRT(J: LLVMOrcLLJITRef, RT: LLVMorc.LLVMOrcResourceTrackerRef, ObjBuffer: LLVMtype.LLVMMemoryBufferRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcLLJITAddLLVMIRModule(J: LLVMOrcLLJITRef, JD: LLVMOrcJITDylibRef, TSM: LLVMorc.LLVMOrcThreadSafeModuleRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcLLJITAddLLVMIRModuleWithRT(J: LLVMOrcLLJITRef, JD: LLVMorc.LLVMOrcResourceTrackerRef, TSM: LLVMorc.LLVMOrcThreadSafeModuleRef) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcLLJITLookup(J: LLVMOrcLLJITRef, Result: [*c]LLVMOrcExecutorAddress, Name: [*c]const u8) LLVMtype.LLVMErrorRef;
pub extern fn LLVMOrcLLJITGetObjLinkingLayer(J: LLVMOrcLLJITRef) LLVMorc.LLVMOrcObjectLayerRef;
pub extern fn LLVMOrcLLJITGetObjTransformLayer(J: LLVMOrcLLJITRef) LLVMorc.LLVMOrcObjectTransformLayerRef;
pub extern fn LLVMOrcLLJITGetIRTransformLayer(J: LLVMOrcLLJITRef) LLVMorc.LLVMOrcIRTransformLayerRef;
pub extern fn LLVMOrcLLJITGetDataLayoutStr(J: LLVMOrcLLJITRef) [*c]const u8;
