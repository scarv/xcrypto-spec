BUILD = ${REPO_HOME}/build/doc

include ${REPO_HOME}/extern/texmf/make/image.mk

ALL_OPCODES = ${REPO_HOME}/extern/riscv-opcodes/opcodes-xcrypto \
              ${REPO_HOME}/extern/riscv-opcodes/opcodes \
              ${REPO_HOME}/extern/riscv-opcodes/opcodes-b \
              ${REPO_HOME}/extern/riscv-opcodes/opcodes-rvc \
              ${REPO_HOME}/extern/riscv-opcodes/opcodes-rvv \

XC_OPCODES  = ${REPO_HOME}/extern/riscv-opcodes/opcodes-shared \
              ${REPO_HOME}/extern/riscv-opcodes/opcodes-xcrypto

${BUILD}/doc.ise : ${XC_OPCODES}
	cat ${ALL_OPCODES} | python3 ${REPO_HOME}/extern/riscv-opcodes/parse-opcodes -c > /dev/null
	cat ${^} | python3 ${REPO_HOME}/extern/riscv-opcodes/parse-opcodes -xcrypto-tex > ${@}

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
