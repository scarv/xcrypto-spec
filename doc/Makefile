BUILD = ${REPO_HOME}/build/doc

${BUILD}/spec.isa : $(REPO_HOME)/extern/riscv-opcodes/opcodes-xcrypto
	@cat ${<} | python3 $(REPO_HOME)/extern/riscv-opcodes/parse-opcodes -xcrypto-tex > ${@}

${BUILD}/spec.pdf : ./spec.tex $(wildcard ./tex/*.tex) ${BUILD}/spec.isa
	@pdflatex  -output-directory ${BUILD} $(basename ${<})
	@biber    --output_directory ${BUILD} $(basename ${<})
	@pdflatex  -output-directory ${BUILD} $(basename ${<})
	@biber    --output_directory ${BUILD} $(basename ${<})
	@pdflatex  -output-directory ${BUILD} $(basename ${<})

${BUILD} :
	@mkdir --parents ${@}

all   : ${BUILD} ${BUILD}/spec.pdf

clean :
	@rm -rf ${REPO_HOME}/build/doc
