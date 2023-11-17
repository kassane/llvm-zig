const std = @import("std");
pub const CXString = extern struct {
    data: ?*const anyopaque = std.mem.zeroes(?*const anyopaque),
    private_flags: c_uint = std.mem.zeroes(c_uint),
};
pub const CXStringSet = extern struct {
    Strings: [*c]CXString = std.mem.zeroes([*c]CXString),
    Count: c_uint = std.mem.zeroes(c_uint),
};
pub extern fn clang_getCString(string: CXString) [*:0]const u8;
pub extern fn clang_disposeString(string: CXString) void;
pub extern fn clang_disposeStringSet(set: [*c]CXStringSet) void;
