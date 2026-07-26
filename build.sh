#!/usr/bin/env bash
# build.sh - Build script for modernclassnotes package

set -e

echo "====================================================="
echo " Building modernclassnotes LaTeX Package & Examples  "
echo "====================================================="

mkdir -p doc examples

echo "[1/4] Compiling Documentation (doc/modernclassnotes-doc.tex)..."
pdflatex -interaction=nonstopmode -output-directory=doc doc/modernclassnotes-doc.tex > /dev/null
pdflatex -interaction=nonstopmode -output-directory=doc doc/modernclassnotes-doc.tex > /dev/null
echo "      -> doc/modernclassnotes-doc.pdf compiled successfully."

echo "[2/4] Compiling Example 01 (examples/01-complete-course-notes.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/01-complete-course-notes.tex > /dev/null
pdflatex -interaction=nonstopmode -output-directory=examples examples/01-complete-course-notes.tex > /dev/null
echo "      -> examples/01-complete-course-notes.pdf compiled successfully."

echo "[3/4] Compiling Example 02 (examples/02-single-lecture-handout.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/02-single-lecture-handout.tex > /dev/null
echo "      -> examples/02-single-lecture-handout.pdf compiled successfully."

echo "[4/4] Compiling Example 03 (examples/03-homework-worksheet.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/03-homework-worksheet.tex > /dev/null
echo "      -> examples/03-homework-worksheet.pdf compiled successfully."

echo "====================================================="
echo " All documentations & examples compiled successfully! "
echo "====================================================="
