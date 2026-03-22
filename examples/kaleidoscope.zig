//! Kaleidoscope language interpreter (Chapters 1-5) using LLVM OrcJIT.
//!
//! Features:
//!   - f64 arithmetic (+, -, *, /, <, >)
//!   - User-defined functions (def) and extern declarations
//!   - If/then/else expressions
//!   - For/in loop expressions
//!   - JIT compilation and execution via LLJIT
//!
//! Usage:
//!   > 4 + 5;               -- evaluates to 9
//!   > def square(x) x*x;   -- defines a function
//!   > square(3);            -- evaluates to 9
//!   > extern sin(x);        -- declares libc sin
//!   > sin(3.14159265/2);    -- evaluates to ~1.0

const std = @import("std");
const llvm = @import("llvm");
const core = llvm.core;
const T = llvm.types;
const target_mod = llvm.target;
const transform = llvm.transform;
const jit_mod = llvm.jit;
const orc_mod = llvm.orc;
const err_mod = llvm.errors;

// ============================================================
// Lexer
// ============================================================

const Token = union(enum) {
    eof,
    def,
    extern_kw,
    if_kw,
    then_kw,
    else_kw,
    for_kw,
    in_kw,
    identifier: []const u8,
    number: f64,
    other: u8,
};

const Lexer = struct {
    source: []const u8,
    pos: usize,
    allocator: std.mem.Allocator,

    fn init(source: []const u8, allocator: std.mem.Allocator) Lexer {
        return .{ .source = source, .pos = 0, .allocator = allocator };
    }

    fn peek(self: *const Lexer) ?u8 {
        if (self.pos >= self.source.len) return null;
        return self.source[self.pos];
    }

    fn advance(self: *Lexer) void {
        self.pos += 1;
    }

    fn next(self: *Lexer) !Token {
        // Skip whitespace and comments
        while (self.peek()) |c| {
            if (c == ' ' or c == '\t' or c == '\r' or c == '\n') {
                self.advance();
            } else if (c == '#') {
                while (self.peek()) |cc| {
                    self.advance();
                    if (cc == '\n') break;
                }
            } else break;
        }

        const c = self.peek() orelse return .eof;

        // Identifier or keyword
        if (std.ascii.isAlphabetic(c) or c == '_') {
            var buf: std.ArrayList(u8) = .empty;
            while (self.peek()) |cc| {
                if (std.ascii.isAlphanumeric(cc) or cc == '_') {
                    try buf.append(self.allocator, cc);
                    self.advance();
                } else break;
            }
            const ident = try buf.toOwnedSlice(self.allocator);
            if (std.mem.eql(u8, ident, "def")) { self.allocator.free(ident); return .def; }
            if (std.mem.eql(u8, ident, "extern")) { self.allocator.free(ident); return .extern_kw; }
            if (std.mem.eql(u8, ident, "if")) { self.allocator.free(ident); return .if_kw; }
            if (std.mem.eql(u8, ident, "then")) { self.allocator.free(ident); return .then_kw; }
            if (std.mem.eql(u8, ident, "else")) { self.allocator.free(ident); return .else_kw; }
            if (std.mem.eql(u8, ident, "for")) { self.allocator.free(ident); return .for_kw; }
            if (std.mem.eql(u8, ident, "in")) { self.allocator.free(ident); return .in_kw; }
            return .{ .identifier = ident };
        }

        // Number
        if (std.ascii.isDigit(c) or c == '.') {
            var buf: std.ArrayList(u8) = .empty;
            defer buf.deinit(self.allocator);
            while (self.peek()) |cc| {
                if (std.ascii.isDigit(cc) or cc == '.') {
                    try buf.append(self.allocator, cc);
                    self.advance();
                } else break;
            }
            const val = try std.fmt.parseFloat(f64, buf.items);
            return .{ .number = val };
        }

        self.advance();
        return .{ .other = c };
    }
};

