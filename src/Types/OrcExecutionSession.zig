const orc = @import("../orc.zig");
pub const createJITDylib = orc.LLVMOrcExecutionSessionCreateJITDylib;
pub const setErrorReporter = orc.LLVMOrcExecutionSessionSetErrorReporter;
pub const getSymbolStringPool = orc.LLVMOrcExecutionSessionGetSymbolStringPool;
pub const intern = orc.LLVMOrcExecutionSessionIntern;
pub const lookup = orc.LLVMOrcExecutionSessionLookup;
pub const getJITDylibByName = orc.LLVMOrcExecutionSessionGetJITDylibByName;
pub const createBareJITDylib = orc.LLVMOrcExecutionSessionCreateBareJITDylib;
