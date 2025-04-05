
const core = @import("../core.zig");
pub const createEnum = core.LLVMCreateEnumAttribute;
pub const getEnumAttributeKind = core.LLVMGetEnumAttributeKind;
pub const getEnumAttributeValue = core.LLVMGetEnumAttributeValue;
pub const createType = core.LLVMCreateTypeAttribute;
pub const getTypeAttributeValue = core.LLVMGetTypeAttributeValue;
pub const createString = core.LLVMCreateStringAttribute;
pub const getStringAttributeKind = core.LLVMGetStringAttributeKind;
pub const getStringAttributeValue = core.LLVMGetStringAttributeValue;
pub const isEnum = core.LLVMIsEnumAttribute;
pub const isString = core.LLVMIsStringAttribute;
pub const isType = core.LLVMIsTypeAttribute;
