pub const CXString = @import("clang/CXString.zig");
pub const CXErrorCode = @import("clang/CXErrorCode.zig");
pub const CXSourceLocation = @import("clang/CXSourceLocation.zig");
pub const CXFile = @import("clang/CXFile.zig");
pub const CXDiagnostic = @import("clang/CXDiagnostic.zig");
pub const CXIndex = @import("clang/Index.zig");
pub const BuildSystem = @import("clang/BuildSystem.zig");
pub const CXCompilationDatabase = @import("clang/CXCompilationDatabase.zig");
pub const Rewrite = @import("clang/Rewrite.zig");
pub const FatalErrorHandler = @import("clang/FatalErrorHandler.zig");
pub const Documentation = @import("clang/Documentation.zig");

test "all clang modules" {
    _ = CXString;
    _ = CXErrorCode;
    _ = CXSourceLocation;
    _ = CXIndex;
    _ = CXFile;
    _ = CXDiagnostic;
    _ = CXCompilationDatabase;
    _ = BuildSystem;
    _ = Rewrite;
    _ = FatalErrorHandler;
    _ = Documentation;
}
