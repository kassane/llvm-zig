const orc = @import("../orc.zig");
pub const retain = orc.LLVMOrcRetainSymbolStringPoolEntry;
pub const release = orc.LLVMOrcReleaseSymbolStringPoolEntry;
pub const str = orc.LLVMOrcSymbolStringPoolEntryStr;
