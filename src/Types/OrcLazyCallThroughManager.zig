const orc = @import("../orc.zig");
pub const createLocal = orc.LLVMOrcCreateLocalLazyCallThroughManager;
pub const reexports = orc.LLVMOrcLazyReexports;
pub const dispose = orc.LLVMOrcDisposeLazyCallThroughManager;
