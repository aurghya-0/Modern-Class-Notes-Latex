# Makefile for modernclassnotes LaTeX package
# Open Source TeX Package Build Automation

TEX = pdflatex
TEXFLAGS = -interaction=nonstopmode
DOC_DIR = doc
EXAMPLES_DIR = examples
PACKAGE_NAME = modernclassnotes
VERSION = 1.1.0

# Detect Operating System (Windows vs Unix/Linux/macOS)
ifeq ($(OS),Windows_NT)
    TEXMFHOME ?= $(USERPROFILE)/texmf
    PYTHON ?= python
    RM = $(PYTHON) -c "import glob, os, sys; [os.remove(f) for arg in sys.argv[1:] for f in glob.glob(arg) if os.path.isfile(f)]"
    RMDIR = $(PYTHON) -c "import shutil, sys; [shutil.rmtree(arg, ignore_errors=True) for arg in sys.argv[1:]]"
    MKDIR = $(PYTHON) -c "import os, sys; [os.makedirs(arg, exist_ok=True) for arg in sys.argv[1:]]"
    COPY_TO_DIR = $(PYTHON) -c "import shutil, glob, os, sys; dest=sys.argv[-1]; os.makedirs(dest, exist_ok=True); [shutil.copy(f, dest) for pattern in sys.argv[1:-1] for f in glob.glob(pattern) if os.path.isfile(f)]"
else
    TEXMFHOME ?= $(HOME)/texmf
    PYTHON ?= python3
    RM = rm -f
    RMDIR = rm -rf
    MKDIR = mkdir -p
    COPY_TO_DIR = cp
endif

INSTALL_DIR ?= $(TEXMFHOME)/tex/latex/$(PACKAGE_NAME)

.PHONY: all doc examples install clean ctan CTAN help

all: doc examples

install:
	@echo "Installing package files to local texmf ($(INSTALL_DIR))..."
ifeq ($(OS),Windows_NT)
	@$(COPY_TO_DIR) modernclassnotes.cls modernclassnotes.sty $(INSTALL_DIR)
	@initexmf --register-root="$(TEXMFHOME)" >NUL 2>&1 || exit 0
	@initexmf --update-fndb >NUL 2>&1 || exit 0
else
	$(MKDIR) $(INSTALL_DIR)
	$(COPY_TO_DIR) modernclassnotes.cls modernclassnotes.sty $(INSTALL_DIR)/
	texhash 2>/dev/null || mktexlsr 2>/dev/null || true
endif
	@echo "Package installed successfully to $(INSTALL_DIR)."

doc: $(DOC_DIR)/modernclassnotes-doc.pdf \
     $(DOC_DIR)/modernclassnotes-doc-de.pdf \
     $(DOC_DIR)/modernclassnotes-doc-fr.pdf \
     $(DOC_DIR)/modernclassnotes-doc-zh.pdf

$(DOC_DIR)/modernclassnotes-doc-zh.pdf: $(DOC_DIR)/modernclassnotes-doc-zh.tex modernclassnotes.cls
	@echo "Compiling documentation $<..."
	xelatex -interaction=nonstopmode -output-directory=$(DOC_DIR) $<

$(DOC_DIR)/%.pdf: $(DOC_DIR)/%.tex modernclassnotes.cls
	@echo "Compiling documentation $<..."
	$(TEX) $(TEXFLAGS) -output-directory=$(DOC_DIR) $<
	$(TEX) $(TEXFLAGS) -output-directory=$(DOC_DIR) $<

examples: $(EXAMPLES_DIR)/01-complete-course-notes.pdf \
          $(EXAMPLES_DIR)/02-single-lecture-handout.pdf \
          $(EXAMPLES_DIR)/03-homework-worksheet.pdf \
          $(EXAMPLES_DIR)/04-chapter-notes.pdf \
          $(EXAMPLES_DIR)/05-german-vorlesungsskript.pdf \
          $(EXAMPLES_DIR)/06-french-fiche-de-cours.pdf \
          $(EXAMPLES_DIR)/07-chinese-worksheet-homework.pdf

$(EXAMPLES_DIR)/07-chinese-worksheet-homework.pdf: $(EXAMPLES_DIR)/07-chinese-worksheet-homework.tex modernclassnotes.cls
	@echo "Compiling example $<..."
	xelatex -interaction=nonstopmode -output-directory=$(EXAMPLES_DIR) $<

