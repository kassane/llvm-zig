const LLVMtype = @import("types.zig");

pub extern fn LLVMInitializeAArch64TargetInfo() void;
pub extern fn LLVMInitializeAMDGPUTargetInfo() void;
pub extern fn LLVMInitializeARMTargetInfo() void;
pub extern fn LLVMInitializeAVRTargetInfo() void;
pub extern fn LLVMInitializeBPFTargetInfo() void;
pub extern fn LLVMInitializeHexagonTargetInfo() void;
pub extern fn LLVMInitializeLanaiTargetInfo() void;
pub extern fn LLVMInitializeMipsTargetInfo() void;
pub extern fn LLVMInitializeMSP430TargetInfo() void;
pub extern fn LLVMInitializeNVPTXTargetInfo() void;
pub extern fn LLVMInitializePowerPCTargetInfo() void;
pub extern fn LLVMInitializeRISCVTargetInfo() void;
pub extern fn LLVMInitializeSparcTargetInfo() void;
pub extern fn LLVMInitializeSystemZTargetInfo() void;
pub extern fn LLVMInitializeWebAssemblyTargetInfo() void;
pub extern fn LLVMInitializeX86TargetInfo() void;
pub extern fn LLVMInitializeXCoreTargetInfo() void;
pub extern fn LLVMInitializeVETargetInfo() void;

pub extern fn LLVMInitializeAArch64Target() void;
pub extern fn LLVMInitializeAMDGPUTarget() void;
pub extern fn LLVMInitializeARMTarget() void;
pub extern fn LLVMInitializeAVRTarget() void;
pub extern fn LLVMInitializeBPFTarget() void;
pub extern fn LLVMInitializeHexagonTarget() void;
pub extern fn LLVMInitializeLanaiTarget() void;
pub extern fn LLVMInitializeMipsTarget() void;
pub extern fn LLVMInitializeMSP430Target() void;
pub extern fn LLVMInitializeNVPTXTarget() void;
pub extern fn LLVMInitializePowerPCTarget() void;
pub extern fn LLVMInitializeRISCVTarget() void;
pub extern fn LLVMInitializeSparcTarget() void;
pub extern fn LLVMInitializeSystemZTarget() void;
pub extern fn LLVMInitializeWebAssemblyTarget() void;
pub extern fn LLVMInitializeX86Target() void;
pub extern fn LLVMInitializeXCoreTarget() void;
pub extern fn LLVMInitializeVETarget() void;

pub extern fn LLVMInitializeAArch64TargetMC() void;
pub extern fn LLVMInitializeAMDGPUTargetMC() void;
pub extern fn LLVMInitializeARMTargetMC() void;
pub extern fn LLVMInitializeAVRTargetMC() void;
pub extern fn LLVMInitializeBPFTargetMC() void;
pub extern fn LLVMInitializeHexagonTargetMC() void;
pub extern fn LLVMInitializeLanaiTargetMC() void;
pub extern fn LLVMInitializeMipsTargetMC() void;
pub extern fn LLVMInitializeMSP430TargetMC() void;
pub extern fn LLVMInitializeNVPTXTargetMC() void;
pub extern fn LLVMInitializePowerPCTargetMC() void;
pub extern fn LLVMInitializeRISCVTargetMC() void;
pub extern fn LLVMInitializeSparcTargetMC() void;
pub extern fn LLVMInitializeSystemZTargetMC() void;
pub extern fn LLVMInitializeWebAssemblyTargetMC() void;
pub extern fn LLVMInitializeX86TargetMC() void;
pub extern fn LLVMInitializeXCoreTargetMC() void;
pub extern fn LLVMInitializeVETargetMC() void;

pub extern fn LLVMInitializeAArch64AsmPrinter() void;
pub extern fn LLVMInitializeAMDGPUAsmPrinter() void;
pub extern fn LLVMInitializeARMAsmPrinter() void;
pub extern fn LLVMInitializeAVRAsmPrinter() void;
pub extern fn LLVMInitializeBPFAsmPrinter() void;
pub extern fn LLVMInitializeHexagonAsmPrinter() void;
pub extern fn LLVMInitializeLanaiAsmPrinter() void;
pub extern fn LLVMInitializeMipsAsmPrinter() void;
pub extern fn LLVMInitializeMSP430AsmPrinter() void;
pub extern fn LLVMInitializeNVPTXAsmPrinter() void;
pub extern fn LLVMInitializePowerPCAsmPrinter() void;
pub extern fn LLVMInitializeRISCVAsmPrinter() void;
pub extern fn LLVMInitializeSparcAsmPrinter() void;
pub extern fn LLVMInitializeSystemZAsmPrinter() void;
pub extern fn LLVMInitializeWebAssemblyAsmPrinter() void;
pub extern fn LLVMInitializeX86AsmPrinter() void;
pub extern fn LLVMInitializeXCoreAsmPrinter() void;
pub extern fn LLVMInitializeVEAsmPrinter() void;

