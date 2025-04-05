const core = @import("../core.zig");

pub const createBasicBlockInContext = core.LLVMCreateBasicBlockInContext;
pub const appendBasicBlockIn = core.LLVMAppendBasicBlockInContext;
pub const insertBasicBlockIn = core.LLVMInsertBasicBlockInContext;
pub const basicBlockAsValue = core.LLVMBasicBlockAsValue;
pub const getBasicBlockName = core.LLVMGetBasicBlockName;
pub const getBasicBlockParent = core.LLVMGetBasicBlockParent;
pub const getBasicBlockTerminator = core.LLVMGetBasicBlockTerminator;
pub const getNext = core.LLVMGetNextBasicBlock;
pub const getPrevious = core.LLVMGetPreviousBasicBlock;
pub const insert = core.LLVMInsertBasicBlock;
pub const delete = core.LLVMDeleteBasicBlock;
pub const removeBasicBlockFromParent = core.LLVMRemoveBasicBlockFromParent;
pub const moveBasicBlockBefore = core.LLVMMoveBasicBlockBefore;
pub const moveBasicBlockAfter = core.LLVMMoveBasicBlockAfter;
pub const getFirstInstruction = core.LLVMGetFirstInstruction;
pub const getLastInstruction = core.LLVMGetLastInstruction;
