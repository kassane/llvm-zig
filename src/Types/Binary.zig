
const object = @import("../object.zig");
pub const create = object.LLVMCreateBinary;
pub const dispose = object.LLVMDisposeBinary;
pub const binaryCopyMemoryBuffer = object.LLVMBinaryCopyMemoryBuffer;
pub const binaryGetType = object.LLVMBinaryGetType;
pub const machOUniversalBinaryCopyObjectForArch = object.LLVMMachOUniversalBinaryCopyObjectForArch;
pub const objectFileCopySectionIterator = object.LLVMObjectFileCopySectionIterator;
pub const objectFileIsSectionIteratorAtEnd = object.LLVMObjectFileIsSectionIteratorAtEnd;
pub const objectFileCopySymbolIterator = object.LLVMObjectFileCopySymbolIterator;
pub const objectFileIsSymbolIteratorAtEnd = object.LLVMObjectFileIsSymbolIteratorAtEnd;
