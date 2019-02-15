# [XCrypto](https://github.com/scarv/xcrypto): specification

<!--- -------------------------------------------------------------------- --->

[![Build Status](https://travis-ci.com/scarv/xcrypto-spec.svg)](https://travis-ci.com/scarv/xcrypto-spec)
[![Documentation](https://codedocs.xyz/scarv/xcrypto-spec.svg)](https://codedocs.xyz/scarv/xcrypto-spec)

<!--- -------------------------------------------------------------------- --->

A component part of the 
[SCARV](https://github.com/scarv)
project,
XCrypto is a general-purpose Instruction Set Extension (ISE) for
[RISC-V](https://riscv.org)
that supports software-based cryptographic workloads.
The main
[repository](https://github.com/scarv/xcrypto)
acts as a general container for resources associated with XCrypto;
this specific submodule houses the
XCrypto specification.

<!--- -------------------------------------------------------------------- --->

## Organisation

```
├── bin                     - scripts (e.g., environment configuration)
├── doc                     - documentation
│   ├── tex                   - LaTeX content
│   └── build                 - working directory for build
├── extern                  - external resources (e.g., submodules)
│   ├── riscv-opcodes         - submodule: scarv/riscv-opcodes
│   └── texmf                 - submodule: scarv/texmf
```

<!--- -------------------------------------------------------------------- --->

## Quickstart

- The
  [releases](https://github.com/scarv/xcrypto-spec/releases)
  page houses pre-built content.

- You can build the content yourself: having executed

  ```sh
  git clone https://github.com/scarv/xcrypto-spec.git
  cd ./xcrypto-spec
  git submodule update --init --recursive
  source ./bin/conf.sh
  make doc
  ```

  you should, for example, find 
  `${REPO_HOME}/doc/build/spec.pdf`
  has been built.

<!--- -------------------------------------------------------------------- --->

## Acknowledgements

This work has been supported in part by EPSRC via grant 
[EP/R012288/1](https://gow.epsrc.ukri.org/NGBOViewGrant.aspx?GrantRef=EP/R012288/1),
under the [RISE](http://www.ukrise.org) programme.

<!--- -------------------------------------------------------------------- --->