pub extern fn LLVMInitializeAArch64AsmParser() void;
pub extern fn LLVMInitializeAMDGPUAsmParser() void;
pub extern fn LLVMInitializeARMAsmParser() void;
pub extern fn LLVMInitializeAVRAsmParser() void;
pub extern fn LLVMInitializeBPFAsmParser() void;
pub extern fn LLVMInitializeHexagonAsmParser() void;
pub extern fn LLVMInitializeLanaiAsmParser() void;
pub extern fn LLVMInitializeMipsAsmParser() void;
pub extern fn LLVMInitializeMSP430AsmParser() void;
pub extern fn LLVMInitializePowerPCAsmParser() void;
pub extern fn LLVMInitializeRISCVAsmParser() void;
pub extern fn LLVMInitializeSparcAsmParser() void;
pub extern fn LLVMInitializeSystemZAsmParser() void;
pub extern fn LLVMInitializeWebAssemblyAsmParser() void;
pub extern fn LLVMInitializeX86AsmParser() void;
pub extern fn LLVMInitializeVEAsmParser() void;

pub extern fn LLVMInitializeAArch64Disassembler() void;
pub extern fn LLVMInitializeAMDGPUDisassembler() void;
pub extern fn LLVMInitializeARMDisassembler() void;
pub extern fn LLVMInitializeAVRDisassembler() void;
pub extern fn LLVMInitializeBPFDisassembler() void;
pub extern fn LLVMInitializeHexagonDisassembler() void;
pub extern fn LLVMInitializeLanaiDisassembler() void;
pub extern fn LLVMInitializeMipsDisassembler() void;
pub extern fn LLVMInitializeMSP430Disassembler() void;
pub extern fn LLVMInitializePowerPCDisassembler() void;
pub extern fn LLVMInitializeRISCVDisassembler() void;
pub extern fn LLVMInitializeSparcDisassembler() void;
pub extern fn LLVMInitializeSystemZDisassembler() void;
pub extern fn LLVMInitializeVEDisassembler() void;
pub extern fn LLVMInitializeWebAssemblyDisassembler() void;
pub extern fn LLVMInitializeX86Disassembler() void;
pub extern fn LLVMInitializeXCoreDisassembler() void;