// ============================================================
// AST
// ============================================================

const Expr = union(enum) {
    number: f64,
    variable: []const u8,
    binary: struct { op: u8, lhs: *Expr, rhs: *Expr },
    call: struct { callee: []const u8, args: []const *Expr },
    if_expr: struct { cond: *Expr, then_expr: *Expr, else_expr: *Expr },
    for_expr: struct {
        var_name: []const u8,
        start: *Expr,
        end: *Expr,
        step: ?*Expr,
        body: *Expr,
    },
};

const Prototype = struct {
    name: []const u8,
    params: []const []const u8,
};

const FunctionDef = struct {
    proto: Prototype,
    body: *Expr,
};

// ============================================================
// Parser
// ============================================================

const ParseError = error{
    UnexpectedEof,
    UnknownToken,
    ExpectedNumber,
    ExpectedIdentifier,
    ExpectedFunctionName,
    ExpectedOpenParen,
    ExpectedCloseParen,
    ExpectedComma,
    ExpectedCommaOrParen,
    ExpectedIdentifierOrParen,
    ExpectedEquals,
    ExpectedThen,
    ExpectedElse,
    ExpectedIn,
    OutOfMemory,
    InvalidCharacter, // from std.fmt.parseFloat in lexer
};

// The combined error set for all recursive parse functions.
const AnyParseError = ParseError;

