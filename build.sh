#!/usr/bin/env bash
# build.sh - Build script for modernclassnotes package

set -e

echo "====================================================="
echo " Building modernclassnotes LaTeX Package & Manuals   "
echo "====================================================="

mkdir -p doc examples

echo "[1/11] Compiling English Documentation (doc/modernclassnotes-doc.tex)..."
pdflatex -interaction=nonstopmode -output-directory=doc doc/modernclassnotes-doc.tex > /dev/null
echo "       -> doc/modernclassnotes-doc.pdf compiled successfully."

echo "[2/11] Compiling German Documentation (doc/modernclassnotes-doc-de.tex)..."
xelatex -interaction=nonstopmode -output-directory=doc doc/modernclassnotes-doc-de.tex > /dev/null
echo "       -> doc/modernclassnotes-doc-de.pdf compiled successfully."

echo "[3/11] Compiling French Documentation (doc/modernclassnotes-doc-fr.tex)..."
xelatex -interaction=nonstopmode -output-directory=doc doc/modernclassnotes-doc-fr.tex > /dev/null
echo "       -> doc/modernclassnotes-doc-fr.pdf compiled successfully."

echo "[4/11] Compiling Chinese Documentation (doc/modernclassnotes-doc-zh.tex)..."
xelatex -interaction=nonstopmode -output-directory=doc doc/modernclassnotes-doc-zh.tex > /dev/null
echo "       -> doc/modernclassnotes-doc-zh.pdf compiled successfully."

echo "[5/11] Compiling Example 01 (examples/01-complete-course-notes.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/01-complete-course-notes.tex > /dev/null
echo "       -> examples/01-complete-course-notes.pdf compiled successfully."

echo "[6/11] Compiling Example 02 (examples/02-single-lecture-handout.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/02-single-lecture-handout.tex > /dev/null
echo "       -> examples/02-single-lecture-handout.pdf compiled successfully."

echo "[7/11] Compiling Example 03 (examples/03-homework-worksheet.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/03-homework-worksheet.tex > /dev/null
echo "       -> examples/03-homework-worksheet.pdf compiled successfully."

echo "[8/11] Compiling Example 04 (examples/04-chapter-notes.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/04-chapter-notes.tex > /dev/null
echo "       -> examples/04-chapter-notes.pdf compiled successfully."

echo "[9/11] Compiling Example 05 (German) (examples/05-german-vorlesungsskript.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/05-german-vorlesungsskript.tex > /dev/null
echo "       -> examples/05-german-vorlesungsskript.pdf compiled successfully."

echo "[10/11] Compiling Example 06 (French) (examples/06-french-fiche-de-cours.tex)..."
pdflatex -interaction=nonstopmode -output-directory=examples examples/06-french-fiche-de-cours.tex > /dev/null
echo "       -> examples/06-french-fiche-de-cours.pdf compiled successfully."

echo "[11/11] Compiling Example 07 (Chinese) (examples/07-chinese-worksheet-homework.tex)..."
xelatex -interaction=nonstopmode -output-directory=examples examples/07-chinese-worksheet-homework.tex > /dev/null
echo "       -> examples/07-chinese-worksheet-homework.pdf compiled successfully."

echo "====================================================="
echo " All documentations & examples compiled successfully! "
echo "====================================================="
