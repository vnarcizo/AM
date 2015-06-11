PROJECT=relatorio
TEX=pdflatex
BIB=bibtex
BUILD=${TEX} ${PROJECT}
BIBTEX=${BIB} ${PROJECT}

all:
	${BUILD}
	${BIBTEX}
	${BUILD}
	${BUILD}

clean:
	rm -f *.log *.bak *.aux *.bbl *.blg *.idx *.toc *.out *~ *.pdf