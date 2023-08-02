const std = @import("std");
const llvm = @import("llvm");
const analysis = llvm.analysis;
const core = llvm.core;
const target = llvm.target;
const types = llvm.types;

pub fn main() void {
    // Initialize LLVM
    _ = target.LLVMInitializeNativeTarget();
    _ = target.LLVMInitializeNativeAsmPrinter();
    _ = target.LLVMInitializeNativeAsmParser();

    // Shutdown LLVM
    defer core.LLVMShutdown();

    // Create a new LLVM module
    var module: types.LLVMModuleRef = core.LLVMModuleCreateWithName("factorial_module");
    var builder: types.LLVMBuilderRef = core.LLVMCreateBuilder();

    // Create the factorial function
    const returnType: types.LLVMTypeRef = core.LLVMInt32Type();
    var paramTypes = [_]types.LLVMTypeRef{core.LLVMInt32Type()};
    const factorialFuncType: types.LLVMTypeRef = core.LLVMFunctionType(returnType, &paramTypes, 1, 0);
    const factorialFunc: types.LLVMValueRef = core.LLVMAddFunction(module, "factorial", factorialFuncType);

    // Set up the function body
    const entryBlock: types.LLVMBasicBlockRef = core.LLVMAppendBasicBlock(factorialFunc, "entry");
    core.LLVMPositionBuilderAtEnd(builder, entryBlock);

    const n: types.LLVMValueRef = core.LLVMGetParam(factorialFunc, 0);
    const loopBlock: types.LLVMBasicBlockRef = core.LLVMAppendBasicBlock(factorialFunc, "loop");
    const endBlock: types.LLVMBasicBlockRef = core.LLVMAppendBasicBlock(factorialFunc, "end");

    _ = core.LLVMBuildBr(builder, loopBlock);
    core.LLVMPositionBuilderAtEnd(builder, loopBlock);
    const nIsZero: types.LLVMValueRef = core.LLVMBuildICmp(builder, types.LLVMIntPredicate.LLVMIntEQ, n, core.LLVMConstInt(core.LLVMInt32Type(), 0, 0), "nIsZero");

    _ = core.LLVMBuildCondBr(builder, nIsZero, endBlock, loopBlock);
    core.LLVMPositionBuilderAtEnd(builder, endBlock);
    const result: types.LLVMValueRef = core.LLVMBuildPhi(builder, returnType, "result");
    const resultValue: types.LLVMValueRef = core.LLVMBuildPhi(builder, returnType, "result_value");
    const resultPlusN: types.LLVMValueRef = core.LLVMBuildAdd(builder, resultValue, n, "result_plus_n");

    _ = core.LLVMBuildStore(builder, resultPlusN, result);
    const nIsOne: types.LLVMValueRef = core.LLVMBuildICmp(builder, types.LLVMIntPredicate.LLVMIntEQ, n, core.LLVMConstInt(core.LLVMInt32Type(), 1, 0), "nIsOne");
    const newResult: types.LLVMValueRef = core.LLVMBuildSelect(builder, nIsOne, resultPlusN, resultValue, "newResult");

    _ = core.LLVMBuildStore(builder, newResult, resultValue);
    _ = core.LLVMBuildCondBr(builder, nIsOne, endBlock, loopBlock);

    core.LLVMPositionBuilderAtEnd(builder, endBlock);
    _ = core.LLVMBuildRet(builder, resultValue);

    // Verify the module
    var errMsg: ?[*:0]u8 = null;
    _ = analysis.LLVMVerifyModule(module, types.LLVMVerifierFailureAction.LLVMPrintMessageAction, &errMsg);
    if (errMsg) |msg| {
        @panic(std.mem.span(msg));
        // core.LLVMDisposeMessage(msg);
        // std.os.exit(1);
    }

    // Dump the LLVM module to stdout
    core.LLVMDumpModule(module);

    // Clean up LLVM resources
    core.LLVMDisposeBuilder(builder);
    core.LLVMDisposeModule(module);
}
