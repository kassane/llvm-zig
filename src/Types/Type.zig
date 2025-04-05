const core = @import("../core.zig");
const executionEngine = @import("../executionEngine.zig");

pub const getInlineAsm = core.LLVMGetInlineAsm;
pub const getTypeKind = core.LLVMGetTypeKind;
pub const typeIsSized = core.LLVMTypeIsSized;
pub const getTypeContext = core.LLVMGetTypeContext;
pub const dump = core.LLVMDumpType;
pub const printTypeToString = core.LLVMPrintTypeToString;
pub const int1 = core.LLVMInt1Type;
pub const int8 = core.LLVMInt8Type;
pub const int16 = core.LLVMInt16Type;
pub const int32 = core.LLVMInt32Type;
pub const int64 = core.LLVMInt64Type;
pub const int128 = core.LLVMInt128Type;
pub const int = core.LLVMIntType;
pub const getIntTypeWidth = core.LLVMGetIntTypeWidth;
pub const half = core.LLVMHalfType;
pub const bFloat = core.LLVMBFloatType;
pub const float = core.LLVMFloatType;
pub const double = core.LLVMDoubleType;
pub const x86FP80 = core.LLVMX86FP80Type;
pub const fP128 = core.LLVMFP128Type;
pub const pPCFP128 = core.LLVMPPCFP128Type;
pub const function = core.LLVMFunctionType;
pub const isFunctionVarArg = core.LLVMIsFunctionVarArg;
pub const getReturn = core.LLVMGetReturnType;
pub const countParamTypes = core.LLVMCountParamTypes;
pub const getParamTypes = core.LLVMGetParamTypes;
pub const struct_ = core.LLVMStructType;
pub const structCreateNamed = core.LLVMStructCreateNamed;
pub const getStructName = core.LLVMGetStructName;
pub const structSetBody = core.LLVMStructSetBody;
pub const countStructElementTypes = core.LLVMCountStructElementTypes;
pub const getStructElementTypes = core.LLVMGetStructElementTypes;
pub const structGetTypeAtIndex = core.LLVMStructGetTypeAtIndex;
pub const isPackedStruct = core.LLVMIsPackedStruct;
pub const isOpaqueStruct = core.LLVMIsOpaqueStruct;
pub const isLiteralStruct = core.LLVMIsLiteralStruct;
pub const getElement = core.LLVMGetElementType;
pub const getSubtypes = core.LLVMGetSubtypes;
pub const getNumContainedTypes = core.LLVMGetNumContainedTypes;
pub const array = core.LLVMArrayType;
pub const getArrayLength = core.LLVMGetArrayLength;
pub const pointer = core.LLVMPointerType;
pub const pointerTypeIsOpaque = core.LLVMPointerTypeIsOpaque;
pub const getPointerAddressSpace = core.LLVMGetPointerAddressSpace;
pub const vector = core.LLVMVectorType;
pub const scalableVector = core.LLVMScalableVectorType;
pub const getVectorSize = core.LLVMGetVectorSize;
pub const void_ = core.LLVMVoidType;
pub const label = core.LLVMLabelType;
pub const x86MMX = core.LLVMX86MMXType;
pub const x86AMX = core.LLVMX86AMXType;
pub const constNull = core.LLVMConstNull;
pub const constAllOnes = core.LLVMConstAllOnes;
pub const getUndef = core.LLVMGetUndef;
pub const getPoison = core.LLVMGetPoison;
pub const constPointerNull = core.LLVMConstPointerNull;
pub const constInt = core.LLVMConstInt;
pub const constIntOfArbitraryPrecision = core.LLVMConstIntOfArbitraryPrecision;
pub const constIntOfString = core.LLVMConstIntOfString;
pub const constIntOfStringAndSize = core.LLVMConstIntOfStringAndSize;
pub const constReal = core.LLVMConstReal;
pub const constRealOfString = core.LLVMConstRealOfString;
pub const constRealOfStringAndSize = core.LLVMConstRealOfStringAndSize;
pub const constArray = core.LLVMConstArray;
pub const constNamedStruct = core.LLVMConstNamedStruct;
pub const alignOf = core.LLVMAlignOf;
pub const sizeOf = core.LLVMSizeOf;
pub const constGEP2 = core.LLVMConstGEP2;
pub const constInBoundsGEP2 = core.LLVMConstInBoundsGEP2;
pub const constInlineAsm = core.LLVMConstInlineAsm;
pub const genericValueToFloat = executionEngine.LLVMGenericValueToFloat;
