# OS Assignment 01 Report
**Student Name:** Annas Sharif  
**Roll Number:** BSDSF24A008  

---

## Feature 1: Project Scaffolding & Version Control
Directory structure initialized with `src/`, `include/`, `lib/`, `bin/`, and `obj/`.

---

## Feature 2: Multi-file Project using Make Utility

### Question 1: Explain the linking rule in this part's Makefile: `$(TARGET): $(OBJECTS)`. How does it differ from a Makefile rule that links against a library?
**Answer:**
In this Makefile, `$(TARGET): $(OBJECTS)` specifies that the target executable (`bin/client`) directly depends on individual object files (`obj/mystrfunctions.o`, `obj/myfilefunctions.o`, `obj/main.o`). During linking, the compiler/linker (`gcc`) takes all these compiled object files and combines their machine code into a single final binary program.

This differs from a rule that links against a library (e.g., `$(TARGET): $(OBJECTS) -L./lib -lmyutils`) where the linker searches pre-compiled library archives (`.a`) or shared objects (`.so`) to resolve function references. Direct object file linking compiles all raw project object files together, whereas library linking relies on separate library archives built prior to target compilation.

### Question 2: What is a git tag and why is it useful in a project? What is the difference between a simple tag and an annotated tag?
**Answer:**
A **Git tag** is a reference marker attached to a specific commit in a repository's history, used to mark release checkpoints (e.g., `v1.0`, `v0.1.1-multifile`). Tags provide fixed checkpoints for release tracking without requiring a separate branch.

- **Simple (Lightweight) Tag:** A simple pointer directly referencing a commit hash. It does not store metadata such as author, timestamp, or description.
- **Annotated Tag:** Stored as a full object in the Git database. It contains tagger name, email, date, GPG signature (optional), and a descriptive message. Annotated tags are recommended for official releases.

### Question 3: What is the purpose of creating a "Release" on GitHub? What is the significance of attaching binaries (like your client executable) to it?
**Answer:**
A **GitHub Release** provides packaged software builds associated with specific Git tags. It allows project maintainers to publish formatted release notes and distribute compiled artifacts to end users.

Attaching compiled binaries (like `bin/client`) allows users to download and execute the application immediately on compatible operating systems without needing build tools (`gcc`, `make`), header files, or compiling the source code manually.