const std = @import("std");
const llvm = @import("llvm");
const target = llvm.target;
const types = llvm.types;
const core = llvm.core;

pub fn main() void {
    // Initialize LLVM
    _ = target.LLVMInitializeNativeTarget();
    _ = target.LLVMInitializeNativeAsmPrinter();
    _ = target.LLVMInitializeNativeAsmParser();

    // Create a new LLVM module
    const module: types.LLVMModuleRef = core.LLVMModuleCreateWithName("sum_module");
    var params: [2]types.LLVMTypeRef = [_]types.LLVMTypeRef{
        core.LLVMInt32Type(),
        core.LLVMInt32Type(),
    };

    // Create a function that computes the sum of two integers
    const func_type: types.LLVMTypeRef = core.LLVMFunctionType(core.LLVMInt32Type(), &params, 2, 0);
    const sum_func: types.LLVMValueRef = core.LLVMAddFunction(module, "sum", func_type);
    const entry: types.LLVMBasicBlockRef = core.LLVMAppendBasicBlock(sum_func, "entry");
    const builder: types.LLVMBuilderRef = core.LLVMCreateBuilder();
    core.LLVMPositionBuilderAtEnd(builder, entry);
    const arg1: types.LLVMValueRef = core.LLVMGetParam(sum_func, 0);
    const arg2: types.LLVMValueRef = core.LLVMGetParam(sum_func, 1);
    const sum: types.LLVMValueRef = core.LLVMBuildAdd(builder, arg1, arg2, "sum");
    _ = core.LLVMBuildRet(builder, sum);

    // Dump the LLVM module to stdout
    core.LLVMDumpModule(module);

    // Clean up LLVM resources
    core.LLVMDisposeBuilder(builder);
    core.LLVMDisposeModule(module);
    core.LLVMShutdown();
}
