const std = @import("std");
const llvm = @import("llvm");
const target = llvm.target;
const types = llvm.types;
const core = llvm.core;

pub fn main() !void {
    // Initialize LLVM
    _ = target.LLVMInitializeNativeTarget();
    _ = target.LLVMInitializeNativeAsmPrinter();
    _ = target.LLVMInitializeNativeAsmParser();
    defer core.LLVMShutdown();

    // Create a new LLVM module
    const module: *types.Module = types.Module.createWithName("sum_module") orelse return error.null_value;
    defer module.dispose();

    var params: [2]types.LLVMTypeRef = [_]types.LLVMTypeRef{
        .int32(),
        .int32(),
    };

    // Create a function that computes the sum of two integers
    const func_type: types.LLVMTypeRef = types.Type.function(.int32(), &params, 2, 0);
    const sum_func: *types.Value = module.addFunction("sum", func_type) orelse return error.null_value;

    const entry: types.LLVMBasicBlockRef = sum_func.appendBasicBlock("entry");
    const builder: *types.Builder = types.Builder.create() orelse return error.null_value;
    defer builder.dispose();

    builder.positionBuilderAtEnd(entry);

    const arg1: types.LLVMValueRef = sum_func.getParam(0);
    const arg2: types.LLVMValueRef = sum_func.getParam(1);
    const sum: types.LLVMValueRef = builder.buildAdd(arg1, arg2, "sum");
    _ = builder.buildRet(sum);

    // Dump the LLVM module to stdout
    module.dump();
}
