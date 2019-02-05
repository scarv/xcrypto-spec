
PARSE_OPCODES = ./external/riscv-opcodes/parse-opcodes
OPCODES_SPEC  = ./external/riscv-opcodes/opcodes-xcrypto

.PHONY: docs
docs:
	$(MAKE) -C ./docs all

.PHONY: clean
clean: 
	$(MAKE) -C ./docs clean