$(EXAMPLES_DIR)/%.pdf: $(EXAMPLES_DIR)/%.tex modernclassnotes.cls
	@echo "Compiling example $<..."
	$(TEX) $(TEXFLAGS) -output-directory=$(EXAMPLES_DIR) $<
	$(TEX) $(TEXFLAGS) -output-directory=$(EXAMPLES_DIR) $<

ctan: all
	@echo "Creating CTAN release package..."
ifeq ($(OS),Windows_NT)
	@$(RMDIR) $(PACKAGE_NAME)-ctan $(PACKAGE_NAME).zip $(PACKAGE_NAME)-$(VERSION).zip
	@$(MKDIR) $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/doc $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/examples
	@$(COPY_TO_DIR) modernclassnotes.cls modernclassnotes.sty README.md LICENSE Makefile $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/
	@$(COPY_TO_DIR) $(DOC_DIR)/modernclassnotes-doc.tex $(DOC_DIR)/modernclassnotes-doc.pdf $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/doc/
	@$(COPY_TO_DIR) $(EXAMPLES_DIR)/*.tex $(EXAMPLES_DIR)/*.pdf $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/examples/
	@$(PYTHON) -c "import shutil; shutil.make_archive('$(PACKAGE_NAME)', 'zip', '$(PACKAGE_NAME)-ctan')"
	@$(RMDIR) $(PACKAGE_NAME)-ctan
else
	rm -rf $(PACKAGE_NAME)-ctan $(PACKAGE_NAME).zip $(PACKAGE_NAME)-$(VERSION).zip
	mkdir -p $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)
	cp modernclassnotes.cls modernclassnotes.sty README.md LICENSE Makefile $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/
	mkdir -p $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/doc
	cp $(DOC_DIR)/modernclassnotes-doc.tex $(DOC_DIR)/modernclassnotes-doc.pdf $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/doc/
	mkdir -p $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/examples
	cp $(EXAMPLES_DIR)/*.tex $(EXAMPLES_DIR)/*.pdf $(PACKAGE_NAME)-ctan/$(PACKAGE_NAME)/examples/
	find $(PACKAGE_NAME)-ctan -name ".*" -delete
	cd $(PACKAGE_NAME)-ctan && (zip -r ../$(PACKAGE_NAME).zip $(PACKAGE_NAME) -x "*/.*" 2>/devnull || $(PYTHON) -m zipfile -c ../$(PACKAGE_NAME).zip $(PACKAGE_NAME))
	rm -rf $(PACKAGE_NAME)-ctan
endif
	@echo "CTAN release package created: $(PACKAGE_NAME).zip"

CTAN: ctan

clean:
	@echo "Cleaning auxiliary build artifacts..."
ifeq ($(OS),Windows_NT)
	@$(RM) *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz $(PACKAGE_NAME).zip $(PACKAGE_NAME)-*.zip
	@$(RM) $(DOC_DIR)/*.aux $(DOC_DIR)/*.log $(DOC_DIR)/*.toc $(DOC_DIR)/*.out $(DOC_DIR)/*.fls $(DOC_DIR)/*.fdb_latexmk
	@$(RM) $(EXAMPLES_DIR)/*.aux $(EXAMPLES_DIR)/*.log $(EXAMPLES_DIR)/*.toc $(EXAMPLES_DIR)/*.out $(EXAMPLES_DIR)/*.fls $(EXAMPLES_DIR)/*.fdb_latexmk
else
	rm -f *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz $(PACKAGE_NAME).zip $(PACKAGE_NAME)-*.zip
	rm -f $(DOC_DIR)/*.aux $(DOC_DIR)/*.log $(DOC_DIR)/*.toc $(DOC_DIR)/*.out $(DOC_DIR)/*.fls $(DOC_DIR)/*.fdb_latexmk
	rm -f $(EXAMPLES_DIR)/*.aux $(EXAMPLES_DIR)/*.log $(EXAMPLES_DIR)/*.toc $(EXAMPLES_DIR)/*.out $(EXAMPLES_DIR)/*.fls $(EXAMPLES_DIR)/*.fdb_latexmk
endif

help:
	@echo "modernclassnotes Build Tool"
	@echo "  make all       Compile documentation and all example PDFs"
	@echo "  make doc       Compile user manual documentation"
	@echo "  make examples  Compile example note/handout/worksheet PDFs"
	@echo "  make install   Install package to local TeX tree"
	@echo "  make ctan      Bundle CTAN release zip package"
	@echo "  make clean     Remove temporary TeX build files"
