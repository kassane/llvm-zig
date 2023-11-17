const CXString = @import("CXString.zig");
const CXFile = @import("CXFile.zig");
const std = @import("std");

pub const CXSourceLocation = extern struct {
    ptr_data: [2]?*const anyopaque = std.mem.zeroes([2]?*const anyopaque),
    int_data: c_uint = std.mem.zeroes(c_uint),
};
pub const CXSourceRange = extern struct {
    ptr_data: [2]?*const anyopaque = std.mem.zeroes([2]?*const anyopaque),
    begin_int_data: c_uint = std.mem.zeroes(c_uint),
    end_int_data: c_uint = std.mem.zeroes(c_uint),
};
pub extern fn clang_getNullLocation() CXSourceLocation;
pub extern fn clang_equalLocations(loc1: CXSourceLocation, loc2: CXSourceLocation) c_uint;
pub extern fn clang_Location_isInSystemHeader(location: CXSourceLocation) c_int;
pub extern fn clang_Location_isFromMainFile(location: CXSourceLocation) c_int;
pub extern fn clang_getNullRange() CXSourceRange;
pub extern fn clang_getRange(begin: CXSourceLocation, end: CXSourceLocation) CXSourceRange;
pub extern fn clang_equalRanges(range1: CXSourceRange, range2: CXSourceRange) c_uint;
pub extern fn clang_Range_isNull(range: CXSourceRange) c_int;
pub extern fn clang_getExpansionLocation(location: CXSourceLocation, file: [*c]CXFile.CXFile, line: [*c]c_uint, column: [*c]c_uint, offset: [*c]c_uint) void;
pub extern fn clang_getPresumedLocation(location: CXSourceLocation, filename: [*c]CXString.CXString, line: [*c]c_uint, column: [*c]c_uint) void;
pub extern fn clang_getInstantiationLocation(location: CXSourceLocation, file: [*c]CXFile.CXFile, line: [*c]c_uint, column: [*c]c_uint, offset: [*c]c_uint) void;
pub extern fn clang_getSpellingLocation(location: CXSourceLocation, file: [*c]CXFile.CXFile, line: [*c]c_uint, column: [*c]c_uint, offset: [*c]c_uint) void;
pub extern fn clang_getFileLocation(location: CXSourceLocation, file: [*c]CXFile.CXFile, line: [*c]c_uint, column: [*c]c_uint, offset: [*c]c_uint) void;
pub extern fn clang_getRangeStart(range: CXSourceRange) CXSourceLocation;
pub extern fn clang_getRangeEnd(range: CXSourceRange) CXSourceLocation;
pub const CXSourceRangeList = extern struct {
    count: c_uint = std.mem.zeroes(c_uint),
    ranges: [*c]CXSourceRange = std.mem.zeroes([*c]CXSourceRange),
};
pub extern fn clang_disposeSourceRangeList(ranges: [*c]CXSourceRangeList) void;
