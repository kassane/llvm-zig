const LLVMtype = @import("types.zig");

pub extern fn LLVMAddLowerSwitchPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddPromoteMemoryToRegisterPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LVMAddLoopVectorizePass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddSLPVectorizePass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddConstantMergePass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddMergeFunctionsPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddCalledValuePropagationPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddDeadArgEliminationPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddFunctionAttrsPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddFunctionInliningPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddAlwaysInlinerPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddGlobalDCEPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddGlobalOptimizerPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddIPSCCPPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddInternalizePass(PM: LLVMtype.LLVMPassManagerRef, AllButMain: usize) void;
pub extern fn LLVMAddStripDeadPrototypesPass(PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMAddStripSymbolsPass(PM: LLVMtype.LLVMPassManagerRef) void;
