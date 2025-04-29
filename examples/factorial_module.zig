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
    const module: types.LLVMModuleRef = core.LLVMModuleCreateWithName("factorial_module");
    const builder: types.LLVMBuilderRef = core.LLVMCreateBuilder();

    // Create the factorial function
    const returnType: types.LLVMTypeRef = core.LLVMInt32Type();
    var paramTypes = [_]types.LLVMTypeRef{core.LLVMInt32Type()};
    const factorialFuncType: types.LLVMTypeRef = core.LLVMFunctionType(returnType, &paramTypes, 1, 0);
    const factorialFunc: types.LLVMValueRef = core.LLVMAddFunction(module, "factorial", factorialFuncType);

    // Set up the function body
    const entryBlock = core.LLVMAppendBasicBlock(factorialFunc, "entry");
    const initBlock = core.LLVMAppendBasicBlock(factorialFunc, "init");
    const condBlock = core.LLVMAppendBasicBlock(factorialFunc, "cond");
    const bodyBlock = core.LLVMAppendBasicBlock(factorialFunc, "body");
    const endBlock = core.LLVMAppendBasicBlock(factorialFunc, "end");

    // Start entryBlock
    core.LLVMPositionBuilderAtEnd(builder, entryBlock);
    const n = core.LLVMGetParam(factorialFunc, 0);

    // allocate space to store values
    // with pointers as return values 
    const result_ptr = core.LLVMBuildAlloca(builder, returnType, "result_ptr");
    const n_ptr = core.LLVMBuildAlloca(builder, returnType, "n_ptr");
    // End entryBlock

    // Start initBlock, do some initialization
    _ = core.LLVMBuildBr(builder, initBlock);
    core.LLVMPositionBuilderAtEnd(builder, initBlock);
    
    // Set n_ptr.* = n, result.* = 1
    _ = core.LLVMBuildStore(builder, core.LLVMConstInt(returnType, 1, 0), result_ptr);
    _ = core.LLVMBuildStore(builder, n, n_ptr);
    // End initBlock

    // Start condBlock, set control flow
    _ = core.LLVMBuildBr(builder, condBlock);
    core.LLVMPositionBuilderAtEnd(builder, condBlock);

    const n_val = core.LLVMBuildLoad2(builder, returnType, n_ptr, "n_val");
    const isZero = core.LLVMBuildICmp(
        builder,
        types.LLVMIntPredicate.LLVMIntEQ,
        n_val,
        core.LLVMConstInt(returnType, 0, 0),
        "n_is_zero",
    );
    _ = core.LLVMBuildCondBr(builder, isZero, endBlock, bodyBlock);
    // If n_ptr.* = 0 then goto endBlock
    // else goto bodyBlock
    // End condBlock

    // Start bodyBlock: 
    // factorial *= n; n -= 1
    core.LLVMPositionBuilderAtEnd(builder, bodyBlock);
    const result_val = core.LLVMBuildLoad2(builder, returnType, result_ptr, "res");
    const new_result = core.LLVMBuildMul(builder, result_val, n_val, "new_res");
    _ = core.LLVMBuildStore(builder, new_result, result_ptr);

    const new_n = core.LLVMBuildSub(
        builder,
        n_val,
        core.LLVMConstInt(returnType, 1, 0),
        "new_n",
    );
    _ = core.LLVMBuildStore(builder, new_n, n_ptr);
    _ = core.LLVMBuildBr(builder, condBlock); 
    // goto condBlock
    // End bodyBlock

    // Start endBlock
    core.LLVMPositionBuilderAtEnd(builder, endBlock);
    const final_result = core.LLVMBuildLoad2(builder, returnType, result_ptr, "final");
    _ = core.LLVMBuildRet(builder, final_result);
    // End endBlock
    // Program ends

    // Verify the module
    var errMsg: ?[*:0]u8 = null;
    const failed: types.LLVMBool = analysis.LLVMVerifyModule(
        module,
        types.LLVMVerifierFailureAction.LLVMReturnStatusAction,
        @ptrCast(&errMsg),
    );

    if (failed != 0 and errMsg != null){ 
        const msg: [*:0]u8 = errMsg.?;
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
