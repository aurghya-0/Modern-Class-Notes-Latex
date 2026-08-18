# 🎓 Modern Class Notes (`modernclassnotes`)

[![LaTeX](https://img.shields.io/badge/LaTeX-2e-blue.svg)](https://www.latex-project.org/)
[![License: LPPL 1.3c](https://img.shields.io/badge/License-LPPL%201.3c-green.svg)](https://www.latex-project.org/lppl.txt)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![TeX Live 2025 Ready](https://img.shields.io/badge/TeX%20Live-2025%20Compatible-brightgreen.svg)]()
[![CTAN Version](https://img.shields.io/ctan/v/modernclassnotes)](https://ctan.org/pkg/modernclassnotes)

**`modernclassnotes`** is a state-of-the-art, open-source LaTeX package and document class tailored for university professors, lecturers, researchers, and students. It produces clean, beautifully formatted, and modern class notes, lecture handouts, and assignment worksheets.

Designed with a **zero-dependency native box engine**, it works out of the box on standard TeX Live, MiKTeX, and Overleaf without requiring complex non-standard package installations.

---

## ✨ Features

- **4 Document Modes**:
  - `mode=notes`: Full multi-lecture course notes, semester manuals, and syllabus guides.
  - `mode=handout`: Compact 1–2 page lecture summary handouts with structured metadata banners.
  - `mode=worksheet`: Homework assignments & problem sets with student ID fields and togglable solution keys (`showsolutions=true/false`).
  - `mode=chapternotes`: Chapter-based notes and reading summaries with optional chapter objectives lists.
- **8 Curated Color Palettes**:
  - `ocean` (Default modern teal/cyan)
  - `nord` (Scandinavian ice/slate)
  - `midnight` (Academic deep blue)
  - `emerald` (Forest green/mint)
  - `burgundy` (Classic wine/crimson)
  - `amethyst` (Vibrant purple/lavender)
  - `purple` (Soft purple/violet)
  - `mono` (Minimalist monochrome)
- **Expanded Font Options**:
  - `default` (Latin Modern), `palatino`, `charter`, `sans`/`helvet`, `kpfonts`, `pagella`, `sourceserif`, `fira`, `libertine`, `utopia`
- **Footer Control**:
  - `official=true/false`: Toggle professor and institution information in footers.
- **Pedagogical Callout Environments**:
  - Mathematics: `theorem`, `lemma`, `proposition`, `corollary`, `proof`, `definition`
  - Explanatory: `example`, `remark`, `note`, `warning`, `tip`, `takeaways`
  - Assessment: `exercise`, `solution`, `codebox`
- **Dynamic Lecture & Chapter Tracking**:
  - Automated lecture headers via `\lecture[date]{number}{title}`.
  - Chapter headings with optional objectives via `\chapter{number}{title}{objectives}` and subchapters via `\subchapter{number}{title}`.
- **Multi-Language Localization**:
  - `lang=english` / `en` (Default English)
  - `lang=german` / `de` / `ngerman` (Full German translation for Vorlesungsskript, Übungen, Sätze, Beweise)
  - `lang=french` / `fr` (Full French translation for Notes de cours, Exercices, Théorèmes, Démonstrations)
  - `lang=chinese` / `zh` / `cjk` (Full Chinese translation for 课程笔记, 讲/章, 定理, 解答, 证明)
- **CTAN & Open-Source Distribution Ready**:
  - Dual LPPL 1.3c / MIT licensed, complete with build `Makefile` and CTAN packaging scripts.

---

## 🚀 Quick Start

### 1. Minimal Multi-Lecture Course Notes

```latex
\documentclass[mode=notes, palette=ocean, fontsize=11pt]{modernclassnotes}

\course{Data Structures & Algorithms}
\coursecode{CS 201}
\professor{Dr. Alex Morgan}
\institution{Department of Computer Science}
\term{Fall 2026}
\title{CS 201: Class Notes}

\begin{document}

\maketitle
\tableofcontents
\newpage

\lecture[Sept 2, 2026]{1}{Algorithm Complexity}

\begin{definition}[Big-O Notation]
Let $f(n)$ and $g(n)$ be functions. We write $f(n) = O(g(n))$ if there exist positive constants $c$ and $n_0$ such that $f(n) \le c \cdot g(n)$ for all $n \ge n_0$.
\end{definition}

\begin{theorem}[Master Theorem]
Provides asymptotic bounds for divide-and-conquer recurrences.
\end{theorem}

\end{document}
```

### 2. Single Lecture Summary Handout

```latex
\documentclass[mode=handout, palette=nord]{modernclassnotes}

\course{Linear Algebra}
\coursecode{MATH 301}
\professor{Prof. Sarah Jenkins}
\term{Fall 2026}
\lecturedate{October 14, 2026}
\title{Singular Value Decomposition (SVD)}

\begin{document}
\maketitle

\section{Overview}
Singular Value Decomposition factorizes any real matrix $A \in \mathbb{R}^{m \times n}$ into $A = U \Sigma V^T$.
\end{document}
```

### 3. Homework Worksheet with Solutions

```latex
\documentclass[mode=worksheet, palette=emerald, showsolutions=true]{modernclassnotes}

\course{Probability & Statistics}
\coursecode{STAT 210}
\term{Fall 2026}
\assignmentname{Problem Set 4: Continuous Random Variables}

\begin{document}
\maketitle

\begin{exercise}[PDF Normalization]
Find $c$ such that $f(x) = c(1-x^2)$ for $x \in [0,1]$ is a valid PDF.
\end{exercise}

\begin{solution}
Integrating over $[0,1]$ yields $\frac{2}{3}c = 1 \implies c = \frac{3}{2}$.
\end{solution}

\end{document}
```

---

## 📖 Multilingual User Manuals

The comprehensive package documentation and architecture guide is provided in four languages under the `doc/` directory:

- 🇬🇧 **English**: [`doc/modernclassnotes-doc.pdf`](doc/modernclassnotes-doc.pdf) ([`tex`](doc/modernclassnotes-doc.tex))
- 🇩🇪 **German** (*Deutsch*): [`doc/modernclassnotes-doc-de.pdf`](doc/modernclassnotes-doc-de.pdf) ([`tex`](doc/modernclassnotes-doc-de.tex))
- 🇫🇷 **French** (*Français*): [`doc/modernclassnotes-doc-fr.pdf`](doc/modernclassnotes-doc-fr.pdf) ([`tex`](doc/modernclassnotes-doc-fr.tex))
- 🇨🇳 **Chinese** (*中文*): [`doc/modernclassnotes-doc-zh.pdf`](doc/modernclassnotes-doc-zh.pdf) ([`tex`](doc/modernclassnotes-doc-zh.tex))

---

## 🛠️ Installation & Building

### Standard Usage (Local Directory)
Simply copy `modernclassnotes.cls` (or `modernclassnotes.sty`) into your TeX document folder, or add it to your local TeX tree (`~/texmf/tex/latex/modernclassnotes/`).

### Building with `make`
- **Compile all docs & examples**:
  ```bash
  make all
  ```
- **Compile user manuals**:
  ```bash
  make doc
  ```
- **Compile examples**:
  ```bash
  make examples
  ```
- **Package for CTAN submission**:
  ```bash
  make ctan
  ```
- **Clean temporary build files**:
  ```bash
  make clean
  ```

---

## 📁 Repository Structure

```
Modern-Class-Notes-Latex/
├── modernclassnotes.cls            # Primary LaTeX document class
├── modernclassnotes.sty            # Package version for inclusion in standard docs
├── Makefile                        # Cross-platform build automation script
├── build.sh                        # Shell build script
├── LICENSE                         # Dual LPPL 1.3c / MIT license
├── README.md                       # Project documentation & GitHub homepage
├── doc/
│   ├── modernclassnotes-doc.tex    # English user manual (source)
│   ├── modernclassnotes-doc.pdf    # English user manual (PDF)
│   ├── modernclassnotes-doc-de.tex # German user manual (source)
│   ├── modernclassnotes-doc-de.pdf # German user manual (PDF)
│   ├── modernclassnotes-doc-fr.tex # French user manual (source)
│   ├── modernclassnotes-doc-fr.pdf # French user manual (PDF)
│   ├── modernclassnotes-doc-zh.tex # Chinese user manual (source)
│   └── modernclassnotes-doc-zh.pdf # Chinese user manual (PDF)
└── examples/
    ├── 01-complete-course-notes.tex    # English multi-lecture course notes template
    ├── 01-complete-course-notes.pdf    # English course notes PDF preview
    ├── 02-single-lecture-handout.tex    # English single lecture handout template
    ├── 02-single-lecture-handout.pdf    # English handout PDF preview
    ├── 03-homework-worksheet.tex       # English problem set & worksheet template
    ├── 03-homework-worksheet.pdf       # English worksheet PDF preview
    ├── 04-chapter-notes.tex            # English chapter notes template with objectives
    ├── 04-chapter-notes.pdf            # English chapter notes PDF preview
    ├── 05-german-vorlesungsskript.tex  # German course notes template
    ├── 05-german-vorlesungsskript.pdf  # German course notes PDF preview
    ├── 06-french-fiche-de-cours.tex    # French lecture summary handout template
    ├── 06-french-fiche-de-cours.pdf    # French handout PDF preview
    ├── 07-chinese-worksheet-homework.tex# Chinese homework worksheet template
    └── 07-chinese-worksheet-homework.pdf# Chinese worksheet PDF preview
```

---

## 🌐 Open Source & CTAN Contribution

This package is created as an open-source initiative under the **LaTeX Project Public License (LPPL v1.3c)** and the **MIT License**.

Contributions, bug reports, and pull requests are welcome!

---
*Created for educators, researchers, and open-source contributors worldwide.*
