# LLVM bindings for Zig

The purpose of this repository is to learn about the [`llvm`][llvm] compiler
infrastructure and practice some [`zig`][zig].

### Requirement

- [zig v0.14.0](https://ziglang.org/download) or higher.


### How to use

Make your project using
```console
zig init
```
Add this llvm-zig module
in `build.zig.zon`:
```console
zig fetch --save=llvm git+https://github.com/kassane/llvm-zig
```
in `build.zig`:

```zig
// [...]
    const llvm_dep = b.dependency("llvm", .{ // <== as declared in build.zig.zon
        .target = target, // the same as passing `-Dtarget=<...>` to the library's build.zig script
        .optimize = optimize, // ditto for `-Doptimize=<...>`
    });
    const llvm_mod = llvm_dep.module("llvm"); // <== get llvm bindings module
    // and/or
    const clang_mod = llvm_dep.module("clang"); // <== get clang bindings module
    /// your executable config
    exe.root_module.addImport("llvm", llvm_mod); // <== add llvm module
    exe.root_module.addImport("clang", clang_mod); // <== add clang module
// [...]
```

### License

This project is licensed under the [MIT](LICENSE) license.


[llvm]: https://llvm.org
[zig]: https://ziglang.org
