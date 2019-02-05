ETABLE  = crypto-ise.encodings.tex
SOURCES = specification.tex
TARGETS = $(patsubst %.tex, %.pdf, ${SOURCES})

${TARGETS} : $(ETABLE)
${TARGETS} : %.pdf : %.tex
	echo $(TEXMFLOCAL)
	@pdflatex ${*}.tex
	@biber    ${*}
	@pdflatex ${*}.tex
	@biber    ${*}
	@pdflatex ${*}.tex

all      : ${TARGETS} $(ETABLE)

.PHONY: $(OPCODES_SPEC)

$(ETABLE): $(OPCODES_SPEC)
	cat $< | $(PARSE_OPCODES) -xcrypto-tex > $@

clean    :
	@rm -f *.aux *.bbl *.bcf *.blg *.log *.out *.pdf *.version *.xml *.toc *.bak $(ETABLE)
spotless : clean
	@rm -f *.pdf 
