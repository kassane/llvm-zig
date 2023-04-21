pub const LLVMFatalErrorHandler = ?*const fn ([*:0]const u8) callconv(.C) void;
pub extern fn LLVMInstallFatalErrorHandler(Handler: LLVMFatalErrorHandler) void;
pub extern fn LLVMResetFatalErrorHandler() void;
pub extern fn LLVMEnablePrettyStackTrace() void;
