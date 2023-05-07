const LLVMtype = @import("types.zig");
const Orc = @import("orc.zig");
const Event = @import("executionEngine.zig");

pub const LLVMMemoryManagerCreateContextCallback = ?*const fn (?*anyopaque) callconv(.C) ?*anyopaque;
pub const LLVMMemoryManagerNotifyTerminatingCallback = ?*const fn (?*anyopaque) callconv(.C) void;
pub extern fn LLVMOrcCreateRTDyldObjectLinkingLayerWithSectionMemoryManager(ES: Orc.LLVMOrcExecutionSessionRef) Orc.LLVMOrcObjectLayerRef;
pub extern fn LLVMOrcCreateRTDyldObjectLinkingLayerWithMCJITMemoryManagerLikeCallbacks(ES: Orc.LLVMOrcExecutionSessionRef, CreateContextCtx: ?*anyopaque, CreateContext: LLVMMemoryManagerCreateContextCallback, NotifyTerminating: LLVMMemoryManagerNotifyTerminatingCallback, AllocateCodeSection: Event.LLVMMemoryManagerAllocateCodeSectionCallback, AllocateDataSection: Event.LLVMMemoryManagerAllocateDataSectionCallback, FinalizeMemory: Event.LLVMMemoryManagerFinalizeMemoryCallback, Destroy: Event.LLVMMemoryManagerDestroyCallback) Orc.LLVMOrcObjectLayerRef;
pub extern fn LLVMOrcRTDyldObjectLinkingLayerRegisterJITEventListener(RTDyldObjLinkingLayer: Orc.LLVMOrcObjectLayerRef, Listener: LLVMtype.LLVMJITEventListenerRef) void;
