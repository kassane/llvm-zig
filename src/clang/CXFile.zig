const CXString = @import("CXString.zig");
const std = @import("std");

pub const CXFile = ?*anyopaque;
pub extern fn clang_getFileName(SFile: CXFile) CXString.CXString;
pub extern fn clang_getFileTime(SFile: CXFile) std.os.linux.time_t;
pub const CXFileUniqueID = extern struct {
    data: [3]c_ulonglong = std.mem.zeroes([3]c_ulonglong),
};
pub extern fn clang_getFileUniqueID(file: CXFile, outID: [*c]CXFileUniqueID) c_int;
pub extern fn clang_File_isEqual(file1: CXFile, file2: CXFile) c_int;
pub extern fn clang_File_tryGetRealPathName(file: CXFile) CXString.CXString;
