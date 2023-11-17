const CXString = @import("CXString.zig");
const CXErrorCode = @import("CXErrorCode.zig");

pub extern fn clang_getBuildSessionTimestamp() c_ulonglong;
pub const CXVirtualFileOverlayImpl = opaque {};
pub const CXVirtualFileOverlay = ?*CXVirtualFileOverlayImpl;
pub extern fn clang_VirtualFileOverlay_create(options: c_uint) CXVirtualFileOverlay;
pub extern fn clang_VirtualFileOverlay_addFileMapping(CXVirtualFileOverlay, virtualPath: [*:0]const u8, realPath: [*:0]const u8) CXErrorCode.CXErrorCode;
pub extern fn clang_VirtualFileOverlay_setCaseSensitivity(CXVirtualFileOverlay, caseSensitive: c_int) CXErrorCode.CXErrorCode;
pub extern fn clang_VirtualFileOverlay_writeToBuffer(CXVirtualFileOverlay, options: c_uint, out_buffer_ptr: [*c][*c]u8, out_buffer_size: [*c]c_uint) CXErrorCode.CXErrorCode;
pub extern fn clang_free(buffer: ?*anyopaque) void;
pub extern fn clang_VirtualFileOverlay_dispose(CXVirtualFileOverlay) void;
pub const CXModuleMapDescriptorImpl = opaque {};
pub const CXModuleMapDescriptor = ?*CXModuleMapDescriptorImpl;
pub extern fn clang_ModuleMapDescriptor_create(options: c_uint) CXModuleMapDescriptor;
pub extern fn clang_ModuleMapDescriptor_setFrameworkModuleName(CXModuleMapDescriptor, name: [*:0]const u8) CXErrorCode.CXErrorCode;
pub extern fn clang_ModuleMapDescriptor_setUmbrellaHeader(CXModuleMapDescriptor, name: [*:0]const u8) CXErrorCode.CXErrorCode;
pub extern fn clang_ModuleMapDescriptor_writeToBuffer(CXModuleMapDescriptor, options: c_uint, out_buffer_ptr: [*c][*c]u8, out_buffer_size: [*c]c_uint) CXErrorCode.CXErrorCode;
pub extern fn clang_ModuleMapDescriptor_dispose(CXModuleMapDescriptor) void;
