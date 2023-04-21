# llvm-kaleidoscope-zig

The purpose of this repository is to learn about the [`llvm`][llvm] 16 compiler
infrastructure and practice some [`ziglang`][zig].

To reach the goals set, we follow the official llvm tutorial [`Kaleidoscope:
Implementing a Language with LLVM`][llvm-tutorial]. This tutorial is written in
`C++` and structured in multiple chapters, we will try to follow along and
implement every chapter in zig.

**References:**
- [llvm-kaleidoscope-rs]
- [llvm-sys]

## License

This project is licensed under the [MIT](LICENSE) license.

[llvm]: https://llvm.org
[llvm-sys]: https://gitlab.com/taricorp/llvm-sys.rs
[llvm-kaleidoscope-rs]: https://github.com/johannst/llvm-kaleidoscope-rs
[llvm-tutorial]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/index.html
[llvm-ch1]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl01.html
[llvm-ch2]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl02.html
[llvm-ch3]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl03.html
[llvm-ch4]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl04.html
[llvm-ch5]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl05.html
[zig]: https://ziglang.org