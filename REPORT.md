# OS Assignment 01 Report
**Name:** Annas Sharif  
**Roll No:** BSDSF24A008  
**Repository:** https://github.com/AnnasSharif/BSDSF24A008-OS-A01  

---

## Feature 1: Project Scaffolding & Version Control
Initial directory structure created: `src/`, `include/`, `lib/`, `bin/`, `obj/`, and `REPORT.md`.

---

## Feature 2: Multi-file Project using Make Utility

### Question 1: Explain the linking rule `$(TARGET): $(OBJECTS)`. How does it differ from linking against a library?
**Answer:**  
The rule `$(TARGET): $(OBJECTS)` directly links individual `.o` object files into an executable binary (`bin/client`).  
In contrast, linking against a library (using `-Llib -lmyutils`) links the executable against a pre-compiled library archive (`.a`) or shared object (`.so`) rather than raw object files.

### Question 3: What is a git tag? What is the difference between a simple tag and an annotated tag?
**Answer:**  
A Git tag marks a specific commit as a release point (e.g. `v1.0`).  
- **Simple tag:** Just a bookmark pointing to a commit hash.  
- **Annotated tag:** A full Git object containing author name, date, email, and a message.

### Question 3: What is the purpose of a GitHub Release and attaching binaries?
**Answer:**  
A GitHub Release packages project versions for users. Attaching compiled binaries (like `bin/client`) allows users to download and run the program without needing a compiler or building source code.

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

---

## Feature 4: Creating and using Dynamic Library

### Question 1: What is Position-Independent Code (-fPIC) and why is it required for shared libraries?
**Answer:**  
Position-Independent Code (`-fPIC`) generates machine code using relative memory addressing rather than absolute addresses. This allows the OS kernel to load the shared library (`.so`) into any arbitrary virtual memory address for multiple processes without modifying the binary code in memory.

### Question 2: Explain the difference in file size between your static and dynamic clients.
**Answer:**  
`client_static` is larger than `client_dynamic`.  
- **Static binary:** Contains the complete compiled machine code of all library functions embedded inside the binary file.  
- **Dynamic binary:** Contains only stub symbols and dynamic linking instructions. The actual function code remains inside `libmyutils.so` and is loaded into memory at runtime by the OS dynamic loader (`ld.so`).

### Question 3: What is LD_LIBRARY_PATH and why was it necessary to set it?
**Answer:**  
`LD_LIBRARY_PATH` is an environment variable that tells the Linux OS dynamic loader (`ld-linux.so`) where to search for shared libraries (`.so` files) at runtime, in addition to standard directories like `/lib` and `/usr/lib`.  
It was necessary to export `LD_LIBRARY_PATH=$PWD/lib` because custom libraries in non-standard directories are not automatically searched by the OS dynamic loader.

---

## Feature 5: Creating and Accessing Man Pages & Installation

### Summary of Implementation:
- Standard groff manual pages created under `man/man3/`: `mystrlen.3`, `mystrcpy.3`, `mystrncpy.3`, `mystrcat.3`, `wordCount.3`, `mygrep.3`.
- Added `install` target to root `Makefile` to install binary executable into `/usr/local/bin/client` and man pages into `/usr/local/share/man/man3/`.
- Tested installation via `sudo make install`, running `client` globally, and viewing manual pages via `man mystrlen`.