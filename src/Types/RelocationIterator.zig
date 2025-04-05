const object = @import("../object.zig");
pub const dispose = object.LLVMDisposeRelocationIterator;
pub const moveToNextRelocation = object.LLVMMoveToNextRelocation;
pub const getOffset = object.LLVMGetRelocationOffset;
pub const getSymbol = object.LLVMGetRelocationSymbol;
pub const getType = object.LLVMGetRelocationType;
pub const getTypeName = object.LLVMGetRelocationTypeName;
pub const getValueString = object.LLVMGetRelocationValueString;
