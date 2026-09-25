
# REPORT.md — Operating Systems PA-01: libmyutils

**Name:** Annas Sharif
**Roll No:** BSDSF24A008
**Repository:** https://github.com/AnnnasSharif/BSDSF24A008-OS-A01

---
## Feature 3: Creating and using Static Library

### Question 1: Key Makefile differences between Part 2 (Multi-file) and Part 3 (Static Library)?
**Answer:**  
- **Part 2:** Compiled `.o` files directly into `bin/client`.  
- **Part 3:** Bundled `.o` files into a static archive `lib/libmyutils.a` using `ar rcs`, then linked `bin/client_static` against `libmyutils.a` using `-Llib -lmyutils`.

### Question 2: Purpose of `ar` command and why `ranlib` is used after it?
**Answer:**  
- **`ar`**: Creates and manages archive files (`.a`) by combining multiple `.o` object files into one static library.  
- **`ranlib`**: Generates an index/symbol table for the archive so the linker can look up symbols quickly. Modern `ar s` includes `ranlib` functionality.

### Question 3: Are symbols like `mystrlen` present in `client_static` when running `nm`? What does this tell you?
**Answer:**  
Yes, `mystrlen` is present in `client_static` (marked with code symbol type `T`). This proves that static linking copies the compiled machine code of library functions directly into the final executable.