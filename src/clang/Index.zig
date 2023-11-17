const CXString = @import("CXString.zig");
const CXErrorCode = @import("CXErrorCode.zig");
const CXSourceLocation = @import("CXSourceLocation.zig");
const CXFile = @import("CXFile.zig");
const CXDiagnostic = @import("CXDiagnostic.zig");
const std = @import("std");

pub const CXIndex = ?*anyopaque;
pub const CXTargetInfoImpl = opaque {};
pub const CXTargetInfo = ?*CXTargetInfoImpl;
pub const CXTranslationUnitImpl = opaque {};
pub const CXTranslationUnit = ?*CXTranslationUnitImpl;
pub const CXClientData = ?*anyopaque;
pub const CXUnsavedFile = extern struct {
    Filename: [*:0]const u8 = std.mem.zeroes([*:0]const u8),
    Contents: [*:0]const u8 = std.mem.zeroes([*:0]const u8),
    Length: c_ulong = std.mem.zeroes(c_ulong),
};
pub const CXAvailabilityKind = enum(c_uint) {
    CXAvailability_Available = 0,
    CXAvailability_Deprecated = 1,
    CXAvailability_NotAvailable = 2,
    CXAvailability_NotAccessible = 3,
};
pub const CXVersion = extern struct {
    Major: c_int = std.mem.zeroes(c_int),
    Minor: c_int = std.mem.zeroes(c_int),
    Subminor: c_int = std.mem.zeroes(c_int),
};
pub const CXCursor_ExceptionSpecificationKind_None: c_int = 0;
pub const CXCursor_ExceptionSpecificationKind_DynamicNone: c_int = 1;
pub const CXCursor_ExceptionSpecificationKind_Dynamic: c_int = 2;
pub const CXCursor_ExceptionSpecificationKind_MSAny: c_int = 3;
pub const CXCursor_ExceptionSpecificationKind_BasicNoexcept: c_int = 4;
pub const CXCursor_ExceptionSpecificationKind_ComputedNoexcept: c_int = 5;
pub const CXCursor_ExceptionSpecificationKind_Unevaluated: c_int = 6;
pub const CXCursor_ExceptionSpecificationKind_Uninstantiated: c_int = 7;
pub const CXCursor_ExceptionSpecificationKind_Unparsed: c_int = 8;
pub const CXCursor_ExceptionSpecificationKind_NoThrow: c_int = 9;
pub const CXCursor_ExceptionSpecificationKind = c_uint;
pub extern fn clang_createIndex(excludeDeclarationsFromPCH: c_int, displayDiagnostics: c_int) CXIndex;
pub extern fn clang_disposeIndex(index: CXIndex) void;
pub const CXGlobalOpt_None: c_int = 0;
pub const CXGlobalOpt_ThreadBackgroundPriorityForIndexing: c_int = 1;
pub const CXGlobalOpt_ThreadBackgroundPriorityForEditing: c_int = 2;
pub const CXGlobalOpt_ThreadBackgroundPriorityForAll: c_int = 3;
pub const CXGlobalOptFlags = c_uint;
pub extern fn clang_CXIndex_setGlobalOptions(CXIndex, options: c_uint) void;
pub extern fn clang_CXIndex_getGlobalOptions(CXIndex) c_uint;
pub extern fn clang_CXIndex_setInvocationEmissionPathOption(CXIndex, Path: [*:0]const u8) void;
pub extern fn clang_isFileMultipleIncludeGuarded(tu: CXTranslationUnit, file: CXFile.CXFile) c_uint;
pub extern fn clang_getFile(tu: CXTranslationUnit, file_name: [*:0]const u8) CXFile.CXFile;
pub extern fn clang_getFileContents(tu: CXTranslationUnit, file: CXFile.CXFile, size: [*c]usize) [*:0]const u8;
pub extern fn clang_getLocation(tu: CXTranslationUnit, file: CXFile.CXFile, line: c_uint, column: c_uint) CXSourceLocation.CXSourceLocation;
pub extern fn clang_getLocationForOffset(tu: CXTranslationUnit, file: CXFile.CXFile, offset: c_uint) CXSourceLocation.CXSourceLocation;
pub extern fn clang_getSkippedRanges(tu: CXTranslationUnit, file: CXFile.CXFile) [*c]CXSourceLocation.CXSourceRangeList;
pub extern fn clang_getAllSkippedRanges(tu: CXTranslationUnit) [*c]CXSourceLocation.CXSourceRangeList;
pub extern fn clang_getNumDiagnostics(Unit: CXTranslationUnit) c_uint;
pub extern fn clang_getDiagnostic(Unit: CXTranslationUnit, Index: c_uint) CXDiagnostic.CXDiagnostic;
pub extern fn clang_getDiagnosticSetFromTU(Unit: CXTranslationUnit) CXDiagnostic.CXDiagnosticSet;
pub extern fn clang_getTranslationUnitSpelling(CTUnit: CXTranslationUnit) CXString.CXString;
pub extern fn clang_createTranslationUnitFromSourceFile(CIdx: CXIndex, source_filename: [*:0]const u8, num_clang_command_line_args: c_int, clang_command_line_args: [*c]const [*c]const u8, num_unsaved_files: c_uint, unsaved_files: [*c]CXUnsavedFile) CXTranslationUnit;
pub extern fn clang_createTranslationUnit(CIdx: CXIndex, ast_filename: [*:0]const u8) CXTranslationUnit;
pub extern fn clang_createTranslationUnit2(CIdx: CXIndex, ast_filename: [*:0]const u8, out_TU: [*c]CXTranslationUnit) CXErrorCode.CXErrorCode;
pub const CXTranslationUnit_None: c_int = 0;
pub const CXTranslationUnit_DetailedPreprocessingRecord: c_int = 1;
pub const CXTranslationUnit_Incomplete: c_int = 2;
pub const CXTranslationUnit_PrecompiledPreamble: c_int = 4;
pub const CXTranslationUnit_CacheCompletionResults: c_int = 8;
pub const CXTranslationUnit_ForSerialization: c_int = 16;
pub const CXTranslationUnit_CXXChainedPCH: c_int = 32;
pub const CXTranslationUnit_SkipFunctionBodies: c_int = 64;
pub const CXTranslationUnit_IncludeBriefCommentsInCodeCompletion: c_int = 128;
pub const CXTranslationUnit_CreatePreambleOnFirstParse: c_int = 256;
pub const CXTranslationUnit_KeepGoing: c_int = 512;
pub const CXTranslationUnit_SingleFileParse: c_int = 1024;
pub const CXTranslationUnit_LimitSkipFunctionBodiesToPreamble: c_int = 2048;
pub const CXTranslationUnit_IncludeAttributedTypes: c_int = 4096;
pub const CXTranslationUnit_VisitImplicitAttributes: c_int = 8192;
pub const CXTranslationUnit_IgnoreNonErrorsFromIncludedFiles: c_int = 16384;
pub const CXTranslationUnit_RetainExcludedConditionalBlocks: c_int = 32768;
pub const CXTranslationUnit_Flags = c_uint;
pub extern fn clang_defaultEditingTranslationUnitOptions() c_uint;
pub extern fn clang_parseTranslationUnit(CIdx: CXIndex, source_filename: [*:0]const u8, command_line_args: [*c]const [*c]const u8, num_command_line_args: c_int, unsaved_files: [*c]CXUnsavedFile, num_unsaved_files: c_uint, options: c_uint) CXTranslationUnit;
pub extern fn clang_parseTranslationUnit2(CIdx: CXIndex, source_filename: [*:0]const u8, command_line_args: [*c]const [*c]const u8, num_command_line_args: c_int, unsaved_files: [*c]CXUnsavedFile, num_unsaved_files: c_uint, options: c_uint, out_TU: [*c]CXTranslationUnit) CXErrorCode.CXErrorCode;
pub extern fn clang_parseTranslationUnit2FullArgv(CIdx: CXIndex, source_filename: [*:0]const u8, command_line_args: [*c]const [*c]const u8, num_command_line_args: c_int, unsaved_files: [*c]CXUnsavedFile, num_unsaved_files: c_uint, options: c_uint, out_TU: [*c]CXTranslationUnit) CXErrorCode.CXErrorCode;
pub const CXSaveTranslationUnit_None: c_int = 0;
pub const CXSaveTranslationUnit_Flags = c_uint;
pub extern fn clang_defaultSaveOptions(TU: CXTranslationUnit) c_uint;
pub const CXSaveError_None: c_int = 0;
pub const CXSaveError_Unknown: c_int = 1;
pub const CXSaveError_TranslationErrors: c_int = 2;
pub const CXSaveError_InvalidTU: c_int = 3;
pub const CXSaveError = c_uint;
pub extern fn clang_saveTranslationUnit(TU: CXTranslationUnit, FileName: [*:0]const u8, options: c_uint) c_int;
pub extern fn clang_suspendTranslationUnit(CXTranslationUnit) c_uint;
pub extern fn clang_disposeTranslationUnit(CXTranslationUnit) void;
pub const CXReparse_None: c_int = 0;
pub const CXReparse_Flags = c_uint;
pub extern fn clang_defaultReparseOptions(TU: CXTranslationUnit) c_uint;
pub extern fn clang_reparseTranslationUnit(TU: CXTranslationUnit, num_unsaved_files: c_uint, unsaved_files: [*c]CXUnsavedFile, options: c_uint) c_int;
pub const CXTUResourceUsage_AST: c_int = 1;
pub const CXTUResourceUsage_Identifiers: c_int = 2;
pub const CXTUResourceUsage_Selectors: c_int = 3;
pub const CXTUResourceUsage_GlobalCompletionResults: c_int = 4;
pub const CXTUResourceUsage_SourceManagerContentCache: c_int = 5;
pub const CXTUResourceUsage_AST_SideTables: c_int = 6;
pub const CXTUResourceUsage_SourceManager_Membuffer_Malloc: c_int = 7;
pub const CXTUResourceUsage_SourceManager_Membuffer_MMap: c_int = 8;
pub const CXTUResourceUsage_ExternalASTSource_Membuffer_Malloc: c_int = 9;
pub const CXTUResourceUsage_ExternalASTSource_Membuffer_MMap: c_int = 10;
pub const CXTUResourceUsage_Preprocessor: c_int = 11;
pub const CXTUResourceUsage_PreprocessingRecord: c_int = 12;
pub const CXTUResourceUsage_SourceManager_DataStructures: c_int = 13;
pub const CXTUResourceUsage_Preprocessor_HeaderSearch: c_int = 14;
pub const CXTUResourceUsage_MEMORY_IN_BYTES_BEGIN: c_int = 1;
pub const CXTUResourceUsage_MEMORY_IN_BYTES_END: c_int = 14;
pub const CXTUResourceUsage_First: c_int = 1;
pub const CXTUResourceUsage_Last: c_int = 14;
pub const CXTUResourceUsageKind = c_uint;
pub extern fn clang_getTUResourceUsageName(kind: CXTUResourceUsageKind) [*:0]const u8;
pub const CXTUResourceUsageEntry = extern struct {
    kind: CXTUResourceUsageKind = std.mem.zeroes(CXTUResourceUsageKind),
    amount: c_ulong = std.mem.zeroes(c_ulong),
};
pub const CXTUResourceUsage = extern struct {
    data: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    numEntries: c_uint = std.mem.zeroes(c_uint),
    entries: [*c]CXTUResourceUsageEntry = std.mem.zeroes([*c]CXTUResourceUsageEntry),
};
pub extern fn clang_getCXTUResourceUsage(TU: CXTranslationUnit) CXTUResourceUsage;
pub extern fn clang_disposeCXTUResourceUsage(usage: CXTUResourceUsage) void;
pub extern fn clang_getTranslationUnitTargetInfo(CTUnit: CXTranslationUnit) CXTargetInfo;
pub extern fn clang_TargetInfo_dispose(Info: CXTargetInfo) void;
pub extern fn clang_TargetInfo_getTriple(Info: CXTargetInfo) CXString.CXString;
pub extern fn clang_TargetInfo_getPointerWidth(Info: CXTargetInfo) c_int;
pub const CXCursor_UnexposedDecl: c_int = 1;
pub const CXCursor_StructDecl: c_int = 2;
pub const CXCursor_UnionDecl: c_int = 3;
pub const CXCursor_ClassDecl: c_int = 4;
pub const CXCursor_EnumDecl: c_int = 5;
pub const CXCursor_FieldDecl: c_int = 6;
pub const CXCursor_EnumConstantDecl: c_int = 7;
pub const CXCursor_FunctionDecl: c_int = 8;
pub const CXCursor_VarDecl: c_int = 9;
pub const CXCursor_ParmDecl: c_int = 10;
pub const CXCursor_ObjCInterfaceDecl: c_int = 11;
pub const CXCursor_ObjCCategoryDecl: c_int = 12;
pub const CXCursor_ObjCProtocolDecl: c_int = 13;
pub const CXCursor_ObjCPropertyDecl: c_int = 14;
pub const CXCursor_ObjCIvarDecl: c_int = 15;
pub const CXCursor_ObjCInstanceMethodDecl: c_int = 16;
pub const CXCursor_ObjCClassMethodDecl: c_int = 17;
pub const CXCursor_ObjCImplementationDecl: c_int = 18;
pub const CXCursor_ObjCCategoryImplDecl: c_int = 19;
pub const CXCursor_TypedefDecl: c_int = 20;
pub const CXCursor_CXXMethod: c_int = 21;
pub const CXCursor_Namespace: c_int = 22;
pub const CXCursor_LinkageSpec: c_int = 23;
pub const CXCursor_Constructor: c_int = 24;
pub const CXCursor_Destructor: c_int = 25;
pub const CXCursor_ConversionFunction: c_int = 26;
pub const CXCursor_TemplateTypeParameter: c_int = 27;
pub const CXCursor_NonTypeTemplateParameter: c_int = 28;
pub const CXCursor_TemplateTemplateParameter: c_int = 29;
pub const CXCursor_FunctionTemplate: c_int = 30;
pub const CXCursor_ClassTemplate: c_int = 31;
pub const CXCursor_ClassTemplatePartialSpecialization: c_int = 32;
pub const CXCursor_NamespaceAlias: c_int = 33;
pub const CXCursor_UsingDirective: c_int = 34;
pub const CXCursor_UsingDeclaration: c_int = 35;
pub const CXCursor_TypeAliasDecl: c_int = 36;
pub const CXCursor_ObjCSynthesizeDecl: c_int = 37;
pub const CXCursor_ObjCDynamicDecl: c_int = 38;
pub const CXCursor_CXXAccessSpecifier: c_int = 39;
pub const CXCursor_FirstDecl: c_int = 1;
pub const CXCursor_LastDecl: c_int = 39;
pub const CXCursor_FirstRef: c_int = 40;
pub const CXCursor_ObjCSuperClassRef: c_int = 40;
pub const CXCursor_ObjCProtocolRef: c_int = 41;
pub const CXCursor_ObjCClassRef: c_int = 42;
pub const CXCursor_TypeRef: c_int = 43;
pub const CXCursor_CXXBaseSpecifier: c_int = 44;
pub const CXCursor_TemplateRef: c_int = 45;
pub const CXCursor_NamespaceRef: c_int = 46;
pub const CXCursor_MemberRef: c_int = 47;
pub const CXCursor_LabelRef: c_int = 48;
pub const CXCursor_OverloadedDeclRef: c_int = 49;
pub const CXCursor_VariableRef: c_int = 50;
pub const CXCursor_LastRef: c_int = 50;
pub const CXCursor_FirstInvalid: c_int = 70;
pub const CXCursor_InvalidFile: c_int = 70;
pub const CXCursor_NoDeclFound: c_int = 71;
pub const CXCursor_NotImplemented: c_int = 72;
pub const CXCursor_InvalidCode: c_int = 73;
pub const CXCursor_LastInvalid: c_int = 73;
pub const CXCursor_FirstExpr: c_int = 100;
pub const CXCursor_UnexposedExpr: c_int = 100;
pub const CXCursor_DeclRefExpr: c_int = 101;
pub const CXCursor_MemberRefExpr: c_int = 102;
pub const CXCursor_CallExpr: c_int = 103;
pub const CXCursor_ObjCMessageExpr: c_int = 104;
pub const CXCursor_BlockExpr: c_int = 105;
pub const CXCursor_IntegerLiteral: c_int = 106;
pub const CXCursor_FloatingLiteral: c_int = 107;
pub const CXCursor_ImaginaryLiteral: c_int = 108;
pub const CXCursor_StringLiteral: c_int = 109;
pub const CXCursor_CharacterLiteral: c_int = 110;
pub const CXCursor_ParenExpr: c_int = 111;
pub const CXCursor_UnaryOperator: c_int = 112;
pub const CXCursor_ArraySubscriptExpr: c_int = 113;
pub const CXCursor_BinaryOperator: c_int = 114;
pub const CXCursor_CompoundAssignOperator: c_int = 115;
pub const CXCursor_ConditionalOperator: c_int = 116;
pub const CXCursor_CStyleCastExpr: c_int = 117;
pub const CXCursor_CompoundLiteralExpr: c_int = 118;
pub const CXCursor_InitListExpr: c_int = 119;
pub const CXCursor_AddrLabelExpr: c_int = 120;
pub const CXCursor_StmtExpr: c_int = 121;
pub const CXCursor_GenericSelectionExpr: c_int = 122;
pub const CXCursor_GNUNullExpr: c_int = 123;
pub const CXCursor_CXXStaticCastExpr: c_int = 124;
pub const CXCursor_CXXDynamicCastExpr: c_int = 125;
pub const CXCursor_CXXReinterpretCastExpr: c_int = 126;
pub const CXCursor_CXXConstCastExpr: c_int = 127;
pub const CXCursor_CXXFunctionalCastExpr: c_int = 128;
pub const CXCursor_CXXTypeidExpr: c_int = 129;
pub const CXCursor_CXXBoolLiteralExpr: c_int = 130;
pub const CXCursor_CXXNullPtrLiteralExpr: c_int = 131;
pub const CXCursor_CXXThisExpr: c_int = 132;
pub const CXCursor_CXXThrowExpr: c_int = 133;
pub const CXCursor_CXXNewExpr: c_int = 134;
pub const CXCursor_CXXDeleteExpr: c_int = 135;
pub const CXCursor_UnaryExpr: c_int = 136;
pub const CXCursor_ObjCStringLiteral: c_int = 137;
pub const CXCursor_ObjCEncodeExpr: c_int = 138;
pub const CXCursor_ObjCSelectorExpr: c_int = 139;
pub const CXCursor_ObjCProtocolExpr: c_int = 140;
pub const CXCursor_ObjCBridgedCastExpr: c_int = 141;
pub const CXCursor_PackExpansionExpr: c_int = 142;
pub const CXCursor_SizeOfPackExpr: c_int = 143;
pub const CXCursor_LambdaExpr: c_int = 144;
pub const CXCursor_ObjCBoolLiteralExpr: c_int = 145;
pub const CXCursor_ObjCSelfExpr: c_int = 146;
pub const CXCursor_OMPArraySectionExpr: c_int = 147;
pub const CXCursor_ObjCAvailabilityCheckExpr: c_int = 148;
pub const CXCursor_FixedPointLiteral: c_int = 149;
pub const CXCursor_OMPArrayShapingExpr: c_int = 150;
pub const CXCursor_OMPIteratorExpr: c_int = 151;
pub const CXCursor_CXXAddrspaceCastExpr: c_int = 152;
pub const CXCursor_ConceptSpecializationExpr: c_int = 153;
pub const CXCursor_RequiresExpr: c_int = 154;
pub const CXCursor_CXXParenListInitExpr: c_int = 155;
pub const CXCursor_LastExpr: c_int = 155;
pub const CXCursor_FirstStmt: c_int = 200;
pub const CXCursor_UnexposedStmt: c_int = 200;
pub const CXCursor_LabelStmt: c_int = 201;
pub const CXCursor_CompoundStmt: c_int = 202;
pub const CXCursor_CaseStmt: c_int = 203;
pub const CXCursor_DefaultStmt: c_int = 204;
pub const CXCursor_IfStmt: c_int = 205;
pub const CXCursor_SwitchStmt: c_int = 206;
pub const CXCursor_WhileStmt: c_int = 207;
pub const CXCursor_DoStmt: c_int = 208;
pub const CXCursor_ForStmt: c_int = 209;
pub const CXCursor_GotoStmt: c_int = 210;
pub const CXCursor_IndirectGotoStmt: c_int = 211;
pub const CXCursor_ContinueStmt: c_int = 212;
pub const CXCursor_BreakStmt: c_int = 213;
pub const CXCursor_ReturnStmt: c_int = 214;
pub const CXCursor_GCCAsmStmt: c_int = 215;
pub const CXCursor_AsmStmt: c_int = 215;
pub const CXCursor_ObjCAtTryStmt: c_int = 216;
pub const CXCursor_ObjCAtCatchStmt: c_int = 217;
pub const CXCursor_ObjCAtFinallyStmt: c_int = 218;
pub const CXCursor_ObjCAtThrowStmt: c_int = 219;
pub const CXCursor_ObjCAtSynchronizedStmt: c_int = 220;
pub const CXCursor_ObjCAutoreleasePoolStmt: c_int = 221;
pub const CXCursor_ObjCForCollectionStmt: c_int = 222;
pub const CXCursor_CXXCatchStmt: c_int = 223;
pub const CXCursor_CXXTryStmt: c_int = 224;
pub const CXCursor_CXXForRangeStmt: c_int = 225;
pub const CXCursor_SEHTryStmt: c_int = 226;
pub const CXCursor_SEHExceptStmt: c_int = 227;
pub const CXCursor_SEHFinallyStmt: c_int = 228;
pub const CXCursor_MSAsmStmt: c_int = 229;
pub const CXCursor_NullStmt: c_int = 230;
pub const CXCursor_DeclStmt: c_int = 231;
pub const CXCursor_OMPParallelDirective: c_int = 232;
pub const CXCursor_OMPSimdDirective: c_int = 233;
pub const CXCursor_OMPForDirective: c_int = 234;
pub const CXCursor_OMPSectionsDirective: c_int = 235;
pub const CXCursor_OMPSectionDirective: c_int = 236;
pub const CXCursor_OMPSingleDirective: c_int = 237;
pub const CXCursor_OMPParallelForDirective: c_int = 238;
pub const CXCursor_OMPParallelSectionsDirective: c_int = 239;
pub const CXCursor_OMPTaskDirective: c_int = 240;
pub const CXCursor_OMPMasterDirective: c_int = 241;
pub const CXCursor_OMPCriticalDirective: c_int = 242;
pub const CXCursor_OMPTaskyieldDirective: c_int = 243;
pub const CXCursor_OMPBarrierDirective: c_int = 244;
pub const CXCursor_OMPTaskwaitDirective: c_int = 245;
pub const CXCursor_OMPFlushDirective: c_int = 246;
pub const CXCursor_SEHLeaveStmt: c_int = 247;
pub const CXCursor_OMPOrderedDirective: c_int = 248;
pub const CXCursor_OMPAtomicDirective: c_int = 249;
pub const CXCursor_OMPForSimdDirective: c_int = 250;
pub const CXCursor_OMPParallelForSimdDirective: c_int = 251;
pub const CXCursor_OMPTargetDirective: c_int = 252;
pub const CXCursor_OMPTeamsDirective: c_int = 253;
pub const CXCursor_OMPTaskgroupDirective: c_int = 254;
pub const CXCursor_OMPCancellationPointDirective: c_int = 255;
pub const CXCursor_OMPCancelDirective: c_int = 256;
pub const CXCursor_OMPTargetDataDirective: c_int = 257;
pub const CXCursor_OMPTaskLoopDirective: c_int = 258;
pub const CXCursor_OMPTaskLoopSimdDirective: c_int = 259;
pub const CXCursor_OMPDistributeDirective: c_int = 260;
pub const CXCursor_OMPTargetEnterDataDirective: c_int = 261;
pub const CXCursor_OMPTargetExitDataDirective: c_int = 262;
pub const CXCursor_OMPTargetParallelDirective: c_int = 263;
pub const CXCursor_OMPTargetParallelForDirective: c_int = 264;
pub const CXCursor_OMPTargetUpdateDirective: c_int = 265;
pub const CXCursor_OMPDistributeParallelForDirective: c_int = 266;
pub const CXCursor_OMPDistributeParallelForSimdDirective: c_int = 267;
pub const CXCursor_OMPDistributeSimdDirective: c_int = 268;
pub const CXCursor_OMPTargetParallelForSimdDirective: c_int = 269;
pub const CXCursor_OMPTargetSimdDirective: c_int = 270;
pub const CXCursor_OMPTeamsDistributeDirective: c_int = 271;
pub const CXCursor_OMPTeamsDistributeSimdDirective: c_int = 272;
pub const CXCursor_OMPTeamsDistributeParallelForSimdDirective: c_int = 273;
pub const CXCursor_OMPTeamsDistributeParallelForDirective: c_int = 274;
pub const CXCursor_OMPTargetTeamsDirective: c_int = 275;
pub const CXCursor_OMPTargetTeamsDistributeDirective: c_int = 276;
pub const CXCursor_OMPTargetTeamsDistributeParallelForDirective: c_int = 277;
pub const CXCursor_OMPTargetTeamsDistributeParallelForSimdDirective: c_int = 278;
pub const CXCursor_OMPTargetTeamsDistributeSimdDirective: c_int = 279;
pub const CXCursor_BuiltinBitCastExpr: c_int = 280;
pub const CXCursor_OMPMasterTaskLoopDirective: c_int = 281;
pub const CXCursor_OMPParallelMasterTaskLoopDirective: c_int = 282;
pub const CXCursor_OMPMasterTaskLoopSimdDirective: c_int = 283;
pub const CXCursor_OMPParallelMasterTaskLoopSimdDirective: c_int = 284;
pub const CXCursor_OMPParallelMasterDirective: c_int = 285;
pub const CXCursor_OMPDepobjDirective: c_int = 286;
pub const CXCursor_OMPScanDirective: c_int = 287;
pub const CXCursor_OMPTileDirective: c_int = 288;
pub const CXCursor_OMPCanonicalLoop: c_int = 289;
pub const CXCursor_OMPInteropDirective: c_int = 290;
pub const CXCursor_OMPDispatchDirective: c_int = 291;
pub const CXCursor_OMPMaskedDirective: c_int = 292;
pub const CXCursor_OMPUnrollDirective: c_int = 293;
pub const CXCursor_OMPMetaDirective: c_int = 294;
pub const CXCursor_OMPGenericLoopDirective: c_int = 295;
pub const CXCursor_OMPTeamsGenericLoopDirective: c_int = 296;
pub const CXCursor_OMPTargetTeamsGenericLoopDirective: c_int = 297;
pub const CXCursor_OMPParallelGenericLoopDirective: c_int = 298;
pub const CXCursor_OMPTargetParallelGenericLoopDirective: c_int = 299;
pub const CXCursor_OMPParallelMaskedDirective: c_int = 300;
pub const CXCursor_OMPMaskedTaskLoopDirective: c_int = 301;
pub const CXCursor_OMPMaskedTaskLoopSimdDirective: c_int = 302;
pub const CXCursor_OMPParallelMaskedTaskLoopDirective: c_int = 303;
pub const CXCursor_OMPParallelMaskedTaskLoopSimdDirective: c_int = 304;
pub const CXCursor_OMPErrorDirective: c_int = 305;
pub const CXCursor_LastStmt: c_int = 305;
pub const CXCursor_TranslationUnit: c_int = 350;
pub const CXCursor_FirstAttr: c_int = 400;
pub const CXCursor_UnexposedAttr: c_int = 400;
pub const CXCursor_IBActionAttr: c_int = 401;
pub const CXCursor_IBOutletAttr: c_int = 402;
pub const CXCursor_IBOutletCollectionAttr: c_int = 403;
pub const CXCursor_CXXFinalAttr: c_int = 404;
pub const CXCursor_CXXOverrideAttr: c_int = 405;
pub const CXCursor_AnnotateAttr: c_int = 406;
pub const CXCursor_AsmLabelAttr: c_int = 407;
pub const CXCursor_PackedAttr: c_int = 408;
pub const CXCursor_PureAttr: c_int = 409;
pub const CXCursor_ConstAttr: c_int = 410;
pub const CXCursor_NoDuplicateAttr: c_int = 411;
pub const CXCursor_CUDAConstantAttr: c_int = 412;
pub const CXCursor_CUDADeviceAttr: c_int = 413;
pub const CXCursor_CUDAGlobalAttr: c_int = 414;
pub const CXCursor_CUDAHostAttr: c_int = 415;
pub const CXCursor_CUDASharedAttr: c_int = 416;
pub const CXCursor_VisibilityAttr: c_int = 417;
pub const CXCursor_DLLExport: c_int = 418;
pub const CXCursor_DLLImport: c_int = 419;
pub const CXCursor_NSReturnsRetained: c_int = 420;
pub const CXCursor_NSReturnsNotRetained: c_int = 421;
pub const CXCursor_NSReturnsAutoreleased: c_int = 422;
pub const CXCursor_NSConsumesSelf: c_int = 423;
pub const CXCursor_NSConsumed: c_int = 424;
pub const CXCursor_ObjCException: c_int = 425;
pub const CXCursor_ObjCNSObject: c_int = 426;
pub const CXCursor_ObjCIndependentClass: c_int = 427;
pub const CXCursor_ObjCPreciseLifetime: c_int = 428;
pub const CXCursor_ObjCReturnsInnerPointer: c_int = 429;
pub const CXCursor_ObjCRequiresSuper: c_int = 430;
pub const CXCursor_ObjCRootClass: c_int = 431;
pub const CXCursor_ObjCSubclassingRestricted: c_int = 432;
pub const CXCursor_ObjCExplicitProtocolImpl: c_int = 433;
pub const CXCursor_ObjCDesignatedInitializer: c_int = 434;
pub const CXCursor_ObjCRuntimeVisible: c_int = 435;
pub const CXCursor_ObjCBoxable: c_int = 436;
pub const CXCursor_FlagEnum: c_int = 437;
pub const CXCursor_ConvergentAttr: c_int = 438;
pub const CXCursor_WarnUnusedAttr: c_int = 439;
pub const CXCursor_WarnUnusedResultAttr: c_int = 440;
pub const CXCursor_AlignedAttr: c_int = 441;
pub const CXCursor_LastAttr: c_int = 441;
pub const CXCursor_PreprocessingDirective: c_int = 500;
pub const CXCursor_MacroDefinition: c_int = 501;
pub const CXCursor_MacroExpansion: c_int = 502;
pub const CXCursor_MacroInstantiation: c_int = 502;
pub const CXCursor_InclusionDirective: c_int = 503;
pub const CXCursor_FirstPreprocessing: c_int = 500;
pub const CXCursor_LastPreprocessing: c_int = 503;
pub const CXCursor_ModuleImportDecl: c_int = 600;
pub const CXCursor_TypeAliasTemplateDecl: c_int = 601;
pub const CXCursor_StaticAssert: c_int = 602;
pub const CXCursor_FriendDecl: c_int = 603;
pub const CXCursor_ConceptDecl: c_int = 604;
pub const CXCursor_FirstExtraDecl: c_int = 600;
pub const CXCursor_LastExtraDecl: c_int = 604;
pub const CXCursor_OverloadCandidate: c_int = 700;
pub const CXCursorKind = c_uint;
pub const CXCursor = extern struct {
    kind: CXCursorKind = std.mem.zeroes(CXCursorKind),
    xdata: c_int = std.mem.zeroes(c_int),
    data: [3]?*const anyopaque = std.mem.zeroes([3]?*const anyopaque),
};
pub extern fn clang_getNullCursor() CXCursor;
pub extern fn clang_getTranslationUnitCursor(CXTranslationUnit) CXCursor;
pub extern fn clang_equalCursors(CXCursor, CXCursor) c_uint;
pub extern fn clang_Cursor_isNull(cursor: CXCursor) c_int;
pub extern fn clang_hashCursor(CXCursor) c_uint;
pub extern fn clang_getCursorKind(CXCursor) CXCursorKind;
pub extern fn clang_isDeclaration(CXCursorKind) c_uint;
pub extern fn clang_isInvalidDeclaration(CXCursor) c_uint;
pub extern fn clang_isReference(CXCursorKind) c_uint;
pub extern fn clang_isExpression(CXCursorKind) c_uint;
pub extern fn clang_isStatement(CXCursorKind) c_uint;
pub extern fn clang_isAttribute(CXCursorKind) c_uint;
pub extern fn clang_Cursor_hasAttrs(C: CXCursor) c_uint;
pub extern fn clang_isInvalid(CXCursorKind) c_uint;
pub extern fn clang_isTranslationUnit(CXCursorKind) c_uint;
pub extern fn clang_isPreprocessing(CXCursorKind) c_uint;
pub extern fn clang_isUnexposed(CXCursorKind) c_uint;
pub const CXLinkage_Invalid: c_int = 0;
pub const CXLinkage_NoLinkage: c_int = 1;
pub const CXLinkage_Internal: c_int = 2;
pub const CXLinkage_UniqueExternal: c_int = 3;
pub const CXLinkage_External: c_int = 4;
pub const CXLinkageKind = c_uint;
pub extern fn clang_getCursorLinkage(cursor: CXCursor) CXLinkageKind;
pub const CXVisibility_Invalid: c_int = 0;
pub const CXVisibility_Hidden: c_int = 1;
pub const CXVisibility_Protected: c_int = 2;
pub const CXVisibility_Default: c_int = 3;
pub const CXVisibilityKind = c_uint;
pub extern fn clang_getCursorVisibility(cursor: CXCursor) CXVisibilityKind;
pub extern fn clang_getCursorAvailability(cursor: CXCursor) CXAvailabilityKind;
pub const CXPlatformAvailability = extern struct {
    Platform: CXString.CXString = std.mem.zeroes(CXString.CXString),
    Introduced: CXVersion = std.mem.zeroes(CXVersion),
    Deprecated: CXVersion = std.mem.zeroes(CXVersion),
    Obsoleted: CXVersion = std.mem.zeroes(CXVersion),
    Unavailable: c_int = std.mem.zeroes(c_int),
    Message: CXString.CXString = std.mem.zeroes(CXString.CXString),
};
pub extern fn clang_getCursorPlatformAvailability(cursor: CXCursor, always_deprecated: [*c]c_int, deprecated_message: [*c]CXString.CXString, always_unavailable: [*c]c_int, unavailable_message: [*c]CXString.CXString, availability: [*c]CXPlatformAvailability, availability_size: c_int) c_int;
pub extern fn clang_disposeCXPlatformAvailability(availability: [*c]CXPlatformAvailability) void;
pub extern fn clang_Cursor_getVarDeclInitializer(cursor: CXCursor) CXCursor;
pub extern fn clang_Cursor_hasVarDeclGlobalStorage(cursor: CXCursor) c_int;
pub extern fn clang_Cursor_hasVarDeclExternalStorage(cursor: CXCursor) c_int;
pub const CXLanguage_Invalid: c_int = 0;
pub const CXLanguage_C: c_int = 1;
pub const CXLanguage_ObjC: c_int = 2;
pub const CXLanguage_CPlusPlus: c_int = 3;
pub const CXLanguageKind = c_uint;
pub extern fn clang_getCursorLanguage(cursor: CXCursor) CXLanguageKind;
pub const CXTLS_None: c_int = 0;
pub const CXTLS_Dynamic: c_int = 1;
pub const CXTLS_Static: c_int = 2;
pub const CXTLSKind = c_uint;
pub extern fn clang_getCursorTLSKind(cursor: CXCursor) CXTLSKind;
pub extern fn clang_Cursor_getTranslationUnit(CXCursor) CXTranslationUnit;
pub const CXCursorSetImpl = opaque {};
pub const CXCursorSet = ?*CXCursorSetImpl;
pub extern fn clang_createCXCursorSet() CXCursorSet;
pub extern fn clang_disposeCXCursorSet(cset: CXCursorSet) void;
pub extern fn clang_CXCursorSet_contains(cset: CXCursorSet, cursor: CXCursor) c_uint;
pub extern fn clang_CXCursorSet_insert(cset: CXCursorSet, cursor: CXCursor) c_uint;
pub extern fn clang_getCursorSemanticParent(cursor: CXCursor) CXCursor;
pub extern fn clang_getCursorLexicalParent(cursor: CXCursor) CXCursor;
pub extern fn clang_getOverriddenCursors(cursor: CXCursor, overridden: [*c][*c]CXCursor, num_overridden: [*c]c_uint) void;
pub extern fn clang_disposeOverriddenCursors(overridden: [*c]CXCursor) void;
pub extern fn clang_getIncludedFile(cursor: CXCursor) CXFile.CXFile;
pub extern fn clang_getCursor(CXTranslationUnit, CXSourceLocation.CXSourceLocation) CXCursor;
pub extern fn clang_getCursorLocation(CXCursor) CXSourceLocation.CXSourceLocation;
pub extern fn clang_getCursorExtent(CXCursor) CXSourceLocation.CXSourceRange;
pub const CXType_Invalid: c_int = 0;
pub const CXType_Unexposed: c_int = 1;
pub const CXType_Void: c_int = 2;
pub const CXType_Bool: c_int = 3;
pub const CXType_Char_U: c_int = 4;
pub const CXType_UChar: c_int = 5;
pub const CXType_Char16: c_int = 6;
pub const CXType_Char32: c_int = 7;
pub const CXType_UShort: c_int = 8;
pub const CXType_UInt: c_int = 9;
pub const CXType_ULong: c_int = 10;
pub const CXType_ULongLong: c_int = 11;
pub const CXType_UInt128: c_int = 12;
pub const CXType_Char_S: c_int = 13;
pub const CXType_SChar: c_int = 14;
pub const CXType_WChar: c_int = 15;
pub const CXType_Short: c_int = 16;
pub const CXType_Int: c_int = 17;
pub const CXType_Long: c_int = 18;
pub const CXType_LongLong: c_int = 19;
pub const CXType_Int128: c_int = 20;
pub const CXType_Float: c_int = 21;
pub const CXType_Double: c_int = 22;
pub const CXType_LongDouble: c_int = 23;
pub const CXType_NullPtr: c_int = 24;
pub const CXType_Overload: c_int = 25;
pub const CXType_Dependent: c_int = 26;
pub const CXType_ObjCId: c_int = 27;
pub const CXType_ObjCClass: c_int = 28;
pub const CXType_ObjCSel: c_int = 29;
pub const CXType_Float128: c_int = 30;
pub const CXType_Half: c_int = 31;
pub const CXType_Float16: c_int = 32;
pub const CXType_ShortAccum: c_int = 33;
pub const CXType_Accum: c_int = 34;
pub const CXType_LongAccum: c_int = 35;
pub const CXType_UShortAccum: c_int = 36;
pub const CXType_UAccum: c_int = 37;
pub const CXType_ULongAccum: c_int = 38;
pub const CXType_BFloat16: c_int = 39;
pub const CXType_Ibm128: c_int = 40;
pub const CXType_FirstBuiltin: c_int = 2;
pub const CXType_LastBuiltin: c_int = 40;
pub const CXType_Complex: c_int = 100;
pub const CXType_Pointer: c_int = 101;
pub const CXType_BlockPointer: c_int = 102;
pub const CXType_LValueReference: c_int = 103;
pub const CXType_RValueReference: c_int = 104;
pub const CXType_Record: c_int = 105;
pub const CXType_Enum: c_int = 106;
pub const CXType_Typedef: c_int = 107;
pub const CXType_ObjCInterface: c_int = 108;
pub const CXType_ObjCObjectPointer: c_int = 109;
pub const CXType_FunctionNoProto: c_int = 110;
pub const CXType_FunctionProto: c_int = 111;
pub const CXType_ConstantArray: c_int = 112;
pub const CXType_Vector: c_int = 113;
pub const CXType_IncompleteArray: c_int = 114;
pub const CXType_VariableArray: c_int = 115;
pub const CXType_DependentSizedArray: c_int = 116;
pub const CXType_MemberPointer: c_int = 117;
pub const CXType_Auto: c_int = 118;
pub const CXType_Elaborated: c_int = 119;
pub const CXType_Pipe: c_int = 120;
pub const CXType_OCLImage1dRO: c_int = 121;
pub const CXType_OCLImage1dArrayRO: c_int = 122;
pub const CXType_OCLImage1dBufferRO: c_int = 123;
pub const CXType_OCLImage2dRO: c_int = 124;
pub const CXType_OCLImage2dArrayRO: c_int = 125;
pub const CXType_OCLImage2dDepthRO: c_int = 126;
pub const CXType_OCLImage2dArrayDepthRO: c_int = 127;
pub const CXType_OCLImage2dMSAARO: c_int = 128;
pub const CXType_OCLImage2dArrayMSAARO: c_int = 129;
pub const CXType_OCLImage2dMSAADepthRO: c_int = 130;
pub const CXType_OCLImage2dArrayMSAADepthRO: c_int = 131;
pub const CXType_OCLImage3dRO: c_int = 132;
pub const CXType_OCLImage1dWO: c_int = 133;
pub const CXType_OCLImage1dArrayWO: c_int = 134;
pub const CXType_OCLImage1dBufferWO: c_int = 135;
pub const CXType_OCLImage2dWO: c_int = 136;
pub const CXType_OCLImage2dArrayWO: c_int = 137;
pub const CXType_OCLImage2dDepthWO: c_int = 138;
pub const CXType_OCLImage2dArrayDepthWO: c_int = 139;
pub const CXType_OCLImage2dMSAAWO: c_int = 140;
pub const CXType_OCLImage2dArrayMSAAWO: c_int = 141;
pub const CXType_OCLImage2dMSAADepthWO: c_int = 142;
pub const CXType_OCLImage2dArrayMSAADepthWO: c_int = 143;
pub const CXType_OCLImage3dWO: c_int = 144;
pub const CXType_OCLImage1dRW: c_int = 145;
pub const CXType_OCLImage1dArrayRW: c_int = 146;
pub const CXType_OCLImage1dBufferRW: c_int = 147;
pub const CXType_OCLImage2dRW: c_int = 148;
pub const CXType_OCLImage2dArrayRW: c_int = 149;
pub const CXType_OCLImage2dDepthRW: c_int = 150;
pub const CXType_OCLImage2dArrayDepthRW: c_int = 151;
pub const CXType_OCLImage2dMSAARW: c_int = 152;
pub const CXType_OCLImage2dArrayMSAARW: c_int = 153;
pub const CXType_OCLImage2dMSAADepthRW: c_int = 154;
pub const CXType_OCLImage2dArrayMSAADepthRW: c_int = 155;
pub const CXType_OCLImage3dRW: c_int = 156;
pub const CXType_OCLSampler: c_int = 157;
pub const CXType_OCLEvent: c_int = 158;
pub const CXType_OCLQueue: c_int = 159;
pub const CXType_OCLReserveID: c_int = 160;
pub const CXType_ObjCObject: c_int = 161;
pub const CXType_ObjCTypeParam: c_int = 162;
pub const CXType_Attributed: c_int = 163;
pub const CXType_OCLIntelSubgroupAVCMcePayload: c_int = 164;
pub const CXType_OCLIntelSubgroupAVCImePayload: c_int = 165;
pub const CXType_OCLIntelSubgroupAVCRefPayload: c_int = 166;
pub const CXType_OCLIntelSubgroupAVCSicPayload: c_int = 167;
pub const CXType_OCLIntelSubgroupAVCMceResult: c_int = 168;
pub const CXType_OCLIntelSubgroupAVCImeResult: c_int = 169;
pub const CXType_OCLIntelSubgroupAVCRefResult: c_int = 170;
pub const CXType_OCLIntelSubgroupAVCSicResult: c_int = 171;
pub const CXType_OCLIntelSubgroupAVCImeResultSingleRefStreamout: c_int = 172;
pub const CXType_OCLIntelSubgroupAVCImeResultDualRefStreamout: c_int = 173;
pub const CXType_OCLIntelSubgroupAVCImeSingleRefStreamin: c_int = 174;
pub const CXType_OCLIntelSubgroupAVCImeDualRefStreamin: c_int = 175;
pub const CXType_ExtVector: c_int = 176;
pub const CXType_Atomic: c_int = 177;
pub const CXType_BTFTagAttributed: c_int = 178;
pub const CXTypeKind = c_uint;
pub const CXCallingConv_Default: c_int = 0;
pub const CXCallingConv_C: c_int = 1;
pub const CXCallingConv_X86StdCall: c_int = 2;
pub const CXCallingConv_X86FastCall: c_int = 3;
pub const CXCallingConv_X86ThisCall: c_int = 4;
pub const CXCallingConv_X86Pascal: c_int = 5;
pub const CXCallingConv_AAPCS: c_int = 6;
pub const CXCallingConv_AAPCS_VFP: c_int = 7;
pub const CXCallingConv_X86RegCall: c_int = 8;
pub const CXCallingConv_IntelOclBicc: c_int = 9;
pub const CXCallingConv_Win64: c_int = 10;
pub const CXCallingConv_X86_64Win64: c_int = 10;
pub const CXCallingConv_X86_64SysV: c_int = 11;
pub const CXCallingConv_X86VectorCall: c_int = 12;
pub const CXCallingConv_Swift: c_int = 13;
pub const CXCallingConv_PreserveMost: c_int = 14;
pub const CXCallingConv_PreserveAll: c_int = 15;
pub const CXCallingConv_AArch64VectorCall: c_int = 16;
pub const CXCallingConv_SwiftAsync: c_int = 17;
pub const CXCallingConv_AArch64SVEPCS: c_int = 18;
pub const CXCallingConv_Invalid: c_int = 100;
pub const CXCallingConv_Unexposed: c_int = 200;
pub const CXCallingConv = c_uint;
pub const CXType = extern struct {
    kind: CXTypeKind = std.mem.zeroes(CXTypeKind),
    data: [2]?*anyopaque = std.mem.zeroes([2]?*anyopaque),
};
pub extern fn clang_getCursorType(C: CXCursor) CXType;
pub extern fn clang_getTypeSpelling(CT: CXType) CXString.CXString;
pub extern fn clang_getTypedefDeclUnderlyingType(C: CXCursor) CXType;
pub extern fn clang_getEnumDeclIntegerType(C: CXCursor) CXType;
pub extern fn clang_getEnumConstantDeclValue(C: CXCursor) c_longlong;
pub extern fn clang_getEnumConstantDeclUnsignedValue(C: CXCursor) c_ulonglong;
pub extern fn clang_getFieldDeclBitWidth(C: CXCursor) c_int;
pub extern fn clang_Cursor_getNumArguments(C: CXCursor) c_int;
pub extern fn clang_Cursor_getArgument(C: CXCursor, i: c_uint) CXCursor;
pub const CXTemplateArgumentKind_Null: c_int = 0;
pub const CXTemplateArgumentKind_Type: c_int = 1;
pub const CXTemplateArgumentKind_Declaration: c_int = 2;
pub const CXTemplateArgumentKind_NullPtr: c_int = 3;
pub const CXTemplateArgumentKind_Integral: c_int = 4;
pub const CXTemplateArgumentKind_Template: c_int = 5;
pub const CXTemplateArgumentKind_TemplateExpansion: c_int = 6;
pub const CXTemplateArgumentKind_Expression: c_int = 7;
pub const CXTemplateArgumentKind_Pack: c_int = 8;
pub const CXTemplateArgumentKind_Invalid: c_int = 9;
pub const CXTemplateArgumentKind = c_uint;
pub extern fn clang_Cursor_getNumTemplateArguments(C: CXCursor) c_int;
pub extern fn clang_Cursor_getTemplateArgumentKind(C: CXCursor, I: c_uint) CXTemplateArgumentKind;
pub extern fn clang_Cursor_getTemplateArgumentType(C: CXCursor, I: c_uint) CXType;
pub extern fn clang_Cursor_getTemplateArgumentValue(C: CXCursor, I: c_uint) c_longlong;
pub extern fn clang_Cursor_getTemplateArgumentUnsignedValue(C: CXCursor, I: c_uint) c_ulonglong;
pub extern fn clang_equalTypes(A: CXType, B: CXType) c_uint;
pub extern fn clang_getCanonicalType(T: CXType) CXType;
pub extern fn clang_isConstQualifiedType(T: CXType) c_uint;
pub extern fn clang_Cursor_isMacroFunctionLike(C: CXCursor) c_uint;
pub extern fn clang_Cursor_isMacroBuiltin(C: CXCursor) c_uint;
pub extern fn clang_Cursor_isFunctionInlined(C: CXCursor) c_uint;
pub extern fn clang_isVolatileQualifiedType(T: CXType) c_uint;
pub extern fn clang_isRestrictQualifiedType(T: CXType) c_uint;
pub extern fn clang_getAddressSpace(T: CXType) c_uint;
pub extern fn clang_getTypedefName(CT: CXType) CXString.CXString;
pub extern fn clang_getPointeeType(T: CXType) CXType;
pub extern fn clang_getUnqualifiedType(CT: CXType) CXType;
pub extern fn clang_getNonReferenceType(CT: CXType) CXType;
pub extern fn clang_getTypeDeclaration(T: CXType) CXCursor;
pub extern fn clang_getDeclObjCTypeEncoding(C: CXCursor) CXString.CXString;
pub extern fn clang_Type_getObjCEncoding(@"type": CXType) CXString.CXString;
pub extern fn clang_getTypeKindSpelling(K: CXTypeKind) CXString.CXString;
pub extern fn clang_getFunctionTypeCallingConv(T: CXType) CXCallingConv;
pub extern fn clang_getResultType(T: CXType) CXType;
pub extern fn clang_getExceptionSpecificationType(T: CXType) c_int;
pub extern fn clang_getNumArgTypes(T: CXType) c_int;
pub extern fn clang_getArgType(T: CXType, i: c_uint) CXType;
pub extern fn clang_Type_getObjCObjectBaseType(T: CXType) CXType;
pub extern fn clang_Type_getNumObjCProtocolRefs(T: CXType) c_uint;
pub extern fn clang_Type_getObjCProtocolDecl(T: CXType, i: c_uint) CXCursor;
pub extern fn clang_Type_getNumObjCTypeArgs(T: CXType) c_uint;
pub extern fn clang_Type_getObjCTypeArg(T: CXType, i: c_uint) CXType;
pub extern fn clang_isFunctionTypeVariadic(T: CXType) c_uint;
pub extern fn clang_getCursorResultType(C: CXCursor) CXType;
pub extern fn clang_getCursorExceptionSpecificationType(C: CXCursor) c_int;
pub extern fn clang_isPODType(T: CXType) c_uint;
pub extern fn clang_getElementType(T: CXType) CXType;
pub extern fn clang_getNumElements(T: CXType) c_longlong;
pub extern fn clang_getArrayElementType(T: CXType) CXType;
pub extern fn clang_getArraySize(T: CXType) c_longlong;
pub extern fn clang_Type_getNamedType(T: CXType) CXType;
pub extern fn clang_Type_isTransparentTagTypedef(T: CXType) c_uint;
pub const CXTypeNullability_NonNull: c_int = 0;
pub const CXTypeNullability_Nullable: c_int = 1;
pub const CXTypeNullability_Unspecified: c_int = 2;
pub const CXTypeNullability_Invalid: c_int = 3;
pub const CXTypeNullability_NullableResult: c_int = 4;
pub const CXTypeNullabilityKind = c_uint;
pub extern fn clang_Type_getNullability(T: CXType) CXTypeNullabilityKind;
pub const CXTypeLayoutError_Invalid: c_int = -1;
pub const CXTypeLayoutError_Incomplete: c_int = -2;
pub const CXTypeLayoutError_Dependent: c_int = -3;
pub const CXTypeLayoutError_NotConstantSize: c_int = -4;
pub const CXTypeLayoutError_InvalidFieldName: c_int = -5;
pub const CXTypeLayoutError_Undeduced: c_int = -6;
pub const CXTypeLayoutError = c_int;
pub extern fn clang_Type_getAlignOf(T: CXType) c_longlong;
pub extern fn clang_Type_getClassType(T: CXType) CXType;
pub extern fn clang_Type_getSizeOf(T: CXType) c_longlong;
pub extern fn clang_Type_getOffsetOf(T: CXType, S: [*:0]const u8) c_longlong;
pub extern fn clang_Type_getModifiedType(T: CXType) CXType;
pub extern fn clang_Type_getValueType(CT: CXType) CXType;
pub extern fn clang_Cursor_getOffsetOfField(C: CXCursor) c_longlong;
pub extern fn clang_Cursor_isAnonymous(C: CXCursor) c_uint;
pub extern fn clang_Cursor_isAnonymousRecordDecl(C: CXCursor) c_uint;
pub extern fn clang_Cursor_isInlineNamespace(C: CXCursor) c_uint;
pub const CXRefQualifier_None: c_int = 0;
pub const CXRefQualifier_LValue: c_int = 1;
pub const CXRefQualifier_RValue: c_int = 2;
pub const CXRefQualifierKind = c_uint;
pub extern fn clang_Type_getNumTemplateArguments(T: CXType) c_int;
pub extern fn clang_Type_getTemplateArgumentAsType(T: CXType, i: c_uint) CXType;
pub extern fn clang_Type_getCXXRefQualifier(T: CXType) CXRefQualifierKind;
pub extern fn clang_Cursor_isBitField(C: CXCursor) c_uint;
pub extern fn clang_isVirtualBase(CXCursor) c_uint;
pub const CX_CXXInvalidAccessSpecifier: c_int = 0;
pub const CX_CXXPublic: c_int = 1;
pub const CX_CXXProtected: c_int = 2;
pub const CX_CXXPrivate: c_int = 3;
pub const CX_CXXAccessSpecifier = c_uint;
pub extern fn clang_getCXXAccessSpecifier(CXCursor) CX_CXXAccessSpecifier;
pub const CX_SC_Invalid: c_int = 0;
pub const CX_SC_None: c_int = 1;
pub const CX_SC_Extern: c_int = 2;
pub const CX_SC_Static: c_int = 3;
pub const CX_SC_PrivateExtern: c_int = 4;
pub const CX_SC_OpenCLWorkGroupLocal: c_int = 5;
pub const CX_SC_Auto: c_int = 6;
pub const CX_SC_Register: c_int = 7;
pub const CX_StorageClass = c_uint;
pub extern fn clang_Cursor_getStorageClass(CXCursor) CX_StorageClass;
pub extern fn clang_getNumOverloadedDecls(cursor: CXCursor) c_uint;
pub extern fn clang_getOverloadedDecl(cursor: CXCursor, index: c_uint) CXCursor;
pub extern fn clang_getIBOutletCollectionType(CXCursor) CXType;
pub const CXChildVisit_Break: c_int = 0;
pub const CXChildVisit_Continue: c_int = 1;
pub const CXChildVisit_Recurse: c_int = 2;
pub const CXChildVisitResult = c_uint;
pub const CXCursorVisitor = ?*const fn (CXCursor, CXCursor, CXClientData) callconv(.C) CXChildVisitResult;
pub extern fn clang_visitChildren(parent: CXCursor, visitor: CXCursorVisitor, client_data: CXClientData) c_uint;
pub extern fn clang_getCursorUSR(CXCursor) CXString.CXString;
pub extern fn clang_constructUSR_ObjCClass(class_name: [*:0]const u8) CXString.CXString;
pub extern fn clang_constructUSR_ObjCCategory(class_name: [*:0]const u8, category_name: [*:0]const u8) CXString.CXString;
pub extern fn clang_constructUSR_ObjCProtocol(protocol_name: [*:0]const u8) CXString.CXString;
pub extern fn clang_constructUSR_ObjCIvar(name: [*:0]const u8, classUSR: CXString.CXString) CXString.CXString;
pub extern fn clang_constructUSR_ObjCMethod(name: [*:0]const u8, isInstanceMethod: c_uint, classUSR: CXString.CXString) CXString.CXString;
pub extern fn clang_constructUSR_ObjCProperty(property: [*:0]const u8, classUSR: CXString.CXString) CXString.CXString;
pub extern fn clang_getCursorSpelling(CXCursor) CXString.CXString;
pub extern fn clang_Cursor_getSpellingNameRange(CXCursor, pieceIndex: c_uint, options: c_uint) CXSourceLocation.CXSourceRange;
pub const CXPrintingPolicy = ?*anyopaque;
pub const CXPrintingPolicy_Indentation: c_int = 0;
pub const CXPrintingPolicy_SuppressSpecifiers: c_int = 1;
pub const CXPrintingPolicy_SuppressTagKeyword: c_int = 2;
pub const CXPrintingPolicy_IncludeTagDefinition: c_int = 3;
pub const CXPrintingPolicy_SuppressScope: c_int = 4;
pub const CXPrintingPolicy_SuppressUnwrittenScope: c_int = 5;
pub const CXPrintingPolicy_SuppressInitializers: c_int = 6;
pub const CXPrintingPolicy_ConstantArraySizeAsWritten: c_int = 7;
pub const CXPrintingPolicy_AnonymousTagLocations: c_int = 8;
pub const CXPrintingPolicy_SuppressStrongLifetime: c_int = 9;
pub const CXPrintingPolicy_SuppressLifetimeQualifiers: c_int = 10;
pub const CXPrintingPolicy_SuppressTemplateArgsInCXXConstructors: c_int = 11;
pub const CXPrintingPolicy_Bool: c_int = 12;
pub const CXPrintingPolicy_Restrict: c_int = 13;
pub const CXPrintingPolicy_Alignof: c_int = 14;
pub const CXPrintingPolicy_UnderscoreAlignof: c_int = 15;
pub const CXPrintingPolicy_UseVoidForZeroParams: c_int = 16;
pub const CXPrintingPolicy_TerseOutput: c_int = 17;
pub const CXPrintingPolicy_PolishForDeclaration: c_int = 18;
pub const CXPrintingPolicy_Half: c_int = 19;
pub const CXPrintingPolicy_MSWChar: c_int = 20;
pub const CXPrintingPolicy_IncludeNewlines: c_int = 21;
pub const CXPrintingPolicy_MSVCFormatting: c_int = 22;
pub const CXPrintingPolicy_ConstantsAsWritten: c_int = 23;
pub const CXPrintingPolicy_SuppressImplicitBase: c_int = 24;
pub const CXPrintingPolicy_FullyQualifiedName: c_int = 25;
pub const CXPrintingPolicy_LastProperty: c_int = 25;
pub const CXPrintingPolicyProperty = c_uint;
pub extern fn clang_PrintingPolicy_getProperty(Policy: CXPrintingPolicy, Property: CXPrintingPolicyProperty) c_uint;
pub extern fn clang_PrintingPolicy_setProperty(Policy: CXPrintingPolicy, Property: CXPrintingPolicyProperty, Value: c_uint) void;
pub extern fn clang_getCursorPrintingPolicy(CXCursor) CXPrintingPolicy;
pub extern fn clang_PrintingPolicy_dispose(Policy: CXPrintingPolicy) void;
pub extern fn clang_getCursorPrettyPrinted(Cursor: CXCursor, Policy: CXPrintingPolicy) CXString.CXString;
pub extern fn clang_getCursorDisplayName(CXCursor) CXString.CXString;
pub extern fn clang_getCursorReferenced(CXCursor) CXCursor;
pub extern fn clang_getCursorDefinition(CXCursor) CXCursor;
pub extern fn clang_isCursorDefinition(CXCursor) c_uint;
pub extern fn clang_getCanonicalCursor(CXCursor) CXCursor;
pub extern fn clang_Cursor_getObjCSelectorIndex(CXCursor) c_int;
pub extern fn clang_Cursor_isDynamicCall(C: CXCursor) c_int;
pub extern fn clang_Cursor_getReceiverType(C: CXCursor) CXType;
pub const CXObjCPropertyAttr_noattr: c_int = 0;
pub const CXObjCPropertyAttr_readonly: c_int = 1;
pub const CXObjCPropertyAttr_getter: c_int = 2;
pub const CXObjCPropertyAttr_assign: c_int = 4;
pub const CXObjCPropertyAttr_readwrite: c_int = 8;
pub const CXObjCPropertyAttr_retain: c_int = 16;
pub const CXObjCPropertyAttr_copy: c_int = 32;
pub const CXObjCPropertyAttr_nonatomic: c_int = 64;
pub const CXObjCPropertyAttr_setter: c_int = 128;
pub const CXObjCPropertyAttr_atomic: c_int = 256;
pub const CXObjCPropertyAttr_weak: c_int = 512;
pub const CXObjCPropertyAttr_strong: c_int = 1024;
pub const CXObjCPropertyAttr_unsafe_unretained: c_int = 2048;
pub const CXObjCPropertyAttr_class: c_int = 4096;
pub const CXObjCPropertyAttrKind = c_uint;
pub extern fn clang_Cursor_getObjCPropertyAttributes(C: CXCursor, reserved: c_uint) c_uint;
pub extern fn clang_Cursor_getObjCPropertyGetterName(C: CXCursor) CXString.CXString;
pub extern fn clang_Cursor_getObjCPropertySetterName(C: CXCursor) CXString.CXString;
pub const CXObjCDeclQualifier_None: c_int = 0;
pub const CXObjCDeclQualifier_In: c_int = 1;
pub const CXObjCDeclQualifier_Inout: c_int = 2;
pub const CXObjCDeclQualifier_Out: c_int = 4;
pub const CXObjCDeclQualifier_Bycopy: c_int = 8;
pub const CXObjCDeclQualifier_Byref: c_int = 16;
pub const CXObjCDeclQualifier_Oneway: c_int = 32;
pub const CXObjCDeclQualifierKind = c_uint;
pub extern fn clang_Cursor_getObjCDeclQualifiers(C: CXCursor) c_uint;
pub extern fn clang_Cursor_isObjCOptional(C: CXCursor) c_uint;
pub extern fn clang_Cursor_isVariadic(C: CXCursor) c_uint;
pub extern fn clang_Cursor_isExternalSymbol(C: CXCursor, language: [*c]CXString.CXString, definedIn: [*c]CXString.CXString, isGenerated: [*c]c_uint) c_uint;
pub extern fn clang_Cursor_getCommentRange(C: CXCursor) CXSourceLocation.CXSourceRange;
pub extern fn clang_Cursor_getRawCommentText(C: CXCursor) CXString.CXString;
pub extern fn clang_Cursor_getBriefCommentText(C: CXCursor) CXString.CXString;
pub extern fn clang_Cursor_getMangling(CXCursor) CXString.CXString;
pub extern fn clang_Cursor_getCXXManglings(CXCursor) [*c]CXString.CXStringSet;
pub extern fn clang_Cursor_getObjCManglings(CXCursor) [*c]CXString.CXStringSet;
pub const CXModule = ?*anyopaque;
pub extern fn clang_Cursor_getModule(C: CXCursor) CXModule;
pub extern fn clang_getModuleForFile(CXTranslationUnit, CXFile.CXFile) CXModule;
pub extern fn clang_Module_getASTFile(Module: CXModule) CXFile.CXFile;
pub extern fn clang_Module_getParent(Module: CXModule) CXModule;
pub extern fn clang_Module_getName(Module: CXModule) CXString.CXString;
pub extern fn clang_Module_getFullName(Module: CXModule) CXString.CXString;
pub extern fn clang_Module_isSystem(Module: CXModule) c_int;
pub extern fn clang_Module_getNumTopLevelHeaders(CXTranslationUnit, Module: CXModule) c_uint;
pub extern fn clang_Module_getTopLevelHeader(CXTranslationUnit, Module: CXModule, Index: c_uint) CXFile.CXFile;
pub extern fn clang_CXXConstructor_isConvertingConstructor(C: CXCursor) c_uint;
pub extern fn clang_CXXConstructor_isCopyConstructor(C: CXCursor) c_uint;
pub extern fn clang_CXXConstructor_isDefaultConstructor(C: CXCursor) c_uint;
pub extern fn clang_CXXConstructor_isMoveConstructor(C: CXCursor) c_uint;
pub extern fn clang_CXXField_isMutable(C: CXCursor) c_uint;
pub extern fn clang_CXXMethod_isDefaulted(C: CXCursor) c_uint;
pub extern fn clang_CXXMethod_isDeleted(C: CXCursor) c_uint;
pub extern fn clang_CXXMethod_isPureVirtual(C: CXCursor) c_uint;
pub extern fn clang_CXXMethod_isStatic(C: CXCursor) c_uint;
pub extern fn clang_CXXMethod_isVirtual(C: CXCursor) c_uint;
pub extern fn clang_CXXMethod_isCopyAssignmentOperator(C: CXCursor) c_uint;
pub extern fn clang_CXXMethod_isMoveAssignmentOperator(C: CXCursor) c_uint;
pub extern fn clang_CXXRecord_isAbstract(C: CXCursor) c_uint;
pub extern fn clang_EnumDecl_isScoped(C: CXCursor) c_uint;
pub extern fn clang_CXXMethod_isConst(C: CXCursor) c_uint;
pub extern fn clang_getTemplateCursorKind(C: CXCursor) CXCursorKind;
pub extern fn clang_getSpecializedCursorTemplate(C: CXCursor) CXCursor;
pub extern fn clang_getCursorReferenceNameRange(C: CXCursor, NameFlags: c_uint, PieceIndex: c_uint) CXSourceLocation.CXSourceRange;
pub const CXNameRange_WantQualifier: c_int = 1;
pub const CXNameRange_WantTemplateArgs: c_int = 2;
pub const CXNameRange_WantSinglePiece: c_int = 4;
pub const CXNameRefFlags = c_uint;
pub const CXTokenKind = enum(c_uint) {
    CXToken_Punctuation = 0,
    CXToken_Keyword = 1,
    CXToken_Identifier = 2,
    CXToken_Literal = 3,
    CXToken_Comment = 4,
};
pub const CXToken = extern struct {
    int_data: [4]c_uint = std.mem.zeroes([4]c_uint),
    ptr_data: ?*anyopaque = std.mem.zeroes(?*anyopaque),
};
pub extern fn clang_getToken(TU: CXTranslationUnit, Location: CXSourceLocation.CXSourceLocation) [*c]CXToken;
pub extern fn clang_getTokenKind(CXToken) CXTokenKind;
pub extern fn clang_getTokenSpelling(CXTranslationUnit, CXToken) CXString.CXString;
pub extern fn clang_getTokenLocation(CXTranslationUnit, CXToken) CXSourceLocation.CXSourceLocation;
pub extern fn clang_getTokenExtent(CXTranslationUnit, CXToken) CXSourceLocation.CXSourceRange;
pub extern fn clang_tokenize(TU: CXTranslationUnit, Range: CXSourceLocation.CXSourceRange, Tokens: [*c][*c]CXToken, NumTokens: [*c]c_uint) void;
pub extern fn clang_annotateTokens(TU: CXTranslationUnit, Tokens: [*c]CXToken, NumTokens: c_uint, Cursors: [*c]CXCursor) void;
pub extern fn clang_disposeTokens(TU: CXTranslationUnit, Tokens: [*c]CXToken, NumTokens: c_uint) void;
pub extern fn clang_getCursorKindSpelling(Kind: CXCursorKind) CXString.CXString;
pub extern fn clang_getDefinitionSpellingAndExtent(CXCursor, startBuf: [*c][*c]const u8, endBuf: [*c][*c]const u8, startLine: [*c]c_uint, startColumn: [*c]c_uint, endLine: [*c]c_uint, endColumn: [*c]c_uint) void;
pub extern fn clang_enableStackTraces() void;
pub extern fn clang_executeOnThread(@"fn": ?*const fn (?*anyopaque) callconv(.C) void, user_data: ?*anyopaque, stack_size: c_uint) void;
pub const CXCompletionString = ?*anyopaque;
pub const CXCompletionResult = extern struct {
    CursorKind: CXCursorKind = std.mem.zeroes(CXCursorKind),
    CompletionString: CXCompletionString = std.mem.zeroes(CXCompletionString),
};
pub const CXCompletionChunk_Optional: c_int = 0;
pub const CXCompletionChunk_TypedText: c_int = 1;
pub const CXCompletionChunk_Text: c_int = 2;
pub const CXCompletionChunk_Placeholder: c_int = 3;
pub const CXCompletionChunk_Informative: c_int = 4;
pub const CXCompletionChunk_CurrentParameter: c_int = 5;
pub const CXCompletionChunk_LeftParen: c_int = 6;
pub const CXCompletionChunk_RightParen: c_int = 7;
pub const CXCompletionChunk_LeftBracket: c_int = 8;
pub const CXCompletionChunk_RightBracket: c_int = 9;
pub const CXCompletionChunk_LeftBrace: c_int = 10;
pub const CXCompletionChunk_RightBrace: c_int = 11;
pub const CXCompletionChunk_LeftAngle: c_int = 12;
pub const CXCompletionChunk_RightAngle: c_int = 13;
pub const CXCompletionChunk_Comma: c_int = 14;
pub const CXCompletionChunk_ResultType: c_int = 15;
pub const CXCompletionChunk_Colon: c_int = 16;
pub const CXCompletionChunk_SemiColon: c_int = 17;
pub const CXCompletionChunk_Equal: c_int = 18;
pub const CXCompletionChunk_HorizontalSpace: c_int = 19;
pub const CXCompletionChunk_VerticalSpace: c_int = 20;
pub const CXCompletionChunkKind = c_uint;
pub extern fn clang_getCompletionChunkKind(completion_string: CXCompletionString, chunk_number: c_uint) CXCompletionChunkKind;
pub extern fn clang_getCompletionChunkText(completion_string: CXCompletionString, chunk_number: c_uint) CXString.CXString;
pub extern fn clang_getCompletionChunkCompletionString(completion_string: CXCompletionString, chunk_number: c_uint) CXCompletionString;
pub extern fn clang_getNumCompletionChunks(completion_string: CXCompletionString) c_uint;
pub extern fn clang_getCompletionPriority(completion_string: CXCompletionString) c_uint;
pub extern fn clang_getCompletionAvailability(completion_string: CXCompletionString) CXAvailabilityKind;
pub extern fn clang_getCompletionNumAnnotations(completion_string: CXCompletionString) c_uint;
pub extern fn clang_getCompletionAnnotation(completion_string: CXCompletionString, annotation_number: c_uint) CXString.CXString;
pub extern fn clang_getCompletionParent(completion_string: CXCompletionString, kind: [*c]CXCursorKind) CXString.CXString;
pub extern fn clang_getCompletionBriefComment(completion_string: CXCompletionString) CXString.CXString;
pub extern fn clang_getCursorCompletionString(cursor: CXCursor) CXCompletionString;
pub const CXCodeCompleteResults = extern struct {
    Results: [*c]CXCompletionResult = std.mem.zeroes([*c]CXCompletionResult),
    NumResults: c_uint = std.mem.zeroes(c_uint),
};
pub extern fn clang_getCompletionNumFixIts(results: [*c]CXCodeCompleteResults, completion_index: c_uint) c_uint;
pub extern fn clang_getCompletionFixIt(results: [*c]CXCodeCompleteResults, completion_index: c_uint, fixit_index: c_uint, replacement_range: [*c]CXSourceLocation.CXSourceRange) CXString.CXString;
pub const CXCodeComplete_IncludeMacros: c_int = 1;
pub const CXCodeComplete_IncludeCodePatterns: c_int = 2;
pub const CXCodeComplete_IncludeBriefComments: c_int = 4;
pub const CXCodeComplete_SkipPreamble: c_int = 8;
pub const CXCodeComplete_IncludeCompletionsWithFixIts: c_int = 16;
pub const CXCodeComplete_Flags = c_uint;
pub const CXCompletionContext_Unexposed: c_int = 0;
pub const CXCompletionContext_AnyType: c_int = 1;
pub const CXCompletionContext_AnyValue: c_int = 2;
pub const CXCompletionContext_ObjCObjectValue: c_int = 4;
pub const CXCompletionContext_ObjCSelectorValue: c_int = 8;
pub const CXCompletionContext_CXXClassTypeValue: c_int = 16;
pub const CXCompletionContext_DotMemberAccess: c_int = 32;
pub const CXCompletionContext_ArrowMemberAccess: c_int = 64;
pub const CXCompletionContext_ObjCPropertyAccess: c_int = 128;
pub const CXCompletionContext_EnumTag: c_int = 256;
pub const CXCompletionContext_UnionTag: c_int = 512;
pub const CXCompletionContext_StructTag: c_int = 1024;
pub const CXCompletionContext_ClassTag: c_int = 2048;
pub const CXCompletionContext_Namespace: c_int = 4096;
pub const CXCompletionContext_NestedNameSpecifier: c_int = 8192;
pub const CXCompletionContext_ObjCInterface: c_int = 16384;
pub const CXCompletionContext_ObjCProtocol: c_int = 32768;
pub const CXCompletionContext_ObjCCategory: c_int = 65536;
pub const CXCompletionContext_ObjCInstanceMessage: c_int = 131072;
pub const CXCompletionContext_ObjCClassMessage: c_int = 262144;
pub const CXCompletionContext_ObjCSelectorName: c_int = 524288;
pub const CXCompletionContext_MacroName: c_int = 1048576;
pub const CXCompletionContext_NaturalLanguage: c_int = 2097152;
pub const CXCompletionContext_IncludedFile: c_int = 4194304;
pub const CXCompletionContext_Unknown: c_int = 8388607;
pub const CXCompletionContext = c_uint;
pub extern fn clang_defaultCodeCompleteOptions() c_uint;
pub extern fn clang_codeCompleteAt(TU: CXTranslationUnit, complete_filename: [*:0]const u8, complete_line: c_uint, complete_column: c_uint, unsaved_files: [*c]CXUnsavedFile, num_unsaved_files: c_uint, options: c_uint) [*c]CXCodeCompleteResults;
pub extern fn clang_sortCodeCompletionResults(Results: [*c]CXCompletionResult, NumResults: c_uint) void;
pub extern fn clang_disposeCodeCompleteResults(Results: [*c]CXCodeCompleteResults) void;
pub extern fn clang_codeCompleteGetNumDiagnostics(Results: [*c]CXCodeCompleteResults) c_uint;
pub extern fn clang_codeCompleteGetDiagnostic(Results: [*c]CXCodeCompleteResults, Index: c_uint) CXDiagnostic.CXDiagnostic;
pub extern fn clang_codeCompleteGetContexts(Results: [*c]CXCodeCompleteResults) c_ulonglong;
pub extern fn clang_codeCompleteGetContainerKind(Results: [*c]CXCodeCompleteResults, IsIncomplete: [*c]c_uint) CXCursorKind;
pub extern fn clang_codeCompleteGetContainerUSR(Results: [*c]CXCodeCompleteResults) CXString.CXString;
pub extern fn clang_codeCompleteGetObjCSelector(Results: [*c]CXCodeCompleteResults) CXString.CXString;
pub extern fn clang_getClangVersion() CXString.CXString;
pub extern fn clang_toggleCrashRecovery(isEnabled: c_uint) void;
pub const CXInclusionVisitor = ?*const fn (CXFile.CXFile, [*c]CXSourceLocation.CXSourceLocation, c_uint, CXClientData) callconv(.C) void;
pub extern fn clang_getInclusions(tu: CXTranslationUnit, visitor: CXInclusionVisitor, client_data: CXClientData) void;
pub const CXEval_Int: c_int = 1;
pub const CXEval_Float: c_int = 2;
pub const CXEval_ObjCStrLiteral: c_int = 3;
pub const CXEval_StrLiteral: c_int = 4;
pub const CXEval_CFStr: c_int = 5;
pub const CXEval_Other: c_int = 6;
pub const CXEval_UnExposed: c_int = 0;
pub const CXEvalResultKind = c_uint;
pub const CXEvalResult = ?*anyopaque;
pub extern fn clang_Cursor_Evaluate(C: CXCursor) CXEvalResult;
pub extern fn clang_EvalResult_getKind(E: CXEvalResult) CXEvalResultKind;
pub extern fn clang_EvalResult_getAsInt(E: CXEvalResult) c_int;
pub extern fn clang_EvalResult_getAsLongLong(E: CXEvalResult) c_longlong;
pub extern fn clang_EvalResult_isUnsignedInt(E: CXEvalResult) c_uint;
pub extern fn clang_EvalResult_getAsUnsigned(E: CXEvalResult) c_ulonglong;
pub extern fn clang_EvalResult_getAsDouble(E: CXEvalResult) f64;
pub extern fn clang_EvalResult_getAsStr(E: CXEvalResult) [*:0]const u8;
pub extern fn clang_EvalResult_dispose(E: CXEvalResult) void;
pub const CXRemapping = ?*anyopaque;
pub extern fn clang_getRemappings(path: [*:0]const u8) CXRemapping;
pub extern fn clang_getRemappingsFromFileList(filePaths: [*c][*c]const u8, numFiles: c_uint) CXRemapping;
pub extern fn clang_remap_getNumFiles(CXRemapping) c_uint;
pub extern fn clang_remap_getFilenames(CXRemapping, index: c_uint, original: [*c]CXString.CXString, transformed: [*c]CXString.CXString) void;
pub extern fn clang_remap_dispose(CXRemapping) void;
pub const CXVisit_Break: c_int = 0;
pub const CXVisit_Continue: c_int = 1;
pub const CXVisitorResult = c_uint;
pub const CXCursorAndRangeVisitor = extern struct {
    context: ?*anyopaque = std.mem.zeroes(?*anyopaque),
    visit: ?*const fn (?*anyopaque, CXCursor, CXSourceLocation.CXSourceRange) callconv(.C) CXVisitorResult = std.mem.zeroes(?*const fn (?*anyopaque, CXCursor, CXSourceLocation.CXSourceRange) callconv(.C) CXVisitorResult),
};
pub const CXResult = enum(c_uint) {
    CXResult_Success = 0,
    CXResult_Invalid = 1,
    CXResult_VisitBreak = 2,
};
pub extern fn clang_findReferencesInFile(cursor: CXCursor, file: CXFile.CXFile, visitor: CXCursorAndRangeVisitor) CXResult;
pub extern fn clang_findIncludesInFile(TU: CXTranslationUnit, file: CXFile.CXFile, visitor: CXCursorAndRangeVisitor) CXResult;
pub const CXIdxClientFile = ?*anyopaque;
pub const CXIdxClientEntity = ?*anyopaque;
pub const CXIdxClientContainer = ?*anyopaque;
pub const CXIdxClientASTFile = ?*anyopaque;
pub const CXIdxLoc = extern struct {
    ptr_data: [2]?*anyopaque = std.mem.zeroes([2]?*anyopaque),
    int_data: c_uint = std.mem.zeroes(c_uint),
};
pub const CXIdxIncludedFileInfo = extern struct {
    hashLoc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
    filename: [*:0]const u8 = std.mem.zeroes([*:0]const u8),
    file: CXFile.CXFile = std.mem.zeroes(CXFile.CXFile),
    isImport: c_int = std.mem.zeroes(c_int),
    isAngled: c_int = std.mem.zeroes(c_int),
    isModuleImport: c_int = std.mem.zeroes(c_int),
};
pub const CXIdxImportedASTFileInfo = extern struct {
    file: CXFile.CXFile = std.mem.zeroes(CXFile.CXFile),
    module: CXModule = std.mem.zeroes(CXModule),
    loc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
    isImplicit: c_int = std.mem.zeroes(c_int),
};
pub const CXIdxEntity_Unexposed: c_int = 0;
pub const CXIdxEntity_Typedef: c_int = 1;
pub const CXIdxEntity_Function: c_int = 2;
pub const CXIdxEntity_Variable: c_int = 3;
pub const CXIdxEntity_Field: c_int = 4;
pub const CXIdxEntity_EnumConstant: c_int = 5;
pub const CXIdxEntity_ObjCClass: c_int = 6;
pub const CXIdxEntity_ObjCProtocol: c_int = 7;
pub const CXIdxEntity_ObjCCategory: c_int = 8;
pub const CXIdxEntity_ObjCInstanceMethod: c_int = 9;
pub const CXIdxEntity_ObjCClassMethod: c_int = 10;
pub const CXIdxEntity_ObjCProperty: c_int = 11;
pub const CXIdxEntity_ObjCIvar: c_int = 12;
pub const CXIdxEntity_Enum: c_int = 13;
pub const CXIdxEntity_Struct: c_int = 14;
pub const CXIdxEntity_Union: c_int = 15;
pub const CXIdxEntity_CXXClass: c_int = 16;
pub const CXIdxEntity_CXXNamespace: c_int = 17;
pub const CXIdxEntity_CXXNamespaceAlias: c_int = 18;
pub const CXIdxEntity_CXXStaticVariable: c_int = 19;
pub const CXIdxEntity_CXXStaticMethod: c_int = 20;
pub const CXIdxEntity_CXXInstanceMethod: c_int = 21;
pub const CXIdxEntity_CXXConstructor: c_int = 22;
pub const CXIdxEntity_CXXDestructor: c_int = 23;
pub const CXIdxEntity_CXXConversionFunction: c_int = 24;
pub const CXIdxEntity_CXXTypeAlias: c_int = 25;
pub const CXIdxEntity_CXXInterface: c_int = 26;
pub const CXIdxEntity_CXXConcept: c_int = 27;
pub const CXIdxEntityKind = c_uint;
pub const CXIdxEntityLang_None: c_int = 0;
pub const CXIdxEntityLang_C: c_int = 1;
pub const CXIdxEntityLang_ObjC: c_int = 2;
pub const CXIdxEntityLang_CXX: c_int = 3;
pub const CXIdxEntityLang_Swift: c_int = 4;
pub const CXIdxEntityLanguage = c_uint;
pub const CXIdxEntity_NonTemplate: c_int = 0;
pub const CXIdxEntity_Template: c_int = 1;
pub const CXIdxEntity_TemplatePartialSpecialization: c_int = 2;
pub const CXIdxEntity_TemplateSpecialization: c_int = 3;
pub const CXIdxEntityCXXTemplateKind = c_uint;
pub const CXIdxAttr_Unexposed: c_int = 0;
pub const CXIdxAttr_IBAction: c_int = 1;
pub const CXIdxAttr_IBOutlet: c_int = 2;
pub const CXIdxAttr_IBOutletCollection: c_int = 3;
pub const CXIdxAttrKind = c_uint;
pub const CXIdxAttrInfo = extern struct {
    kind: CXIdxAttrKind = std.mem.zeroes(CXIdxAttrKind),
    cursor: CXCursor = std.mem.zeroes(CXCursor),
    loc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
};
pub const CXIdxEntityInfo = extern struct {
    kind: CXIdxEntityKind = std.mem.zeroes(CXIdxEntityKind),
    templateKind: CXIdxEntityCXXTemplateKind = std.mem.zeroes(CXIdxEntityCXXTemplateKind),
    lang: CXIdxEntityLanguage = std.mem.zeroes(CXIdxEntityLanguage),
    name: [*:0]const u8 = std.mem.zeroes([*:0]const u8),
    USR: [*:0]const u8 = std.mem.zeroes([*:0]const u8),
    cursor: CXCursor = std.mem.zeroes(CXCursor),
    attributes: [*c]const [*c]const CXIdxAttrInfo = std.mem.zeroes([*c]const [*c]const CXIdxAttrInfo),
    numAttributes: c_uint = std.mem.zeroes(c_uint),
};
pub const CXIdxContainerInfo = extern struct {
    cursor: CXCursor = std.mem.zeroes(CXCursor),
};
pub const CXIdxIBOutletCollectionAttrInfo = extern struct {
    attrInfo: [*c]const CXIdxAttrInfo = std.mem.zeroes([*c]const CXIdxAttrInfo),
    objcClass: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
    classCursor: CXCursor = std.mem.zeroes(CXCursor),
    classLoc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
};
pub const CXIdxDeclFlag_Skipped: c_int = 1;
pub const CXIdxDeclInfoFlags = c_uint;
pub const CXIdxDeclInfo = extern struct {
    entityInfo: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
    cursor: CXCursor = std.mem.zeroes(CXCursor),
    loc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
    semanticContainer: [*c]const CXIdxContainerInfo = std.mem.zeroes([*c]const CXIdxContainerInfo),
    lexicalContainer: [*c]const CXIdxContainerInfo = std.mem.zeroes([*c]const CXIdxContainerInfo),
    isRedeclaration: c_int = std.mem.zeroes(c_int),
    isDefinition: c_int = std.mem.zeroes(c_int),
    isContainer: c_int = std.mem.zeroes(c_int),
    declAsContainer: [*c]const CXIdxContainerInfo = std.mem.zeroes([*c]const CXIdxContainerInfo),
    isImplicit: c_int = std.mem.zeroes(c_int),
    attributes: [*c]const [*c]const CXIdxAttrInfo = std.mem.zeroes([*c]const [*c]const CXIdxAttrInfo),
    numAttributes: c_uint = std.mem.zeroes(c_uint),
    flags: c_uint = std.mem.zeroes(c_uint),
};
pub const CXIdxObjCContainer_ForwardRef: c_int = 0;
pub const CXIdxObjCContainer_Interface: c_int = 1;
pub const CXIdxObjCContainer_Implementation: c_int = 2;
pub const CXIdxObjCContainerKind = c_uint;
pub const CXIdxObjCContainerDeclInfo = extern struct {
    declInfo: [*c]const CXIdxDeclInfo = std.mem.zeroes([*c]const CXIdxDeclInfo),
    kind: CXIdxObjCContainerKind = std.mem.zeroes(CXIdxObjCContainerKind),
};
pub const CXIdxBaseClassInfo = extern struct {
    base: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
    cursor: CXCursor = std.mem.zeroes(CXCursor),
    loc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
};
pub const CXIdxObjCProtocolRefInfo = extern struct {
    protocol: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
    cursor: CXCursor = std.mem.zeroes(CXCursor),
    loc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
};
pub const CXIdxObjCProtocolRefListInfo = extern struct {
    protocols: [*c]const [*c]const CXIdxObjCProtocolRefInfo = std.mem.zeroes([*c]const [*c]const CXIdxObjCProtocolRefInfo),
    numProtocols: c_uint = std.mem.zeroes(c_uint),
};
pub const CXIdxObjCInterfaceDeclInfo = extern struct {
    containerInfo: [*c]const CXIdxObjCContainerDeclInfo = std.mem.zeroes([*c]const CXIdxObjCContainerDeclInfo),
    superInfo: [*c]const CXIdxBaseClassInfo = std.mem.zeroes([*c]const CXIdxBaseClassInfo),
    protocols: [*c]const CXIdxObjCProtocolRefListInfo = std.mem.zeroes([*c]const CXIdxObjCProtocolRefListInfo),
};
pub const CXIdxObjCCategoryDeclInfo = extern struct {
    containerInfo: [*c]const CXIdxObjCContainerDeclInfo = std.mem.zeroes([*c]const CXIdxObjCContainerDeclInfo),
    objcClass: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
    classCursor: CXCursor = std.mem.zeroes(CXCursor),
    classLoc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
    protocols: [*c]const CXIdxObjCProtocolRefListInfo = std.mem.zeroes([*c]const CXIdxObjCProtocolRefListInfo),
};
pub const CXIdxObjCPropertyDeclInfo = extern struct {
    declInfo: [*c]const CXIdxDeclInfo = std.mem.zeroes([*c]const CXIdxDeclInfo),
    getter: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
    setter: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
};
pub const CXIdxCXXClassDeclInfo = extern struct {
    declInfo: [*c]const CXIdxDeclInfo = std.mem.zeroes([*c]const CXIdxDeclInfo),
    bases: [*c]const [*c]const CXIdxBaseClassInfo = std.mem.zeroes([*c]const [*c]const CXIdxBaseClassInfo),
    numBases: c_uint = std.mem.zeroes(c_uint),
};
pub const CXIdxEntityRef_Direct: c_int = 1;
pub const CXIdxEntityRef_Implicit: c_int = 2;
pub const CXIdxEntityRefKind = c_uint;
pub const CXSymbolRole_None: c_int = 0;
pub const CXSymbolRole_Declaration: c_int = 1;
pub const CXSymbolRole_Definition: c_int = 2;
pub const CXSymbolRole_Reference: c_int = 4;
pub const CXSymbolRole_Read: c_int = 8;
pub const CXSymbolRole_Write: c_int = 16;
pub const CXSymbolRole_Call: c_int = 32;
pub const CXSymbolRole_Dynamic: c_int = 64;
pub const CXSymbolRole_AddressOf: c_int = 128;
pub const CXSymbolRole_Implicit: c_int = 256;
pub const CXSymbolRole = c_uint;
pub const CXIdxEntityRefInfo = extern struct {
    kind: CXIdxEntityRefKind = std.mem.zeroes(CXIdxEntityRefKind),
    cursor: CXCursor = std.mem.zeroes(CXCursor),
    loc: CXIdxLoc = std.mem.zeroes(CXIdxLoc),
    referencedEntity: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
    parentEntity: [*c]const CXIdxEntityInfo = std.mem.zeroes([*c]const CXIdxEntityInfo),
    container: [*c]const CXIdxContainerInfo = std.mem.zeroes([*c]const CXIdxContainerInfo),
    role: CXSymbolRole = std.mem.zeroes(CXSymbolRole),
};
pub const IndexerCallbacks = extern struct {
    abortQuery: ?*const fn (CXClientData, ?*anyopaque) callconv(.C) c_int = std.mem.zeroes(?*const fn (CXClientData, ?*anyopaque) callconv(.C) c_int),
    diagnostic: ?*const fn (CXClientData, CXDiagnostic.CXDiagnosticSet, ?*anyopaque) callconv(.C) void = std.mem.zeroes(?*const fn (CXClientData, CXDiagnostic.CXDiagnosticSet, ?*anyopaque) callconv(.C) void),
    enteredMainFile: ?*const fn (CXClientData, CXFile.CXFile, ?*anyopaque) callconv(.C) CXIdxClientFile = std.mem.zeroes(?*const fn (CXClientData, CXFile.CXFile, ?*anyopaque) callconv(.C) CXIdxClientFile),
    ppIncludedFile: ?*const fn (CXClientData, [*c]const CXIdxIncludedFileInfo) callconv(.C) CXIdxClientFile = std.mem.zeroes(?*const fn (CXClientData, [*c]const CXIdxIncludedFileInfo) callconv(.C) CXIdxClientFile),
    importedASTFile: ?*const fn (CXClientData, [*c]const CXIdxImportedASTFileInfo) callconv(.C) CXIdxClientASTFile = std.mem.zeroes(?*const fn (CXClientData, [*c]const CXIdxImportedASTFileInfo) callconv(.C) CXIdxClientASTFile),
    startedTranslationUnit: ?*const fn (CXClientData, ?*anyopaque) callconv(.C) CXIdxClientContainer = std.mem.zeroes(?*const fn (CXClientData, ?*anyopaque) callconv(.C) CXIdxClientContainer),
    indexDeclaration: ?*const fn (CXClientData, [*c]const CXIdxDeclInfo) callconv(.C) void = std.mem.zeroes(?*const fn (CXClientData, [*c]const CXIdxDeclInfo) callconv(.C) void),
    indexEntityReference: ?*const fn (CXClientData, [*c]const CXIdxEntityRefInfo) callconv(.C) void = std.mem.zeroes(?*const fn (CXClientData, [*c]const CXIdxEntityRefInfo) callconv(.C) void),
};
pub extern fn clang_index_isEntityObjCContainerKind(CXIdxEntityKind) c_int;
pub extern fn clang_index_getObjCContainerDeclInfo([*c]const CXIdxDeclInfo) [*c]const CXIdxObjCContainerDeclInfo;
pub extern fn clang_index_getObjCInterfaceDeclInfo([*c]const CXIdxDeclInfo) [*c]const CXIdxObjCInterfaceDeclInfo;
pub extern fn clang_index_getObjCCategoryDeclInfo([*c]const CXIdxDeclInfo) [*c]const CXIdxObjCCategoryDeclInfo;
pub extern fn clang_index_getObjCProtocolRefListInfo([*c]const CXIdxDeclInfo) [*c]const CXIdxObjCProtocolRefListInfo;
pub extern fn clang_index_getObjCPropertyDeclInfo([*c]const CXIdxDeclInfo) [*c]const CXIdxObjCPropertyDeclInfo;
pub extern fn clang_index_getIBOutletCollectionAttrInfo([*c]const CXIdxAttrInfo) [*c]const CXIdxIBOutletCollectionAttrInfo;
pub extern fn clang_index_getCXXClassDeclInfo([*c]const CXIdxDeclInfo) [*c]const CXIdxCXXClassDeclInfo;
pub extern fn clang_index_getClientContainer([*c]const CXIdxContainerInfo) CXIdxClientContainer;
pub extern fn clang_index_setClientContainer([*c]const CXIdxContainerInfo, CXIdxClientContainer) void;
pub extern fn clang_index_getClientEntity([*c]const CXIdxEntityInfo) CXIdxClientEntity;
pub extern fn clang_index_setClientEntity([*c]const CXIdxEntityInfo, CXIdxClientEntity) void;
pub const CXIndexAction = ?*anyopaque;
pub extern fn clang_IndexAction_create(CIdx: CXIndex) CXIndexAction;
pub extern fn clang_IndexAction_dispose(CXIndexAction) void;
pub const CXIndexOpt_None: c_int = 0;
pub const CXIndexOpt_SuppressRedundantRefs: c_int = 1;
pub const CXIndexOpt_IndexFunctionLocalSymbols: c_int = 2;
pub const CXIndexOpt_IndexImplicitTemplateInstantiations: c_int = 4;
pub const CXIndexOpt_SuppressWarnings: c_int = 8;
pub const CXIndexOpt_SkipParsedBodiesInSession: c_int = 16;
pub const CXIndexOptFlags = c_uint;
pub extern fn clang_indexSourceFile(CXIndexAction, client_data: CXClientData, index_callbacks: [*c]IndexerCallbacks, index_callbacks_size: c_uint, index_options: c_uint, source_filename: [*:0]const u8, command_line_args: [*c]const [*c]const u8, num_command_line_args: c_int, unsaved_files: [*c]CXUnsavedFile, num_unsaved_files: c_uint, out_TU: [*c]CXTranslationUnit, TU_options: c_uint) c_int;
pub extern fn clang_indexSourceFileFullArgv(CXIndexAction, client_data: CXClientData, index_callbacks: [*c]IndexerCallbacks, index_callbacks_size: c_uint, index_options: c_uint, source_filename: [*:0]const u8, command_line_args: [*c]const [*c]const u8, num_command_line_args: c_int, unsaved_files: [*c]CXUnsavedFile, num_unsaved_files: c_uint, out_TU: [*c]CXTranslationUnit, TU_options: c_uint) c_int;
pub extern fn clang_indexTranslationUnit(CXIndexAction, client_data: CXClientData, index_callbacks: [*c]IndexerCallbacks, index_callbacks_size: c_uint, index_options: c_uint, CXTranslationUnit) c_int;
pub extern fn clang_indexLoc_getFileLocation(loc: CXIdxLoc, indexFile: [*c]CXIdxClientFile, file: [*c]CXFile.CXFile, line: [*c]c_uint, column: [*c]c_uint, offset: [*c]c_uint) void;
pub extern fn clang_indexLoc_getCXSourceLocation(loc: CXIdxLoc) CXSourceLocation.CXSourceLocation;
pub const CXFieldVisitor = ?*const fn (CXCursor, CXClientData) callconv(.C) CXVisitorResult;
pub extern fn clang_Type_visitFields(T: CXType, visitor: CXFieldVisitor, client_data: CXClientData) c_uint;

pub const CINDEX_VERSION_MAJOR = @as(c_int, 0);
pub const CINDEX_VERSION_MINOR = @as(c_int, 63);
pub inline fn CINDEX_VERSION_ENCODE(major: anytype, minor: anytype) @TypeOf((major * @as(c_int, 10000)) + (minor * @as(c_int, 1))) {
    return (major * @as(c_int, 10000)) + (minor * @as(c_int, 1));
}
pub const CINDEX_VERSION = CINDEX_VERSION_ENCODE(CINDEX_VERSION_MAJOR, CINDEX_VERSION_MINOR);
