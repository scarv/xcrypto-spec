# [XCrypto](https://github.com/scarv/xcrypto): specification

[![Build Status](https://travis-ci.com/scarv/xcrypto-spec.svg)](https://travis-ci.com/scarv/xcrypto-spec)
[![Documentation](https://codedocs.xyz/scarv/xcrypto-spec.svg)](https://codedocs.xyz/scarv/xcrypto-spec)

<!--- -------------------------------------------------------------------- --->

*This project describes a complete Instruction Set Extension (ISE) for the
RISC-V architecture for accelerating cryptographic workloads.*

This repository contains the ISE specification document.
Pre-built versions of the specification can be found on the
[releases](https://github.com/scarv/xcrypto-spec/releases)
page.

Alternatively, you can build them from source yourself with the following
commands:

```sh
$> git clone git@github.com:scarv/xcrypto-spec.git
$> cd ./xcrypto-spec
$> git submodule update --init --recursive
$> source ./bin/conf.sh
$> make docs
```

An explanation of the broader XCrypto project and it's organisation
can be found in the [scarv/xcrypto](https://github.com/scarv/xcrypto)
repository.
