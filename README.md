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
that supports cryptographic workloads.
The main
[repository](https://github.com/scarv/xcrypto)
acts as a general container for resources associated with XCrypto;
this specific submodule houses the
XCrypto specification.

<!--- -------------------------------------------------------------------- --->

# Getting started

- The
  [releases](https://github.com/scarv/xcrypto-spec/releases)
  page houses pre-built content.

- Alternatively, you can build the content yourself with via the
  following commands:

  ```sh
  git clone git@github.com:scarv/xcrypto-spec.git
  cd ./xcrypto-spec
  git submodule update --init --recursive
  source ./bin/conf.sh
  make all
  ```

<!--- -------------------------------------------------------------------- --->
