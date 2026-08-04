# Makefile for modernclassnotes LaTeX package
# Open Source TeX Package Build Automation

TEX = pdflatex
TEXFLAGS = -interaction=nonstopmode
DOC_DIR = doc
EXAMPLES_DIR = examples
PACKAGE_NAME = modernclassnotes
VERSION = 1.0.0

.PHONY: all doc examples clean ctan help

all: doc examples

doc: $(DOC_DIR)/modernclassnotes-doc.pdf

$(DOC_DIR)/modernclassnotes-doc.pdf: $(DOC_DIR)/modernclassnotes-doc.tex modernclassnotes.cls
	@echo "Compiling documentation..."
	$(TEX) $(TEXFLAGS) -output-directory=$(DOC_DIR) $(DOC_DIR)/modernclassnotes-doc.tex
	$(TEX) $(TEXFLAGS) -output-directory=$(DOC_DIR) $(DOC_DIR)/modernclassnotes-doc.tex

examples: $(EXAMPLES_DIR)/01-complete-course-notes.pdf \
          $(EXAMPLES_DIR)/02-single-lecture-handout.pdf \
          $(EXAMPLES_DIR)/03-homework-worksheet.pdf \
          $(EXAMPLES_DIR)/04-chapter-notes.pdf

$(EXAMPLES_DIR)/%.pdf: $(EXAMPLES_DIR)/%.tex modernclassnotes.cls
	@echo "Compiling example $<..."
	$(TEX) $(TEXFLAGS) -output-directory=$(EXAMPLES_DIR) $<
	$(TEX) $(TEXFLAGS) -output-directory=$(EXAMPLES_DIR) $<

ctan: all
	@echo "Creating CTAN release package..."
	rm -rf $(PACKAGE_NAME)-ctan $(PACKAGE_NAME)-$(VERSION).zip
	mkdir -p $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)
	cp modernclassnotes.cls modernclassnotes.sty README.md LICENSE Makefile $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/
	mkdir -p $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/doc
	cp $(DOC_DIR)/modernclassnotes-doc.tex $(DOC_DIR)/modernclassnotes-doc.pdf $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/doc/
	mkdir -p $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/examples
	cp $(EXAMPLES_DIR)/*.tex $(EXAMPLES_DIR)/*.pdf $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/examples/
	cd $(PACKAGE_NAME)-ctan && (zip -r ../$(PACKAGE_NAME)-$(VERSION).zip $(PACKAGE_NAME) 2>/dev/null || python3 -m zipfile -c ../$(PACKAGE_NAME)-$(VERSION).zip $(PACKAGE_NAME))
	rm -rf $(PACKAGE_NAME)-ctan
	@echo "CTAN release package created: $(PACKAGE_NAME)-$(VERSION).zip"

clean:
	@echo "Cleaning auxiliary build artifacts..."
	rm -f *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz
	rm -f $(DOC_DIR)/*.aux $(DOC_DIR)/*.log $(DOC_DIR)/*.toc $(DOC_DIR)/*.out $(DOC_DIR)/*.fls $(DOC_DIR)/*.fdb_latexmk
	rm -f $(EXAMPLES_DIR)/*.aux $(EXAMPLES_DIR)/*.log $(EXAMPLES_DIR)/*.toc $(EXAMPLES_DIR)/*.out $(EXAMPLES_DIR)/*.fls $(EXAMPLES_DIR)/*.fdb_latexmk

help:
	@echo "modernclassnotes Build Tool"
	@echo "  make all       Compile documentation and all example PDFs"
	@echo "  make doc       Compile user manual documentation"
	@echo "  make examples  Compile example note/handout/worksheet PDFs"
	@echo "  make ctan      Bundle CTAN release zip package"
	@echo "  make clean     Remove temporary TeX build files"
