const LLVMtype = @import("types.zig");

pub extern fn LLVMAddAnalysisPasses(T: LLVMtype.LLVMTargetMachineRef, PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMLinkInMCJIT() void;
pub extern fn LLVMLinkInInterpreter() void;

pub const LLVMMCJITCompilerOptions = extern struct {
    OptLevel: c_uint,
    CodeModel: LLVMtype.LLVMCodeModel,
    NoFramePointerElim: LLVMtype.LLVMBool,
    EnableFastISel: LLVMtype.LLVMBool,
    MCJMM: LLVMtype.LLVMMCJITMemoryManagerRef,
};
pub extern fn LLVMCreateGenericValueOfInt(Ty: LLVMtype.LLVMTypeRef, N: c_ulonglong, IsSigned: LLVMtype.LLVMBool) LLVMtype.LLVMGenericValueRef;
pub extern fn LLVMCreateGenericValueOfPointer(P: ?*anyopaque) LLVMtype.LLVMGenericValueRef;
pub extern fn LLVMCreateGenericValueOfFloat(Ty: LLVMtype.LLVMTypeRef, N: f64) LLVMtype.LLVMGenericValueRef;
pub extern fn LLVMGenericValueIntWidth(GenValRef: LLVMtype.LLVMGenericValueRef) c_uint;
pub extern fn LLVMGenericValueToInt(GenVal: LLVMtype.LLVMGenericValueRef, IsSigned: LLVMtype.LLVMBool) c_ulonglong;
pub extern fn LLVMGenericValueToPointer(GenVal: LLVMtype.LLVMGenericValueRef) ?*anyopaque;
pub extern fn LLVMGenericValueToFloat(TyRef: LLVMtype.LLVMTypeRef, GenVal: LLVMtype.LLVMGenericValueRef) f64;
pub extern fn LLVMDisposeGenericValue(GenVal: LLVMtype.LLVMGenericValueRef) void;
pub extern fn LLVMCreateExecutionEngineForModule(OutEE: [*c]LLVMtype.LLVMExecutionEngineRef, M: LLVMtype.LLVMModuleRef, OutError: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMCreateInterpreterForModule(OutInterp: [*c]LLVMtype.LLVMExecutionEngineRef, M: LLVMtype.LLVMModuleRef, OutError: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMCreateJITCompilerForModule(OutJIT: [*c]LLVMtype.LLVMExecutionEngineRef, M: LLVMtype.LLVMModuleRef, OptLevel: c_uint, OutError: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMInitializeMCJITCompilerOptions(Options: [*c]LLVMMCJITCompilerOptions, SizeOfOptions: usize) void;
pub extern fn LLVMCreateMCJITCompilerForModule(OutJIT: [*c]LLVMtype.LLVMExecutionEngineRef, M: LLVMtype.LLVMModuleRef, Options: [*c]LLVMMCJITCompilerOptions, SizeOfOptions: usize, OutError: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMDisposeExecutionEngine(EE: LLVMtype.LLVMExecutionEngineRef) void;
pub extern fn LLVMRunStaticConstructors(EE: LLVMtype.LLVMExecutionEngineRef) void;
pub extern fn LLVMRunStaticDestructors(EE: LLVMtype.LLVMExecutionEngineRef) void;
pub extern fn LLVMRunFunctionAsMain(EE: LLVMtype.LLVMExecutionEngineRef, F: LLVMtype.LLVMValueRef, ArgC: c_uint, ArgV: [*c]const [*c]const u8, EnvP: [*c]const [*c]const u8) c_int;
pub extern fn LLVMRunFunction(EE: LLVMtype.LLVMExecutionEngineRef, F: LLVMtype.LLVMValueRef, NumArgs: c_uint, Args: [*c]LLVMtype.LLVMGenericValueRef) LLVMtype.LLVMGenericValueRef;
pub extern fn LLVMFreeMachineCodeForFunction(EE: LLVMtype.LLVMExecutionEngineRef, F: LLVMtype.LLVMValueRef) void;
pub extern fn LLVMAddModule(EE: LLVMtype.LLVMExecutionEngineRef, M: LLVMtype.LLVMModuleRef) void;
pub extern fn LLVMRemoveModule(EE: LLVMtype.LLVMExecutionEngineRef, M: LLVMtype.LLVMModuleRef, OutMod: [*c]LLVMtype.LLVMModuleRef, OutError: [*c][*c]u8) LLVMtype.LLVMBool;
pub extern fn LLVMFindFunction(EE: LLVMtype.LLVMExecutionEngineRef, Name: [*c]const u8, OutFn: [*c]LLVMtype.LLVMValueRef) LLVMtype.LLVMBool;
pub extern fn LLVMRecompileAndRelinkFunction(EE: LLVMtype.LLVMExecutionEngineRef, Fn: LLVMtype.LLVMValueRef) ?*anyopaque;
pub extern fn LLVMGetExecutionEngineTargetData(EE: LLVMtype.LLVMExecutionEngineRef) LLVMtype.LLVMTargetDataRef;
pub extern fn LLVMGetExecutionEngineTargetMachine(EE: LLVMtype.LLVMExecutionEngineRef) LLVMtype.LLVMTargetMachineRef;
pub extern fn LLVMAddGlobalMapping(EE: LLVMtype.LLVMExecutionEngineRef, Global: LLVMtype.LLVMValueRef, Addr: ?*anyopaque) void;
pub extern fn LLVMGetPointerToGlobal(EE: LLVMtype.LLVMExecutionEngineRef, Global: LLVMtype.LLVMValueRef) ?*anyopaque;
pub extern fn LLVMGetGlobalValueAddress(EE: LLVMtype.LLVMExecutionEngineRef, Name: [*c]const u8) u64;
pub extern fn LLVMGetFunctionAddress(EE: LLVMtype.LLVMExecutionEngineRef, Name: [*c]const u8) u64;
pub extern fn LLVMExecutionEngineGetErrMsg(EE: LLVMtype.LLVMExecutionEngineRef, OutError: [*c][*c]u8) LLVMtype.LLVMBool;
pub const LLVMMemoryManagerAllocateCodeSectionCallback = ?*const fn (?*anyopaque, usize, c_uint, c_uint, [*c]const u8) callconv(.C) [*c]u8;
pub const LLVMMemoryManagerAllocateDataSectionCallback = ?*const fn (?*anyopaque, usize, c_uint, c_uint, [*c]const u8, LLVMtype.LLVMBool) callconv(.C) [*c]u8;
pub const LLVMMemoryManagerFinalizeMemoryCallback = ?*const fn (?*anyopaque, [*c][*c]u8) callconv(.C) LLVMtype.LLVMBool;
pub const LLVMMemoryManagerDestroyCallback = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn LLVMCreateSimpleMCJITMemoryManager(Opaque: ?*anyopaque, AllocateCodeSection: LLVMMemoryManagerAllocateCodeSectionCallback, AllocateDataSection: LLVMMemoryManagerAllocateDataSectionCallback, FinalizeMemory: LLVMMemoryManagerFinalizeMemoryCallback, Destroy: LLVMMemoryManagerDestroyCallback) LLVMtype.LLVMMCJITMemoryManagerRef;
pub extern fn LLVMDisposeMCJITMemoryManager(MM: LLVMtype.LLVMMCJITMemoryManagerRef) void;
pub extern fn LLVMCreateGDBRegistrationListener() LLVMtype.LLVMJITEventListenerRef;
pub extern fn LLVMCreateIntelJITEventListener() LLVMtype.LLVMJITEventListenerRef;
pub extern fn LLVMCreateOProfileJITEventListener() LLVMtype.LLVMJITEventListenerRef;
pub extern fn LLVMCreatePerfJITEventListener() LLVMtype.LLVMJITEventListenerRef;
