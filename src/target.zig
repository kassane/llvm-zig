const LLVMtype = @import("types.zig");

pub extern fn LLVMGetModuleDataLayout(M: LLVMtype.LLVMModuleRef) LLVMtype.LLVMTargetDataRef;
pub extern fn LLVMSetModuleDataLayout(M: LLVMtype.LLVMModuleRef, DL: LLVMtype.LLVMTargetDataRef) void;
pub extern fn LLVMCreateTargetData(StringRep: [*c]const u8) LLVMtype.LLVMTargetDataRef;
pub extern fn LLVMDisposeTargetData(TD: LLVMtype.LLVMTargetDataRef) void;
pub extern fn LLVMAddTargetLibraryInfo(TLI: LLVMtype.LLVMTargetLibraryInfoRef, PM: LLVMtype.LLVMPassManagerRef) void;
pub extern fn LLVMCopyStringRepOfTargetData(TD: LLVMtype.LLVMTargetDataRef) [*c]u8;
pub extern fn LLVMByteOrder(TD: LLVMtype.LLVMTargetDataRef) c_int;
pub extern fn LLVMPointerSize(TD: LLVMtype.LLVMTargetDataRef) c_uint;
pub extern fn LLVMPointerSizeForAS(TD: LLVMtype.LLVMTargetDataRef, AS: c_uint) c_uint;
pub extern fn LLVMIntPtrType(TD: LLVMtype.LLVMTargetDataRef) LLVMtype.LLVMTypeRef;
pub extern fn LLVMIntPtrTypeForAS(TD: LLVMtype.LLVMTargetDataRef, AS: c_uint) LLVMtype.LLVMTypeRef;
pub extern fn LLVMIntPtrTypeInContext(C: LLVMtype.LLVMContextRef, TD: LLVMtype.LLVMTargetDataRef) LLVMtype.LLVMTypeRef;
pub extern fn LLVMIntPtrTypeForASInContext(C: LLVMtype.LLVMContextRef, TD: LLVMtype.LLVMTargetDataRef, AS: c_uint) LLVMtype.LLVMTypeRef;
pub extern fn LLVMSizeOfTypeInBits(TD: LLVMtype.LLVMTargetDataRef, Ty: LLVMtype.LLVMTypeRef) c_ulonglong;
pub extern fn LLVMStoreSizeOfType(TD: LLVMtype.LLVMTargetDataRef, Ty: LLVMtype.LLVMTypeRef) c_ulonglong;
pub extern fn LLVMABISizeOfType(TD: LLVMtype.LLVMTargetDataRef, Ty: LLVMtype.LLVMTypeRef) c_ulonglong;
pub extern fn LLVMABIAlignmentOfType(TD: LLVMtype.LLVMTargetDataRef, Ty: LLVMtype.LLVMTypeRef) c_uint;
pub extern fn LLVMCallFrameAlignmentOfType(TD: LLVMtype.LLVMTargetDataRef, Ty: LLVMtype.LLVMTypeRef) c_uint;
pub extern fn LLVMPreferredAlignmentOfType(TD: LLVMtype.LLVMTargetDataRef, Ty: LLVMtype.LLVMTypeRef) c_uint;
pub extern fn LLVMPreferredAlignmentOfGlobal(TD: LLVMtype.LLVMTargetDataRef, GlobalVar: LLVMtype.LLVMValueRef) c_uint;
pub extern fn LLVMElementAtOffset(TD: LLVMtype.LLVMTargetDataRef, StructTy: LLVMtype.LLVMTypeRef, Offset: c_ulonglong) c_uint;
pub extern fn LLVMOffsetOfElement(TD: LLVMtype.LLVMTargetDataRef, StructTy: LLVMtype.LLVMTypeRef, Element: c_uint) c_ulonglong;
