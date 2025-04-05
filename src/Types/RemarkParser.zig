const remarks = @import("../remarks.zig");
pub const createYAML = remarks.LLVMRemarkParserCreateYAML;
pub const createBitstream = remarks.LLVMRemarkParserCreateBitstream;
pub const getNext = remarks.LLVMRemarkParserGetNext;
pub const hasError = remarks.LLVMRemarkParserHasError;
pub const getErrorMessage = remarks.LLVMRemarkParserGetErrorMessage;
pub const dispose = remarks.LLVMRemarkParserDispose;