pub fn LLVMInitializeAllTargetInfos() callconv(.c) void {
    LLVMInitializeAArch64TargetInfo();
    LLVMInitializeAMDGPUTargetInfo();
    LLVMInitializeARMTargetInfo();
    LLVMInitializeAVRTargetInfo();
    LLVMInitializeBPFTargetInfo();
    LLVMInitializeHexagonTargetInfo();
    LLVMInitializeLanaiTargetInfo();
    LLVMInitializeMipsTargetInfo();
    LLVMInitializeMSP430TargetInfo();
    LLVMInitializeNVPTXTargetInfo();
    LLVMInitializePowerPCTargetInfo();
    LLVMInitializeRISCVTargetInfo();
    LLVMInitializeSparcTargetInfo();
    LLVMInitializeSystemZTargetInfo();
    LLVMInitializeWebAssemblyTargetInfo();
    LLVMInitializeX86TargetInfo();
    LLVMInitializeXCoreTargetInfo();
    LLVMInitializeVETargetInfo();
}
pub fn LLVMInitializeAllTargets() callconv(.c) void {
    LLVMInitializeAArch64Target();
    LLVMInitializeAMDGPUTarget();
    LLVMInitializeARMTarget();
    LLVMInitializeAVRTarget();
    LLVMInitializeBPFTarget();
    LLVMInitializeHexagonTarget();
    LLVMInitializeLanaiTarget();
    LLVMInitializeMipsTarget();
    LLVMInitializeMSP430Target();
    LLVMInitializeNVPTXTarget();
    LLVMInitializePowerPCTarget();
    LLVMInitializeRISCVTarget();
    LLVMInitializeSparcTarget();
    LLVMInitializeSystemZTarget();
    LLVMInitializeWebAssemblyTarget();
    LLVMInitializeX86Target();
    LLVMInitializeXCoreTarget();
    LLVMInitializeVETarget();
}
pub fn LLVMInitializeAllTargetMCs() callconv(.c) void {
    LLVMInitializeAArch64TargetMC();
    LLVMInitializeAMDGPUTargetMC();
    LLVMInitializeARMTargetMC();
    LLVMInitializeAVRTargetMC();
    LLVMInitializeBPFTargetMC();
    LLVMInitializeHexagonTargetMC();
    LLVMInitializeLanaiTargetMC();
    LLVMInitializeMipsTargetMC();
    LLVMInitializeMSP430TargetMC();
    LLVMInitializeNVPTXTargetMC();
    LLVMInitializePowerPCTargetMC();
    LLVMInitializeRISCVTargetMC();
    LLVMInitializeSparcTargetMC();
    LLVMInitializeSystemZTargetMC();
    LLVMInitializeWebAssemblyTargetMC();
    LLVMInitializeX86TargetMC();
    LLVMInitializeXCoreTargetMC();
    LLVMInitializeVETargetMC();
}
pub fn LLVMInitializeAllAsmPrinters() callconv(.c) void {
    LLVMInitializeAArch64AsmPrinter();
    LLVMInitializeAMDGPUAsmPrinter();
    LLVMInitializeARMAsmPrinter();
    LLVMInitializeAVRAsmPrinter();
    LLVMInitializeBPFAsmPrinter();
    LLVMInitializeHexagonAsmPrinter();
    LLVMInitializeLanaiAsmPrinter();
    LLVMInitializeMipsAsmPrinter();
    LLVMInitializeMSP430AsmPrinter();
    LLVMInitializeNVPTXAsmPrinter();
    LLVMInitializePowerPCAsmPrinter();
    LLVMInitializeRISCVAsmPrinter();
    LLVMInitializeSparcAsmPrinter();
    LLVMInitializeSystemZAsmPrinter();
    LLVMInitializeWebAssemblyAsmPrinter();
    LLVMInitializeX86AsmPrinter();
    LLVMInitializeXCoreAsmPrinter();
    LLVMInitializeVEAsmPrinter();
}
pub fn LLVMInitializeAllAsmParsers() callconv(.c) void {
    LLVMInitializeAArch64AsmParser();
    LLVMInitializeAMDGPUAsmParser();
    LLVMInitializeARMAsmParser();
    LLVMInitializeAVRAsmParser();
    LLVMInitializeBPFAsmParser();
    LLVMInitializeHexagonAsmParser();
    LLVMInitializeLanaiAsmParser();
    LLVMInitializeMipsAsmParser();
    LLVMInitializeMSP430AsmParser();
    LLVMInitializePowerPCAsmParser();
    LLVMInitializeRISCVAsmParser();
    LLVMInitializeSparcAsmParser();
    LLVMInitializeSystemZAsmParser();
    LLVMInitializeWebAssemblyAsmParser();
    LLVMInitializeX86AsmParser();
    LLVMInitializeVEAsmParser();
}
pub fn LLVMInitializeAllDisassemblers() callconv(.c) void {
    LLVMInitializeAArch64Disassembler();
    LLVMInitializeAMDGPUDisassembler();
    LLVMInitializeARMDisassembler();
    LLVMInitializeAVRDisassembler();
    LLVMInitializeBPFDisassembler();
    LLVMInitializeHexagonDisassembler();
    LLVMInitializeLanaiDisassembler();
    LLVMInitializeMipsDisassembler();
    LLVMInitializeMSP430Disassembler();
    LLVMInitializePowerPCDisassembler();
    LLVMInitializeRISCVDisassembler();
    LLVMInitializeSparcDisassembler();
    LLVMInitializeSystemZDisassembler();
    LLVMInitializeWebAssemblyDisassembler();
    LLVMInitializeX86Disassembler();
    LLVMInitializeXCoreDisassembler();
    LLVMInitializeVEDisassembler();
}
pub fn LLVMInitializeNativeTarget() callconv(.c) LLVMtype.LLVMBool {
    LLVMInitializeX86TargetInfo();
    LLVMInitializeX86Target();
    LLVMInitializeX86TargetMC();
    return 0;
}
pub fn LLVMInitializeNativeAsmParser() callconv(.c) LLVMtype.LLVMBool {
    LLVMInitializeX86AsmParser();
    return 0;
}
pub fn LLVMInitializeNativeAsmPrinter() callconv(.c) LLVMtype.LLVMBool {
    LLVMInitializeX86AsmPrinter();
    return 0;
}
pub fn LLVMInitializeNativeDisassembler() callconv(.c) LLVMtype.LLVMBool {
    LLVMInitializeX86Disassembler();
    return 0;
}

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
