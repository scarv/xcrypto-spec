BUILD = ${REPO_HOME}/build/doc

include ${REPO_HOME}/extern/texmf/make/image.mk

${BUILD}/doc.ise : ${REPO_HOME}/extern/riscv-opcodes/opcodes-xcrypto
	@cat ${^} | python3 ${REPO_HOME}/extern/riscv-opcodes/parse-opcodes -xcrypto-tex > ${@}

${BUILD}/doc.pdf : ./doc.tex $(wildcard ./tex/*) ${IMAGE_TARGETS} ${BUILD}/doc.ise
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" pdflatex  -output-directory $(dir ${@}) $(basename ${<})
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" biber    --output_directory $(dir ${@}) $(basename ${<})
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" pdflatex  -output-directory $(dir ${@}) $(basename ${<})
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" biber    --output_directory $(dir ${@}) $(basename ${<})
	@TEXINPUTS="${TEXINPUTS}:.:${BUILD}" pdflatex  -output-directory $(dir ${@}) $(basename ${<})

dir   :
	@mkdir --parents ${BUILD}
	@mkdir --parents ${BUILD}/image

all   : dir ${BUILD}/doc.pdf

clean :
	@rm -rf ${BUILD}
