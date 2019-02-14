./build/spec.isa : $(REPO_HOME)/ext/riscv-opcodes/opcodes-xcrypto
	@cat ${<} | python3 $(REPO_HOME)/ext/riscv-opcodes/parse-opcodes -xcrypto-tex > ${@}

./build/spec.pdf : ./spec.tex $(wildcard ./tex/*.tex) ./build/spec.isa
	@pdflatex  -output-directory ./build $(basename ${<})
	@biber    --output_directory ./build $(basename ${<})
	@pdflatex  -output-directory ./build $(basename ${<})
	@biber    --output_directory ./build $(basename ${<})
	@pdflatex  -output-directory ./build $(basename ${<})

all   : ./build/spec.pdf

clean :
	@rm -f ./build/*