const Parser = struct {
    lexer: *Lexer,
    cur_tok: Token,
    allocator: std.mem.Allocator,

    fn init(lexer: *Lexer, allocator: std.mem.Allocator) !Parser {
        var p = Parser{ .lexer = lexer, .cur_tok = .eof, .allocator = allocator };
        try p.advance();
        return p;
    }

    fn advance(self: *Parser) !void {
        self.cur_tok = try self.lexer.next();
    }

    fn parseNumberExpr(self: *Parser) !*Expr {
        const val = switch (self.cur_tok) {
            .number => |n| n,
            else => return ParseError.ExpectedNumber,
        };
        try self.advance();
        const e = try self.allocator.create(Expr);
        e.* = .{ .number = val };
        return e;
    }

    fn parseParenExpr(self: *Parser) AnyParseError!*Expr {
        try self.advance(); // eat '('
        const e = try self.parseExpression();
        switch (self.cur_tok) {
            .other => |c| { if (c != ')') return ParseError.ExpectedCloseParen; },
            else => return ParseError.ExpectedCloseParen,
        }
        try self.advance(); // eat ')'
        return e;
    }

    fn parseIdentifierExpr(self: *Parser) AnyParseError!*Expr {
        const name = switch (self.cur_tok) {
            .identifier => |n| n,
            else => return ParseError.ExpectedIdentifier,
        };
        try self.advance();
        const is_call = switch (self.cur_tok) {
            .other => |c| c == '(',
            else => false,
        };
        if (!is_call) {
            const e = try self.allocator.create(Expr);
            e.* = .{ .variable = name };
            return e;
        }
        try self.advance(); // eat '('
        var args: std.ArrayList(*Expr) = .empty;
        while (true) {
            switch (self.cur_tok) {
                .other => |c| if (c == ')') break,
                .eof => return ParseError.UnexpectedEof,
                else => {},
            }
            try args.append(self.allocator, try self.parseExpression());
            switch (self.cur_tok) {
                .other => |c| {
                    if (c == ')') break;
                    if (c != ',') return ParseError.ExpectedCommaOrParen;
                    try self.advance();
                },
                else => return ParseError.ExpectedCommaOrParen,
            }
        }
        try self.advance(); // eat ')'
        const e = try self.allocator.create(Expr);
        e.* = .{ .call = .{ .callee = name, .args = try args.toOwnedSlice(self.allocator) } };
        return e;
    }

    fn parseIfExpr(self: *Parser) AnyParseError!*Expr {
        try self.advance(); // eat 'if'
        const cond = try self.parseExpression();
        switch (self.cur_tok) {
            .then_kw => try self.advance(),
            else => return ParseError.ExpectedThen,
        }
        const then_e = try self.parseExpression();
        switch (self.cur_tok) {
            .else_kw => try self.advance(),
            else => return ParseError.ExpectedElse,
        }
        const else_e = try self.parseExpression();
        const e = try self.allocator.create(Expr);
        e.* = .{ .if_expr = .{ .cond = cond, .then_expr = then_e, .else_expr = else_e } };
        return e;
    }

    fn parseForExpr(self: *Parser) AnyParseError!*Expr {
        try self.advance(); // eat 'for'
        const var_name = switch (self.cur_tok) {
            .identifier => |n| n,
            else => return ParseError.ExpectedIdentifier,
        };
        try self.advance();
        switch (self.cur_tok) {
            .other => |c| { if (c != '=') return ParseError.ExpectedEquals; try self.advance(); },
            else => return ParseError.ExpectedEquals,
        }
        const start = try self.parseExpression();
        switch (self.cur_tok) {
            .other => |c| { if (c != ',') return ParseError.ExpectedComma; try self.advance(); },
            else => return ParseError.ExpectedComma,
        }
        const end = try self.parseExpression();
        var step: ?*Expr = null;
        switch (self.cur_tok) {
            .other => |c| {
                if (c == ',') {
                    try self.advance();
                    step = try self.parseExpression();
                }
            },
            else => {},
        }
        switch (self.cur_tok) {
            .in_kw => try self.advance(),
            else => return ParseError.ExpectedIn,
        }
        const body = try self.parseExpression();
        const e = try self.allocator.create(Expr);
        e.* = .{ .for_expr = .{
            .var_name = var_name,
            .start = start,
            .end = end,
            .step = step,
            .body = body,
        } };
        return e;
    }

    fn parsePrimary(self: *Parser) AnyParseError!*Expr {
        return switch (self.cur_tok) {
            .identifier => self.parseIdentifierExpr(),
            .number => self.parseNumberExpr(),
            .if_kw => self.parseIfExpr(),
            .for_kw => self.parseForExpr(),
            .other => |c| {
                if (c == '(') return self.parseParenExpr();
                return ParseError.UnknownToken;
            },
            .eof => ParseError.UnexpectedEof,
            else => ParseError.UnknownToken,
        };
    }

    fn binopPrec(op: u8) i32 {
        return switch (op) {
            '<', '>' => 10,
            '+', '-' => 20,
            '*', '/' => 40,
            else => -1,
        };
    }

    fn parseExpression(self: *Parser) AnyParseError!*Expr {
        const lhs = try self.parsePrimary();
        return self.parseBinopRhs(0, lhs);
    }

    fn parseBinopRhs(self: *Parser, min_prec: i32, lhs_in: *Expr) AnyParseError!*Expr {
        var lhs = lhs_in;
        while (true) {
            const op = switch (self.cur_tok) {
                .other => |c| c,
                else => return lhs,
            };
            const prec = binopPrec(op);
            if (prec < min_prec) return lhs;
            try self.advance();
            var rhs = try self.parsePrimary();
            const next_prec = switch (self.cur_tok) {
                .other => |c| binopPrec(c),
                else => -1,
            };
            if (prec < next_prec) {
                rhs = try self.parseBinopRhs(prec + 1, rhs);
            }
            const node = try self.allocator.create(Expr);
            node.* = .{ .binary = .{ .op = op, .lhs = lhs, .rhs = rhs } };
            lhs = node;
        }
    }

    fn parsePrototype(self: *Parser) !Prototype {
        const name = switch (self.cur_tok) {
            .identifier => |n| n,
            else => return ParseError.ExpectedFunctionName,
        };
        try self.advance();
        switch (self.cur_tok) {
            .other => |c| { if (c != '(') return ParseError.ExpectedOpenParen; try self.advance(); },
            else => return ParseError.ExpectedOpenParen,
        }
        var params: std.ArrayList([]const u8) = .empty;
        while (true) {
            switch (self.cur_tok) {
                .identifier => |n| { try params.append(self.allocator, n); try self.advance(); },
                .other => |c| { if (c == ')') break; return ParseError.ExpectedIdentifierOrParen; },
                else => break,
            }
        }
        try self.advance(); // eat ')'
        return .{ .name = name, .params = try params.toOwnedSlice(self.allocator) };
    }

    fn parseFunctionDef(self: *Parser) !FunctionDef {
        try self.advance(); // eat 'def'
        const proto = try self.parsePrototype();
        const body = try self.parseExpression();
        return .{ .proto = proto, .body = body };
    }

    fn parseExtern(self: *Parser) !Prototype {
        try self.advance(); // eat 'extern'
        return self.parsePrototype();
    }

    fn parseTopLevelExpr(self: *Parser) !FunctionDef {
        const body = try self.parseExpression();
        return .{ .proto = .{ .name = "__anon_expr", .params = &.{} }, .body = body };
    }
};

