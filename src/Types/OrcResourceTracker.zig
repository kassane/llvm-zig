const orc = @import("../orc.zig");
pub const release = orc.LLVMOrcReleaseResourceTracker;
pub const transferTo = orc.LLVMOrcResourceTrackerTransferTo;
pub const temove = orc.LLVMOrcResourceTrackerRemove;
pub const create = orc.LLVMOrcJITDylibCreateResourceTracker;
