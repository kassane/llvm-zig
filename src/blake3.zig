const LLVMtype = @import("types.zig");

pub const llvm_blake3_chunk_state = extern struct {
    cv: [8]u32,
    chunk_counter: u64,
    buf: [64]u8,
    buf_len: u8,
    blocks_compressed: u8,
    flags: u8,
};
pub const llvm_blake3_hasher = extern struct {
    key: [8]u32,
    chunk: llvm_blake3_chunk_state,
    cv_stack_len: u8,
    cv_stack: [1760]u8,
};
pub extern fn llvm_blake3_version() [*c]const u8;
pub extern fn llvm_blake3_hasher_init(self: [*c]llvm_blake3_hasher) void;
pub extern fn llvm_blake3_hasher_init_keyed(self: [*c]llvm_blake3_hasher, key: [*c]const u8) void;
pub extern fn llvm_blake3_hasher_init_derive_key(self: [*c]llvm_blake3_hasher, context: [*c]const u8) void;
pub extern fn llvm_blake3_hasher_init_derive_key_raw(self: [*c]llvm_blake3_hasher, context: ?*const anyopaque, context_len: usize) void;
pub extern fn llvm_blake3_hasher_update(self: [*c]llvm_blake3_hasher, input: ?*const anyopaque, input_len: usize) void;
pub extern fn llvm_blake3_hasher_finalize(self: [*c]const llvm_blake3_hasher, out: [*c]u8, out_len: usize) void;
pub extern fn llvm_blake3_hasher_finalize_seek(self: [*c]const llvm_blake3_hasher, seek: u64, out: [*c]u8, out_len: usize) void;
pub extern fn llvm_blake3_hasher_reset(self: [*c]llvm_blake3_hasher) void;
