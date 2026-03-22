const LLVMtype = @import("types.zig");

/// Construct and run a set of passes over a module.
pub extern fn LLVMRunPasses(M: LLVMtype.LLVMModuleRef, Passes: [*:0]const u8, TM: LLVMtype.LLVMTargetMachineRef, Options: LLVMtype.LLVMPassBuilderOptionsRef) LLVMtype.LLVMErrorRef;

/// Construct and run a set of passes over a single function.
pub extern fn LLVMRunPassesOnFunction(F: LLVMtype.LLVMValueRef, Passes: [*:0]const u8, TM: LLVMtype.LLVMTargetMachineRef, Options: LLVMtype.LLVMPassBuilderOptionsRef) LLVMtype.LLVMErrorRef;

/// Create a new set of options for a PassBuilder.
pub extern fn LLVMCreatePassBuilderOptions() LLVMtype.LLVMPassBuilderOptionsRef;

pub extern fn LLVMPassBuilderOptionsSetVerifyEach(Options: LLVMtype.LLVMPassBuilderOptionsRef, VerifyEach: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetDebugLogging(Options: LLVMtype.LLVMPassBuilderOptionsRef, DebugLogging: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetAAPipeline(Options: LLVMtype.LLVMPassBuilderOptionsRef, AAPipeline: [*:0]const u8) void;
pub extern fn LLVMPassBuilderOptionsSetLoopInterleaving(Options: LLVMtype.LLVMPassBuilderOptionsRef, LoopInterleaving: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetLoopVectorization(Options: LLVMtype.LLVMPassBuilderOptionsRef, LoopVectorization: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetSLPVectorization(Options: LLVMtype.LLVMPassBuilderOptionsRef, SLPVectorization: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetLoopUnrolling(Options: LLVMtype.LLVMPassBuilderOptionsRef, LoopUnrolling: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetForgetAllSCEVInLoopUnroll(Options: LLVMtype.LLVMPassBuilderOptionsRef, ForgetAllSCEVInLoopUnroll: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetLicmMssaOptCap(Options: LLVMtype.LLVMPassBuilderOptionsRef, LicmMssaOptCap: c_uint) void;
pub extern fn LLVMPassBuilderOptionsSetLicmMssaNoAccForPromotionCap(Options: LLVMtype.LLVMPassBuilderOptionsRef, LicmMssaNoAccForPromotionCap: c_uint) void;
pub extern fn LLVMPassBuilderOptionsSetCallGraphProfile(Options: LLVMtype.LLVMPassBuilderOptionsRef, CallGraphProfile: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetMergeFunctions(Options: LLVMtype.LLVMPassBuilderOptionsRef, MergeFunctions: LLVMtype.LLVMBool) void;
pub extern fn LLVMPassBuilderOptionsSetInlinerThreshold(Options: LLVMtype.LLVMPassBuilderOptionsRef, Threshold: c_int) void;

/// Dispose of a heap-allocated PassBuilderOptions instance.
pub extern fn LLVMDisposePassBuilderOptions(Options: LLVMtype.LLVMPassBuilderOptionsRef) void;
