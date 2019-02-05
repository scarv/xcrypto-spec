
export XC_DOCS_ROOT  = $(shell pwd)

export PARSE_OPCODES = python3 $(XC_DOCS_ROOT)/external/riscv-opcodes/parse-opcodes
export OPCODES_SPEC  = $(XC_DOCS_ROOT)/external/riscv-opcodes/opcodes-xcrypto

export TEXMFHOME     = {$(XC_DOCS_ROOT)/external/texmf}

.PHONY: docs
docs:
	$(MAKE) -C ./docs all

.PHONY: clean
clean: 
	$(MAKE) -C ./docs clean

