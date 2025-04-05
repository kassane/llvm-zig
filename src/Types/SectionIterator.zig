
const object = @import("../object.zig");
pub const dispose = object.LLVMDisposeSectionIterator;
pub const moveToNextSection = object.LLVMMoveToNextSection;
pub const moveToContainingSection = object.LLVMMoveToContainingSection;
pub const getSectionName = object.LLVMGetSectionName;
pub const getSectionSize = object.LLVMGetSectionSize;
pub const getSectionContents = object.LLVMGetSectionContents;
pub const getSectionAddress = object.LLVMGetSectionAddress;
pub const getSectionContainsSymbol = object.LLVMGetSectionContainsSymbol;
pub const getRelocations = object.LLVMGetRelocations;
pub const isRelocationIteratorAtEnd = object.LLVMIsRelocationIteratorAtEnd;
