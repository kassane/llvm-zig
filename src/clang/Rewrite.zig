const CXSourceLocation = @import("CXSourceLocation.zig");
const Index = @import("Index.zig");

pub const CXRewriter = ?*anyopaque;
pub extern fn clang_CXRewriter_create(TU: Index.CXTranslationUnit) CXRewriter;
pub extern fn clang_CXRewriter_insertTextBefore(Rew: CXRewriter, Loc: CXSourceLocation.CXSourceLocation, Insert: [*c]const u8) void;
pub extern fn clang_CXRewriter_replaceText(Rew: CXRewriter, ToBeReplaced: CXSourceLocation.CXSourceRange, Replacement: [*c]const u8) void;
pub extern fn clang_CXRewriter_removeText(Rew: CXRewriter, ToBeRemoved: CXSourceLocation.CXSourceRange) void;
pub extern fn clang_CXRewriter_overwriteChangedFiles(Rew: CXRewriter) c_int;
pub extern fn clang_CXRewriter_writeMainFileToStdOut(Rew: CXRewriter) void;
pub extern fn clang_CXRewriter_dispose(Rew: CXRewriter) void;
