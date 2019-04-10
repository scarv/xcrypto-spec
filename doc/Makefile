BUILD = ${REPO_HOME}/build/doc

${BUILD}/spec.isa : ${REPO_HOME}/extern/riscv-opcodes/opcodes-xcrypto
	@cat ${<} | python3 ${REPO_HOME}/extern/riscv-opcodes/parse-opcodes -xcrypto-tex > ${@}

${BUILD}/spec.pdf : ./spec.tex $(wildcard ./tex/* ./image/*) ${BUILD}/spec.isa
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" pdflatex  -output-directory $(dir ${@}) $(basename ${<})
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" biber    --output_directory $(dir ${@}) $(basename ${<})
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" pdflatex  -output-directory $(dir ${@}) $(basename ${<})
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" biber    --output_directory $(dir ${@}) $(basename ${<})
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" pdflatex  -output-directory $(dir ${@}) $(basename ${<})

.PHONY: image

dir   :
	@mkdir --parents ${BUILD}
	@mkdir --parents ${BUILD}/image

image :

all   : dir image ${BUILD}/spec.pdf

clean :
	@rm -rf ${BUILD}
