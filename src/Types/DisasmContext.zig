
const disassembler = @import("../disassembler.zig");
pub const createDisasm = disassembler.LLVMCreateDisasm;
pub const createDisasmCPU = disassembler.LLVMCreateDisasmCPU;
pub const createDisasmCPUFeatures = disassembler.LLVMCreateDisasmCPUFeatures;
pub const setDisasmOptions = disassembler.LLVMSetDisasmOptions;
pub const disasmDispose = disassembler.LLVMDisasmDispose;
pub const disasmInstruction = disassembler.LLVMDisasmInstruction;