// ============================================================
// Codegen
// ============================================================

const CodegenError = error{
    UnknownVariable,
    UnknownFunction,
    ArgCountMismatch,
    JITError,
    InvalidBinaryOp,
    CodegenFailed,
    OutOfMemory,
};

const Codegen = struct {
    jit_inst: T.LLVMOrcLLJITRef,
    jit_dylib: orc_mod.LLVMOrcJITDylibRef,
    ctx: T.LLVMContextRef,
    module: T.LLVMModuleRef,
    builder: T.LLVMBuilderRef,
    named_values: std.StringHashMap(T.LLVMValueRef),
    known_protos: std.StringHashMap(Prototype),
    allocator: std.mem.Allocator,

    fn create(allocator: std.mem.Allocator) !Codegen {
        _ = target_mod.LLVMInitializeNativeTarget();
        _ = target_mod.LLVMInitializeNativeAsmPrinter();
        _ = target_mod.LLVMInitializeNativeAsmParser();

        var jit_ref: T.LLVMOrcLLJITRef = null;
        const e = jit_mod.LLVMOrcCreateLLJIT(&jit_ref, null);
        if (e != null) { err_mod.LLVMConsumeError(e); return CodegenError.JITError; }

        const jd = jit_mod.LLVMOrcLLJITGetMainJITDylib(jit_ref);
        const prefix = jit_mod.LLVMOrcLLJITGetGlobalPrefix(jit_ref);
        var dg: orc_mod.LLVMOrcDefinitionGeneratorRef = null;
        const de = orc_mod.LLVMOrcCreateDynamicLibrarySearchGeneratorForProcess(&dg, prefix, null, null);
        if (de != null) { err_mod.LLVMConsumeError(de); return CodegenError.JITError; }
        orc_mod.LLVMOrcJITDylibAddGenerator(jd, dg);

        const ctx = core.LLVMContextCreate();
        return Codegen{
            .jit_inst = jit_ref,
            .jit_dylib = jd,
            .ctx = ctx,
            .module = core.LLVMModuleCreateWithNameInContext("kaleidoscope", ctx),
            .builder = core.LLVMCreateBuilderInContext(ctx),
            .named_values = std.StringHashMap(T.LLVMValueRef).init(allocator),
            .known_protos = std.StringHashMap(Prototype).init(allocator),
            .allocator = allocator,
        };
    }

    fn destroy(self: *Codegen) void {
        if (self.builder != null) core.LLVMDisposeBuilder(self.builder);
        if (self.module != null) core.LLVMDisposeModule(self.module);
        if (self.ctx != null) core.LLVMContextDispose(self.ctx);
        self.named_values.deinit();
        self.known_protos.deinit();
        _ = jit_mod.LLVMOrcDisposeLLJIT(self.jit_inst);
    }

    fn freshModule(self: *Codegen) !void {
        if (self.builder != null) {
            core.LLVMDisposeBuilder(self.builder);
            self.builder = null;
        }
        self.ctx = core.LLVMContextCreate();
        self.module = core.LLVMModuleCreateWithNameInContext("kaleidoscope", self.ctx);
        self.builder = core.LLVMCreateBuilderInContext(self.ctx);
    }

    fn submitToJIT(self: *Codegen) !void {
        const opts = transform.LLVMCreatePassBuilderOptions();
        defer transform.LLVMDisposePassBuilderOptions(opts);
        const pe = transform.LLVMRunPasses(self.module, "default<O2>", null, opts);
        if (pe != null) err_mod.LLVMConsumeError(pe);

        const ts_ctx = orc_mod.LLVMOrcCreateNewThreadSafeContextFromLLVMContext(self.ctx);
        self.ctx = null;
        const ts_mod = orc_mod.LLVMOrcCreateNewThreadSafeModule(self.module, ts_ctx);
        self.module = null;
        orc_mod.LLVMOrcDisposeThreadSafeContext(ts_ctx);

        core.LLVMDisposeBuilder(self.builder);
        self.builder = null;

        const ae = jit_mod.LLVMOrcLLJITAddLLVMIRModule(self.jit_inst, self.jit_dylib, ts_mod);
        if (ae != null) {
            err_mod.LLVMConsumeError(ae);
            return CodegenError.JITError;
        }
    }

    fn f64Ty(self: *const Codegen) T.LLVMTypeRef {
        return core.LLVMDoubleTypeInContext(self.ctx);
    }

    fn getOrDeclareFunc(self: *Codegen, name: []const u8) ?T.LLVMValueRef {
        const namez = self.allocator.dupeZ(u8, name) catch return null;
        defer self.allocator.free(namez);
        if (core.LLVMGetNamedFunction(self.module, namez)) |f| return f;
        const proto = self.known_protos.get(name) orelse return null;
        return self.declareProto(proto) catch null;
    }

    fn declareProto(self: *Codegen, proto: Prototype) !T.LLVMValueRef {
        const n = proto.params.len;
        const ptypes = try self.allocator.alloc(T.LLVMTypeRef, n);
        defer self.allocator.free(ptypes);
        for (ptypes) |*pt| pt.* = self.f64Ty();
        const fty = core.LLVMFunctionType(self.f64Ty(), ptypes.ptr, @intCast(n), 0);
        const namez = try self.allocator.dupeZ(u8, proto.name);
        defer self.allocator.free(namez);
        const f = core.LLVMAddFunction(self.module, namez, fty);
        for (proto.params, 0..) |pname, i| {
            const param = core.LLVMGetParam(f, @intCast(i));
            const pnamez = try self.allocator.dupeZ(u8, pname);
            defer self.allocator.free(pnamez);
            core.LLVMSetValueName2(param, pnamez, pname.len);
        }
        return f;
    }

    fn codegenExpr(self: *Codegen, expr: *const Expr) CodegenError!T.LLVMValueRef {
        return switch (expr.*) {
            .number => |n| core.LLVMConstReal(self.f64Ty(), n),

            .variable => |name| self.named_values.get(name) orelse
                return CodegenError.UnknownVariable,

            .binary => |b| {
                const lv = try self.codegenExpr(b.lhs);
                const rv = try self.codegenExpr(b.rhs);
                return switch (b.op) {
                    '+' => core.LLVMBuildFAdd(self.builder, lv, rv, "addtmp"),
                    '-' => core.LLVMBuildFSub(self.builder, lv, rv, "subtmp"),
                    '*' => core.LLVMBuildFMul(self.builder, lv, rv, "multmp"),
                    '/' => core.LLVMBuildFDiv(self.builder, lv, rv, "divtmp"),
                    '<' => blk: {
                        const cmp = core.LLVMBuildFCmp(self.builder, .LLVMRealOLT, lv, rv, "cmptmp");
                        break :blk core.LLVMBuildUIToFP(self.builder, cmp, self.f64Ty(), "booltmp");
                    },
                    '>' => blk: {
                        const cmp = core.LLVMBuildFCmp(self.builder, .LLVMRealOGT, lv, rv, "cmptmp");
                        break :blk core.LLVMBuildUIToFP(self.builder, cmp, self.f64Ty(), "booltmp");
                    },
                    else => CodegenError.InvalidBinaryOp,
                };
            },

            .call => |c| blk: {
                const callee_f = self.getOrDeclareFunc(c.callee) orelse
                    return CodegenError.UnknownFunction;
                if (core.LLVMCountParams(callee_f) != c.args.len)
                    return CodegenError.ArgCountMismatch;
                const arg_vals = self.allocator.alloc(T.LLVMValueRef, c.args.len) catch
                    return CodegenError.OutOfMemory;
                defer self.allocator.free(arg_vals);
                for (c.args, 0..) |arg, i| arg_vals[i] = try self.codegenExpr(arg);
                const fty = core.LLVMGlobalGetValueType(callee_f);
                break :blk core.LLVMBuildCall2(self.builder, fty, callee_f, arg_vals.ptr, @intCast(c.args.len), "calltmp");
            },

            .if_expr => |ie| blk: {
                const cond_v = try self.codegenExpr(ie.cond);
                const zero = core.LLVMConstReal(self.f64Ty(), 0.0);
                const cond_b = core.LLVMBuildFCmp(self.builder, .LLVMRealONE, cond_v, zero, "ifcond");
                const func = core.LLVMGetBasicBlockParent(core.LLVMGetInsertBlock(self.builder));
                var then_bb = core.LLVMAppendBasicBlockInContext(self.ctx, func, "then");
                var else_bb = core.LLVMAppendBasicBlockInContext(self.ctx, func, "else");
                const merge_bb = core.LLVMAppendBasicBlockInContext(self.ctx, func, "merge");
                _ = core.LLVMBuildCondBr(self.builder, cond_b, then_bb, else_bb);

                core.LLVMPositionBuilderAtEnd(self.builder, then_bb);
                const then_v = try self.codegenExpr(ie.then_expr);
                _ = core.LLVMBuildBr(self.builder, merge_bb);
                then_bb = core.LLVMGetInsertBlock(self.builder);

                core.LLVMPositionBuilderAtEnd(self.builder, else_bb);
                const else_v = try self.codegenExpr(ie.else_expr);
                _ = core.LLVMBuildBr(self.builder, merge_bb);
                else_bb = core.LLVMGetInsertBlock(self.builder);

                core.LLVMPositionBuilderAtEnd(self.builder, merge_bb);
                const phi = core.LLVMBuildPhi(self.builder, self.f64Ty(), "iftmp");
                var in_vals = [_]T.LLVMValueRef{ then_v, else_v };
                var in_bbs = [_]T.LLVMBasicBlockRef{ then_bb, else_bb };
                core.LLVMAddIncoming(phi, &in_vals, &in_bbs, 2);
                break :blk phi;
            },

            .for_expr => |fe| blk: {
                const start_v = try self.codegenExpr(fe.start);
                const func = core.LLVMGetBasicBlockParent(core.LLVMGetInsertBlock(self.builder));
                const preheader = core.LLVMGetInsertBlock(self.builder);
                const loop_bb = core.LLVMAppendBasicBlockInContext(self.ctx, func, "loop");
                _ = core.LLVMBuildBr(self.builder, loop_bb);

                core.LLVMPositionBuilderAtEnd(self.builder, loop_bb);
                const phi_name = self.allocator.dupeZ(u8, fe.var_name) catch return CodegenError.OutOfMemory;
                defer self.allocator.free(phi_name);
                const var_phi = core.LLVMBuildPhi(self.builder, self.f64Ty(), phi_name);
                var init_vs = [_]T.LLVMValueRef{start_v};
                var init_bs = [_]T.LLVMBasicBlockRef{preheader};
                core.LLVMAddIncoming(var_phi, &init_vs, &init_bs, 1);

                const old_val = self.named_values.get(fe.var_name);
                self.named_values.put(fe.var_name, var_phi) catch return CodegenError.OutOfMemory;

                _ = try self.codegenExpr(fe.body);

                const step_v = if (fe.step) |s|
                    try self.codegenExpr(s)
                else
                    core.LLVMConstReal(self.f64Ty(), 1.0);
                const next_v = core.LLVMBuildFAdd(self.builder, var_phi, step_v, "nextvar");

                const end_v = try self.codegenExpr(fe.end);
                const end_cond = core.LLVMBuildFCmp(self.builder, .LLVMRealOLT, next_v, end_v, "loopcond");
                const loop_end = core.LLVMGetInsertBlock(self.builder);
                const after_bb = core.LLVMAppendBasicBlockInContext(self.ctx, func, "afterloop");
                _ = core.LLVMBuildCondBr(self.builder, end_cond, loop_bb, after_bb);
                core.LLVMPositionBuilderAtEnd(self.builder, after_bb);

                var back_vs = [_]T.LLVMValueRef{next_v};
                var back_bs = [_]T.LLVMBasicBlockRef{loop_end};
                core.LLVMAddIncoming(var_phi, &back_vs, &back_bs, 1);

                if (old_val) |ov| {
                    self.named_values.put(fe.var_name, ov) catch return CodegenError.OutOfMemory;
                } else {
                    _ = self.named_values.remove(fe.var_name);
                }
                break :blk core.LLVMConstReal(self.f64Ty(), 0.0);
            },
        };
    }

    fn codegenFunction(self: *Codegen, fdef: FunctionDef) !T.LLVMValueRef {
        self.known_protos.put(fdef.proto.name, fdef.proto) catch
            return CodegenError.OutOfMemory;

        const namez = self.allocator.dupeZ(u8, fdef.proto.name) catch
            return CodegenError.OutOfMemory;
        defer self.allocator.free(namez);

        var f = core.LLVMGetNamedFunction(self.module, namez);
        if (f == null) {
            f = self.declareProto(fdef.proto) catch return CodegenError.CodegenFailed;
        }

        const entry_bb = core.LLVMAppendBasicBlockInContext(self.ctx, f, "entry");
        core.LLVMPositionBuilderAtEnd(self.builder, entry_bb);
        self.named_values.clearRetainingCapacity();
        for (fdef.proto.params, 0..) |pname, i| {
            const param = core.LLVMGetParam(f, @intCast(i));
            self.named_values.put(pname, param) catch return CodegenError.OutOfMemory;
        }

        const ret_v = self.codegenExpr(fdef.body) catch {
            core.LLVMDeleteFunction(f);
            return CodegenError.CodegenFailed;
        };
        _ = core.LLVMBuildRet(self.builder, ret_v);
        return f;
    }

    fn evalTopLevel(self: *Codegen, fdef: FunctionDef) !f64 {
        _ = try self.codegenFunction(fdef);
        try self.submitToJIT();

        var addr: orc_mod.LLVMOrcExecutorAddress = 0;
        const le = jit_mod.LLVMOrcLLJITLookup(self.jit_inst, &addr, "__anon_expr");
        try self.freshModule();
        if (le != null) {
            err_mod.LLVMConsumeError(le);
            return CodegenError.JITError;
        }
        const fn_ptr: *const fn () callconv(.c) f64 = @ptrFromInt(addr);
        return fn_ptr();
    }

    fn handleDef(self: *Codegen, fdef: FunctionDef) !void {
        _ = try self.codegenFunction(fdef);
        try self.submitToJIT();
        try self.freshModule();
    }

    fn handleExtern(self: *Codegen, proto: Prototype) !void {
        self.known_protos.put(proto.name, proto) catch return CodegenError.OutOfMemory;
        _ = try self.declareProto(proto);
    }
};

