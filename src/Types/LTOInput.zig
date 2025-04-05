const lto = @import("../lto.zig");

pub const create = lto.lto_input_create;
pub const dispose = lto.lto_input_dispose;
pub const get_num_dependent_libraries = lto.lto_input_get_num_dependent_libraries;
pub const get_dependent_library = lto.lto_input_get_dependent_library;
