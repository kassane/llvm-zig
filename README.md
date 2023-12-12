# LLVM Kaleidoscope written on Zig

The purpose of this repository is to learn about the [`llvm`][llvm] compiler
infrastructure and practice some [`ziglang`][zig].

To reach the goals set, we follow the official llvm tutorial [`Kaleidoscope:
Implementing a Language with LLVM`][llvm-tutorial]. This tutorial is written in
`C++` and structured in multiple chapters, we will try to follow along and
implement every chapter in zig.

### Requirement

- [zig v0.12.0](https://ziglang.org/download) or higher.


## References

| Rust | Go | C |
| --- | --- | --- |
|[llvm-sys] / [inkwell] | [go-llvm] | LLVM-C |
| [llvm-kaleidoscope-rs] | [llvm-tuto-kaleidoscope-golang] | [llvm-c-kaleidoscope] |

## License

This project is licensed under the [MIT](LICENSE) license.

[llvm]: https://llvm.org
[llvm-sys]: https://gitlab.com/taricorp/llvm-sys.rs
[go-llvm]: https://github.com/tinygo-org/go-llvm
[inkwell]: https://github.com/TheDan64/inkwell
[llvm-kaleidoscope-rs]: https://github.com/johannst/llvm-kaleidoscope-rs
[llvm-c-kaleidoscope]: https://github.com/benbjohnson/llvm-c-kaleidoscope
[llvm-tuto-kaleidoscope-golang]: https://github.com/vhiribarren/llvm-tuto-kaleidoscope-golang
[llvm-tutorial]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/index.html
[llvm-ch1]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl01.html
[llvm-ch2]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl02.html
[llvm-ch3]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl03.html
[llvm-ch4]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl04.html
[llvm-ch5]: https://llvm.org/docs/tutorial/MyFirstLanguageFrontend/LangImpl05.html
[zig]: https://ziglang.org