
const target_machine = @import("../target_machine.zig");
pub const getFirst = target_machine.LLVMGetFirstTarget;
pub const getNext = target_machine.LLVMGetNextTarget;
pub const getTargetFromName = target_machine.LLVMGetTargetFromName;
pub const getTargetName = target_machine.LLVMGetTargetName;
pub const getTargetDescription = target_machine.LLVMGetTargetDescription;
pub const targetHasJIT = target_machine.LLVMTargetHasJIT;
pub const targetHasTargetMachine = target_machine.LLVMTargetHasTargetMachine;
pub const targetHasAsmBackend = target_machine.LLVMTargetHasAsmBackend;