// ============================================================
// REPL I/O — cross-platform: posix on Unix, libc on Windows.
// std.posix.write was removed in Zig 0.16-dev, so use libc shims.
// ============================================================

extern fn write(fd: c_int, buf: [*]const u8, count: usize) isize;
extern fn read(fd: c_int, buf: [*]u8, count: usize) isize;

fn writeAll(fd: c_int, bytes: []const u8) void {
    var remaining = bytes;
    while (remaining.len > 0) {
        const n = write(fd, remaining.ptr, remaining.len);
        if (n <= 0) break;
        remaining = remaining[@intCast(n)..];
    }
}

fn printFmt(comptime fmt: []const u8, args: anytype) void {
    var buf: [1024]u8 = undefined;
    const s = std.fmt.bufPrint(&buf, fmt, args) catch return;
    writeAll(1, s); // fd 1 = stdout on all platforms
}

fn readOneByte() ?u8 {
    var b: [1]u8 = undefined;
    const n = read(0, &b, 1); // fd 0 = stdin on all platforms
    if (n <= 0) return null;
    return b[0];
}

// ============================================================
// REPL
// ============================================================

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var cg = try Codegen.create(allocator);
    defer cg.destroy();

    printFmt("Kaleidoscope REPL (LLVM 21 / OrcJIT)\n", .{});
    printFmt("End each statement with ';'. Ctrl+D to quit.\n\n", .{});

    var input_buf: std.ArrayList(u8) = .empty;
    defer input_buf.deinit(allocator);

    while (true) {
        printFmt("ready> ", .{});

        input_buf.clearRetainingCapacity();
        while (true) {
            const byte = readOneByte() orelse {
                printFmt("\nBye!\n", .{});
                return;
            };
            if (byte == ';') break;
            try input_buf.append(allocator, byte);
        }

        const input = std.mem.trim(u8, input_buf.items, " \t\r\n");
        if (input.len == 0) continue;

        var arena = std.heap.ArenaAllocator.init(allocator);
        defer arena.deinit();
        const aa = arena.allocator();

        var lexer = Lexer.init(input, aa);
        var parser = Parser.init(&lexer, aa) catch |e| {
            printFmt("lex error: {s}\n", .{@errorName(e)});
            continue;
        };

        switch (parser.cur_tok) {
            .eof => continue,
            .def => {
                const fdef = parser.parseFunctionDef() catch |e| {
                    printFmt("parse error: {s}\n", .{@errorName(e)});
                    continue;
                };
                cg.handleDef(fdef) catch |e| {
                    printFmt("codegen error: {s}\n", .{@errorName(e)});
                    cg.freshModule() catch {};
                    continue;
                };
                printFmt("Defined: {s}\n", .{fdef.proto.name});
            },
            .extern_kw => {
                const proto = parser.parseExtern() catch |e| {
                    printFmt("parse error: {s}\n", .{@errorName(e)});
                    continue;
                };
                cg.handleExtern(proto) catch |e| {
                    printFmt("codegen error: {s}\n", .{@errorName(e)});
                    continue;
                };
                printFmt("Extern: {s}\n", .{proto.name});
            },
            else => {
                const fdef = parser.parseTopLevelExpr() catch |e| {
                    printFmt("parse error: {s}\n", .{@errorName(e)});
                    continue;
                };
                const result = cg.evalTopLevel(fdef) catch |e| {
                    printFmt("eval error: {s}\n", .{@errorName(e)});
                    continue;
                };
                printFmt("= {d}\n", .{result});
            },
        }
    }
}
