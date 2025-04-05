
const object = @import("../object.zig");
pub const dispose = object.LLVMDisposeSymbolIterator;
pub const moveToNextSymbol = object.LLVMMoveToNextSymbol;
pub const getSymbolName = object.LLVMGetSymbolName;
pub const getSymbolAddress = object.LLVMGetSymbolAddress;
pub const getSymbolSize = object.LLVMGetSymbolSize;
