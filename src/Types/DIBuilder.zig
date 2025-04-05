const debuginfo = @import("../debuginfo.zig");
pub const createDIBuilderDisallowUnresolved = debuginfo.LLVMCreateDIBuilderDisallowUnresolved;
pub const create = debuginfo.LLVMCreateDIBuilder;
pub const dispose = debuginfo.LLVMDisposeDIBuilder;
pub const finalize = debuginfo.LLVMDIBuilderFinalize;
pub const finalizeSubprogram = debuginfo.LLVMDIBuilderFinalizeSubprogram;
pub const insertDeclareBefore = debuginfo.LLVMDIBuilderInsertDeclareBefore;
pub const insertDeclareAtEnd = debuginfo.LLVMDIBuilderInsertDeclareAtEnd;
pub const insertDbgValueBefore = debuginfo.LLVMDIBuilderInsertDbgValueBefore;
pub const insertDbgValueAtEnd = debuginfo.LLVMDIBuilderInsertDbgValueAtEnd;
