
MAIN=$1
FINAL=validation-draft

pdflatex ${MAIN}.tex
bibtex   ${MAIN}.aux
pdflatex ${MAIN}.tex
pdflatex ${MAIN}.tex

rm ${MAIN}.fff ${MAIN}.log ${MAIN}.aux ${MAIN}.ttt ${MAIN}.bbl ${MAIN}.lof ${MAIN}.blg ${MAIN}.spl ${MAIN}.out

mv ${MAIN}.pdf ${FINAL}.pdf

open -a Adobe\ Acrobat\ Pro.app ${FINAL}.pdf

clear
