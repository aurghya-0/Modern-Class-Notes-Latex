%% modernclassnotes.cls
%% Copyright 2026 Modern Class Notes Project
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008/05/01 or later.
%%
%% Dual-licensed under the MIT License for open-source flexibility.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{modernclassnotes}[2026/07/26 v1.0.0 Modern Class Notes Document Class]

% -------------------------------------------------------------------
% Package Options & Key-Value Handling
% -------------------------------------------------------------------
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=mcn,
  prefix=mcn@
}

\DeclareStringOption[notes]{mode}        % notes, handout, worksheet
\DeclareStringOption[ocean]{palette}     % ocean, midnight, nord, emerald, burgundy, amethyst, mono
\DeclareStringOption[11pt]{fontsize}     % 10pt, 11pt, 12pt
\DeclareStringOption[default]{font}      % default, palatino, charter, sans
\DeclareBoolOption[true]{showsolutions}  % show/hide solutions in worksheets
\DeclareBoolOption[true]{parskip}        % toggle paragraph spacing
\DeclareBoolOption[true]{numbering}      % continuous vs chapter-based numbering
\DeclareBoolOption[false]{official}      % include prof and institution in footer if true

\ProcessKeyvalOptions*

% Pass font size to base class
\LoadClass[\mcn@fontsize,a4paper]{article}

% -------------------------------------------------------------------
% Core Dependencies
% -------------------------------------------------------------------
%\RequirePackage[utf8]{inputenc} % not needed when using xelatex / modern LaTeX2e
\RequirePackage[T1]{fontenc}
\RequirePackage{xcolor}
\RequirePackage{geometry}
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}
\RequirePackage{listings}
\RequirePackage{caption}
\RequirePackage{booktabs}
\RequirePackage{array}
\RequirePackage{enumerate}
\RequirePackage{iftex}
\RequirePackage{verbatim}
\RequirePackage{xparse}    % for \NewDocumentCommand
\IfFileExists{enumitem.sty}{\RequirePackage{enumitem}}{}

\ifmcn@parskip
  \RequirePackage{parskip}
\fi

% Geometry configuration based on mode
\expandafter\ifstrequal\expandafter{\mcn@mode}{notes}{%
  \geometry{a4paper, top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm, headheight=28pt, headsep=15pt}%
}{}%
\expandafter\ifstrequal\expandafter{\mcn@mode}{worksheet}{%
  \geometry{a4paper, top=2.0cm, bottom=2.0cm, left=2.0cm, right=2.0cm, headheight=28pt, headsep=12pt}%
}{}%
\expandafter\ifstrequal\expandafter{\mcn@mode}{handout}{%
  \geometry{a4paper, top=2.0cm, bottom=2.0cm, left=2.0cm, right=2.0cm, headheight=28pt, headsep=12pt}%
}{}%
\expandafter\ifstrequal\expandafter{\mcn@mode}{chapternotes}{%
  \geometry{a4paper, top=2.0cm, bottom=2.0cm, left=2.0cm, right=2.0cm, headheight=28pt, headsep=12pt}%
}{}

% -------------------------------------------------------------------
% Itemize bullet point symbols config
% -------------------------------------------------------------------
\renewcommand{\labelitemi}{$\bullet$}
\renewcommand{\labelitemii}{$\circ$}
\renewcommand{\labelitemiii}{$\blacksquare$}
\renewcommand{\labelitemiv}{$\diamond$}

% -------------------------------------------------------------------
% Font Selection Presets
% -------------------------------------------------------------------
% Default Latin Modern / Computer Modern
\RequirePackage{lmodern}
% font option override: kpfonts
\expandafter\ifstrequal\expandafter{\mcn@font}{kpfonts}{%
  \IfFileExists{kpfonts.sty}{\RequirePackage{kpfonts}}{}%
}{}
% font option override: pagella
\expandafter\ifstrequal\expandafter{\mcn@font}{pagella}{%
  \IfFileExists{tgpagella.sty}{\RequirePackage{tgpagella}}{\RequirePackage{mathpazo}}%
}{}
% font option override: sourceserif
\expandafter\ifstrequal\expandafter{\mcn@font}{sourceserif}{%
  \IfFileExists{sourceserifpro.sty}{%
    \RequirePackage{sourceserifpro}%
  }{%
    \IfFileExists{sourcesanspro.sty}{\RequirePackage{sourcesanspro}}{}%
  }%
  \IfFileExists{newtxmath.sty}{\RequirePackage{newtxmath}}{}%
}{}
% font option override: charter
\expandafter\ifstrequal\expandafter{\mcn@font}{charter}{%
  \IfFileExists{charter.sty}{\RequirePackage{charter}}{}%
  \IfFileExists{newtxmath.sty}{\RequirePackage{newtxmath}}{}%
}{}
% font option override: helvet / sans
\expandafter\ifstrequal\expandafter{\mcn@font}{helvet}{%
  \IfFileExists{helvet.sty}{\RequirePackage{helvet}}{}%
  \renewcommand{\familydefault}{\sfdefault}%
  \IfFileExists{newtxmath.sty}{\RequirePackage{newtxmath}}{}%
}{}
\expandafter\ifstrequal\expandafter{\mcn@font}{sans}{%
  \IfFileExists{helvet.sty}{\RequirePackage{helvet}}{}%
  \renewcommand{\familydefault}{\sfdefault}%
  \IfFileExists{newtxmath.sty}{\RequirePackage{newtxmath}}{}%
}{}
% font option override: fira
\expandafter\ifstrequal\expandafter{\mcn@font}{fira}{%
  \IfFileExists{FiraSans.sty}{\RequirePackage[sfdefault]{FiraSans}}{\renewcommand{\familydefault}{\sfdefault}}%
  \IfFileExists{FiraMono.sty}{\RequirePackage{FiraMono}}{}%
}{}
% font option override: libertine
\expandafter\ifstrequal\expandafter{\mcn@font}{libertine}{%
  \IfFileExists{libertine.sty}{\RequirePackage{libertine}}{}%
}{}
% font option override: utopia
\expandafter\ifstrequal\expandafter{\mcn@font}{utopia}{%
  \IfFileExists{utopia.sty}{\RequirePackage{utopia}}{}%
}{}

% -------------------------------------------------------------------
% Color Palette Presets
% -------------------------------------------------------------------
% Default: Ocean Palette
\definecolor{mcnPrimary}{HTML}{005F73}
\definecolor{mcnSecondary}{HTML}{0A9396}
\definecolor{mcnAccent}{HTML}{94D2BD}
\definecolor{mcnBg}{HTML}{F4F7F6}
\definecolor{mcnText}{HTML}{1D2D35}
\definecolor{mcnBoxBg}{HTML}{EAF4F4}
\definecolor{mcnBorder}{HTML}{CCE3DE}
% palette option override: midnight
\expandafter\ifstrequal\expandafter{\mcn@palette}{midnight}{%
  \definecolor{mcnPrimary}{HTML}{1D2D44}
  \definecolor{mcnSecondary}{HTML}{3A86EF}
  \definecolor{mcnAccent}{HTML}{F72585}
  \definecolor{mcnBg}{HTML}{F8F9FA}
  \definecolor{mcnText}{HTML}{212529}
  \definecolor{mcnBoxBg}{HTML}{EDF2F7}
  \definecolor{mcnBorder}{HTML}{CBD5E0}
}{}
% palette option override: nord
\expandafter\ifstrequal\expandafter{\mcn@palette}{nord}{%
  \definecolor{mcnPrimary}{HTML}{2E3440}
  \definecolor{mcnSecondary}{HTML}{88C0D0}
  \definecolor{mcnAccent}{HTML}{B48EAD}
  \definecolor{mcnBg}{HTML}{F8F9FB}
  \definecolor{mcnText}{HTML}{3B4252}
  \definecolor{mcnBoxBg}{HTML}{ECEFF4}
  \definecolor{mcnBorder}{HTML}{D8DEE9}
}{}
% palette option override: emerald
\expandafter\ifstrequal\expandafter{\mcn@palette}{emerald}{%
  \definecolor{mcnPrimary}{HTML}{1B4332}
  \definecolor{mcnSecondary}{HTML}{2D6A4F}
  \definecolor{mcnAccent}{HTML}{52B788}
  \definecolor{mcnBg}{HTML}{F4F9F5}
  \definecolor{mcnText}{HTML}{1A2E26}
  \definecolor{mcnBoxBg}{HTML}{E8F5E9}
  \definecolor{mcnBorder}{HTML}{C8E6C9}
}{}
% palette option override: burgundy
\expandafter\ifstrequal\expandafter{\mcn@palette}{burgundy}{%
  \definecolor{mcnPrimary}{HTML}{5C061C}
  \definecolor{mcnSecondary}{HTML}{9D0208}
  \definecolor{mcnAccent}{HTML}{DC2F02}
  \definecolor{mcnBg}{HTML}{FAF4F5}
  \definecolor{mcnText}{HTML}{2B0D12}
  \definecolor{mcnBoxBg}{HTML}{F7EBEF}
  \definecolor{mcnBorder}{HTML}{E8C5CE}
}{}
% palette option override: amethyst
\expandafter\ifstrequal\expandafter{\mcn@palette}{amethyst}{%
  \definecolor{mcnPrimary}{HTML}{3A0CA3}
  \definecolor{mcnSecondary}{HTML}{7209B7}
  \definecolor{mcnAccent}{HTML}{4361EE}
  \definecolor{mcnBg}{HTML}{F8F7FF}
  \definecolor{mcnText}{HTML}{1D1A2E}
  \definecolor{mcnBoxBg}{HTML}{F0EEFD}
  \definecolor{mcnBorder}{HTML}{D7D2FA}
}{}
% palette option override: mono
\expandafter\ifstrequal\expandafter{\mcn@palette}{mono}{%
  \definecolor{mcnPrimary}{HTML}{212529}
  \definecolor{mcnSecondary}{HTML}{495057}
  \definecolor{mcnAccent}{HTML}{6C757D}
  \definecolor{mcnBg}{HTML}{FAFAFA}
  \definecolor{mcnText}{HTML}{212529}
  \definecolor{mcnBoxBg}{HTML}{F1F3F5}
  \definecolor{mcnBorder}{HTML}{CED4DA}
}{}
% palette option override: purple
\expandafter\ifstrequal\expandafter{\mcn@palette}{purple}{%
  \definecolor{mcnPrimary}{HTML}{560073}
  \definecolor{mcnSecondary}{HTML}{5D0A96}
  \definecolor{mcnAccent}{HTML}{A294D2}
  \definecolor{mcnBg}{HTML}{F4F4F7}
  \definecolor{mcnText}{HTML}{331D35}
  \definecolor{mcnBoxBg}{HTML}{F0EAF4}
  \definecolor{mcnBorder}{HTML}{D4CCE3}
}{}

% Environmental standard colors
\definecolor{mcnTheorem}{HTML}{023E8A}
\definecolor{mcnTheoremBg}{HTML}{EDF4FC}
\definecolor{mcnDefinition}{HTML}{0077B6}
\definecolor{mcnDefinitionBg}{HTML}{EAF6FB}
\definecolor{mcnExample}{HTML}{2B9348}
\definecolor{mcnExampleBg}{HTML}{EEF8F1}
\definecolor{mcnRemark}{HTML}{555555}
\definecolor{mcnRemarkBg}{HTML}{F5F5F5}
\definecolor{mcnWarning}{HTML}{D90429}
\definecolor{mcnWarningBg}{HTML}{FDE8EA}
\definecolor{mcnTip}{HTML}{E07A5F}
\definecolor{mcnTipBg}{HTML}{FDF2EF}

% -------------------------------------------------------------------
% Document Metadata Fields
% -------------------------------------------------------------------
\newcommand{\mcn@course}{}
\newcommand{\mcn@coursecode}{}
\newcommand{\mcn@professor}{}
\newcommand{\mcn@institution}{}
\newcommand{\mcn@term}{}
\newcommand{\mcn@department}{}
\newcommand{\mcn@docsubtitle}{}
\newcommand{\mcn@lecturedate}{}
\newcommand{\mcn@assignmentname}{}

\title{Class Notes} % Default title

\newcommand{\course}[1]{\renewcommand{\mcn@course}{#1}}
\newcommand{\coursecode}[1]{\renewcommand{\mcn@coursecode}{#1}}
\newcommand{\professor}[1]{\renewcommand{\mcn@professor}{#1}}
\newcommand{\institution}[1]{\renewcommand{\mcn@institution}{#1}}
\newcommand{\term}[1]{\renewcommand{\mcn@term}{#1}}
\newcommand{\department}[1]{\renewcommand{\mcn@department}{#1}}
\newcommand{\docsubtitle}[1]{\renewcommand{\mcn@docsubtitle}{#1}}
\newcommand{\lecturedate}[1]{\renewcommand{\mcn@lecturedate}{#1}}
\newcommand{\assignmentname}[1]{\renewcommand{\mcn@assignmentname}{#1}\title{#1}}

% -------------------------------------------------------------------
% Dynamic Running Headers & Footers
% -------------------------------------------------------------------
\newcommand{\mcn@currentlecture}{}

\pagestyle{fancy}
\fancyhf{}

\lhead{%
  \small\sffamily\bfseries\color{mcnPrimary}%
  \ifx\mcn@coursecode\@empty
    \ifx\mcn@course\@empty
      Class Notes
    \else
      \mcn@course
    \fi
  \else
    \mcn@coursecode\ifx\mcn@course\@empty\else: \mcn@course\fi
  \fi
}

\rhead{%
  \small\sffamily\color{mcnSecondary}%
  \ifx\mcn@currentlecture\@empty
    \ifx\mcn@term\@empty
      \mcn@institution
    \else
      \mcn@term
    \fi
  \else
    \mcn@currentlecture
  \fi
}

\ifmcn@official
  \lfoot{\small\sffamily\color{gray}\ifx\mcn@professor\@empty\else Prof. \mcn@professor\fi}
  \rfoot{\small\sffamily\color{gray}\ifx\mcn@institution\@empty\else\mcn@institution\fi}
\fi
\cfoot{\small\sffamily\color{mcnPrimary}\bfseries\thepage}

\renewcommand{\headrulewidth}{0.8pt}
\renewcommand{\headrule}{{\color{mcnPrimary}\hrule width\headwidth height \headrulewidth \vspace{\headsep}}}
\renewcommand{\footrulewidth}{0.4pt}
\renewcommand{\footrule}{{\color{mcnBorder}\hrule width\headwidth height \footrulewidth}}

% -------------------------------------------------------------------
% Title & Banner Commands
% -------------------------------------------------------------------
\renewcommand{\maketitle}{%
  \ifstrequal{\mcn@mode}{handout}{%
    % Handout Compact Header Banner
    \vspace*{-0.5cm}%
    \noindent
    \fcolorbox{mcnPrimary}{mcnBoxBg}{%
      \begin{minipage}{\dimexpr\linewidth-2\fboxsep-2\fboxrule\relax}%
        \paddingv
        \begin{minipage}[t]{0.65\linewidth}%
          {\raggedright
            \ifx\mcn@coursecode\@empty\else{\small\sffamily\bfseries\color{mcnSecondary}\mcn@coursecode}\par\fi
            {\Large\sffamily\bfseries\color{mcnPrimary}\@title}\par
            \ifx\mcn@docsubtitle\@empty\else{\small\sffamily\color{gray}\mcn@docsubtitle}\par\fi
          }%
        \end{minipage}%
        \begin{minipage}[t]{0.33\linewidth}%
          {\raggedleft\small\sffamily\color{mcnText}%
            \ifx\mcn@professor\@empty\else\textbf{Instructor:} \mcn@professor\par\fi
            \ifx\mcn@term\@empty\else\textbf{Term:} \mcn@term\par\fi
            \ifx\mcn@lecturedate\@empty\else\textbf{Date:} \mcn@lecturedate\par\fi
            \ifx\mcn@institution\@empty\else\textbf{Institution:} \mcn@institution\par\fi
          }%
        \end{minipage}%
      \end{minipage}%
    }%
    \vspace{0.8em}%
  }{%
  \ifstrequal{\mcn@mode}{worksheet}{%
    % Worksheet Header Banner
    \vspace*{-0.5cm}%
    \noindent
    \fcolorbox{mcnPrimary}{mcnBoxBg}{%
      \begin{minipage}{\dimexpr\linewidth-2\fboxsep-2\fboxrule\relax}%
        \paddingv
        \begin{minipage}[t]{0.55\linewidth}%
          {\raggedright
            \ifx\mcn@coursecode\@empty\else{\small\sffamily\bfseries\color{mcnSecondary}\mcn@coursecode: \mcn@course}\par\fi
            {\Large\sffamily\bfseries\color{mcnPrimary}\ifx\mcn@assignmentname\@empty\@title\else\mcn@assignmentname\fi}\par
            \ifx\mcn@term\@empty\else{\small\sffamily\color{gray}\mcn@term}\par\fi
          }%
        \end{minipage}%
        \begin{minipage}[t]{0.43\linewidth}%
          {\raggedleft\small\sffamily\color{mcnText}%
            \textbf{Student Name:} \rule{4cm}{0.4pt}\par\vspace{3pt}%
            \textbf{Student ID:} \rule{4.3cm}{0.4pt}\par\vspace{3pt}%
            \textbf{Date:} \rule{5cm}{0.4pt}%
          }%
        \end{minipage}%
      \end{minipage}%
    }%
    \vspace{0.8em}%
  }{%
    % Full Notes Cover Banner
    \begin{center}
      \vspace*{0.5cm}
      \fcolorbox{mcnPrimary}{mcnBoxBg}{%
        \begin{minipage}{\dimexpr\linewidth-2\fboxsep-2\fboxrule\relax}%
          \vspace{12pt}%
          \centering
          \ifx\mcn@coursecode\@empty\else{\small\sffamily\bfseries\color{mcnSecondary}\mcn@coursecode}\\[4pt]\fi
          {\huge\sffamily\bfseries\color{mcnPrimary}\@title}\\[6pt]
          \ifx\mcn@docsubtitle\@empty\else{\large\sffamily\color{mcnSecondary}\mcn@docsubtitle}\\[8pt]\fi
          \rule{0.6\linewidth}{1pt}\\[10pt]
          {\small\sffamily\color{mcnText}%
            \ifx\mcn@professor\@empty\else \textbf{Professor:} \mcn@professor \quad\textbar\quad \fi
            \ifx\mcn@term\@empty\else \textbf{Term:} \mcn@term \quad\textbar\quad \fi
            \ifx\mcn@institution\@empty\else \mcn@institution \fi
          }%
          \vspace{12pt}%
        \end{minipage}%
      }%
      \vspace*{0.8cm}
    \end{center}
  }}
}

\newcommand{\paddingv}{\vspace{8pt}}

% -------------------------------------------------------------------
% Lecture Tracking System
% -------------------------------------------------------------------
\newcounter{lecture}
\newcommand{\lecture}[3][]{% [date]{number}{title}
  \refstepcounter{lecture}%
  \def\mcn@currentlecture{Lecture #2: #3}%
  \par\vspace{1.2em}%
  \noindent
  \fcolorbox{mcnSecondary}{mcnBoxBg}{%
    \begin{minipage}{\dimexpr\linewidth-2\fboxsep-2\fboxrule\relax}%
      \vspace{6pt}%
      \noindent\hspace{8pt}%
      \begin{minipage}{\dimexpr\linewidth-16pt\relax}%
        {\raggedright
          {\small\sffamily\bfseries\color{mcnSecondary} LECTURE #2 \ifx&#1&\else\hfill #1\fi}\par\vspace{2pt}%
          {\Large\sffamily\bfseries\color{mcnPrimary} #3}\par
        }%
      \end{minipage}%
      \vspace{6pt}%
    \end{minipage}%
  }%
  \addcontentsline{toc}{section}{Lecture #2: #3}%
  \par\vspace{0.8em}%
}

% -------------------------------------------------------------------
% Chapter Tracking System
% -------------------------------------------------------------------
\newcounter{chapter}

\NewDocumentCommand{\chapter}{m m g}{%  % #1=number, #2=title, #3=objectives (optional)
  \setcounter{chapter}{#1}%
  \def\mcn@currentlecture{Chapter #1: #2}%
  \par\vspace{1.2em}%
  \noindent
  \fcolorbox{mcnSecondary}{mcnBoxBg}{%
    \begin{minipage}{\dimexpr\linewidth-2\fboxsep-2\fboxrule\relax}%
      \vspace{6pt}%
      \noindent\hspace{8pt}%
      \begin{minipage}{\dimexpr\linewidth-16pt\relax}%
        {\raggedright
          {\small\sffamily\bfseries\color{mcnSecondary} CHAPTER #1}\par\vspace{2pt}%
          {\Large\sffamily\bfseries\color{mcnPrimary} #2}\par
        }%
        % ---------- Optional objectives ----------
        \IfValueT{#3}{%
          \par\vspace{-6pt}% space before separator
          {\color{mcnBorder}\rule{\linewidth}{0.5pt}}% separator line (0.5pt elegant)
          \par\vspace{0pt}% space after separator
          \@ifpackageloaded{enumitem}{%
            \begin{enumerate}[
                label=\color{mcnPrimary}\arabic*.,
                nosep,
                leftmargin=*,
                after=\vspace{-\topsep}
              ]%
              \forcsvlist{\mcn@objective@item}{#3}%
            \end{enumerate}%
          }{%
            \begin{enumerate}%
              \setlength{\itemsep}{1pt}%
              \setlength{\parskip}{0pt}%
              \setlength{\parsep}{0pt}%
              \forcsvlist{\mcn@objective@item}{#3}%
            \end{enumerate}%
          }%
          \vspace{0pt}% space after objectives
        }%
        % -----------------------------------------
      \end{minipage}%
      \vspace{6pt}%
    \end{minipage}%
  }%
  \par
  \phantomsection
  \addcontentsline{toc}{section}{Chapter #1: #2}%
  \par\vspace{0.3em}%
}
\newcommand{\mcn@objective@item}[1]{\item \textcolor{mcnSecondary}{#1}}

\newcommand{\subchapter}[2]{% {section}{title}
  \par\vspace{0.5em}%
  \noindent
  {\raggedright\large\sffamily\bfseries\color{mcnPrimary}%
    \makebox[2.5em][l]{\thechapter.#1}#2\par}%
  \vspace{-1.1em}% adjust to bring rule closer
  \noindent{\color{mcnBorder}\rule{\linewidth}{2pt}}%
  \vspace{-0.3em}% adjust spacing after rule
  \par
  \phantomsection
  \addcontentsline{toc}{subsection}{%
    \texorpdfstring{%
      \makebox[3em][l]{\thechapter.#1}#2%
    }{%
      \thechapter.#1\ #2%
    }%
  }%
}

% -------------------------------------------------------------------
% Universal Custom Modern Callout Box Engine
% -------------------------------------------------------------------
% Native TeX callout frame generator (zero external macro dependency)
\newcommand{\mcn@callout}[5]{% {BorderColor}{BgColor}{Label}{Icon/Prefix}{Content}
  \par\addvspace{0.8em}%
  \noindent
  \fcolorbox{#1}{#2}{%
    \begin{minipage}{\dimexpr\linewidth-2\fboxsep-2\fboxrule\relax}%
      \vspace{6pt}%
      \noindent\hspace{8pt}%
      \begin{minipage}{\dimexpr\linewidth-16pt\relax}%
        {\sffamily\bfseries\color{#1}#4 #3}\par\vspace{4pt}%
        \color{mcnText}#5%
      \end{minipage}%
      \vspace{6pt}%
    \end{minipage}%
  }%
  \par\addvspace{0.8em}%
}

% -------------------------------------------------------------------
% Pedagogy & Theorem Environments
% -------------------------------------------------------------------
\newcounter{mcnTheoremCount}
\newcounter{mcnDefCount}
\newcounter{mcnExampleCount}
\newcounter{mcnExerciseCount}

\newenvironment{theorem}[1][]{%
  \refstepcounter{mcnTheoremCount}%
  \def\mcn@title{Theorem \themcnTheoremCount\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnTheorem}{mcnTheoremBg}{\mcn@title}{[THM]}{\usebox{\mcn@box}}%
}

\newenvironment{lemma}[1][]{%
  \refstepcounter{mcnTheoremCount}%
  \def\mcn@title{Lemma \themcnTheoremCount\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnTheorem}{mcnTheoremBg}{\mcn@title}{[LEM]}{\usebox{\mcn@box}}%
}

\newenvironment{proposition}[1][]{%
  \refstepcounter{mcnTheoremCount}%
  \def\mcn@title{Proposition \themcnTheoremCount\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnTheorem}{mcnTheoremBg}{\mcn@title}{[PROP]}{\usebox{\mcn@box}}%
}

\newenvironment{corollary}[1][]{%
  \refstepcounter{mcnTheoremCount}%
  \def\mcn@title{Corollary \themcnTheoremCount\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnTheorem}{mcnTheoremBg}{\mcn@title}{[COR]}{\usebox{\mcn@box}}%
}

\newenvironment{definition}[1][]{%
  \refstepcounter{mcnDefCount}%
  \def\mcn@title{Definition \themcnDefCount\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnDefinition}{mcnDefinitionBg}{\mcn@title}{[DEF]}{\usebox{\mcn@box}}%
}

\newenvironment{example}[1][]{%
  \refstepcounter{mcnExampleCount}%
  \def\mcn@title{Example \themcnExampleCount\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnExample}{mcnExampleBg}{\mcn@title}{[EX]}{\usebox{\mcn@box}}%
}

\newenvironment{remark}[1][]{%
  \def\mcn@title{Remark\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnRemark}{mcnRemarkBg}{\mcn@title}{[REM]}{\usebox{\mcn@box}}%
}

\newenvironment{warning}[1][]{%
  \def\mcn@title{Warning\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnWarning}{mcnWarningBg}{\mcn@title}{[!]}{\usebox{\mcn@box}}%
}

\newenvironment{tip}[1][]{%
  \def\mcn@title{Pro Tip\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnTip}{mcnTipBg}{\mcn@title}{[*]}{\usebox{\mcn@box}}%
}

\newenvironment{takeaways}{%
  \def\mcn@title{Key Takeaways}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnPrimary}{mcnBoxBg}{\mcn@title}{[KEY]}{\usebox{\mcn@box}}%
}

\newenvironment{exercise}[1][]{%
  \refstepcounter{mcnExerciseCount}%
  \def\mcn@title{Exercise \themcnExerciseCount\ifx&#1&\else\ (#1)\fi}%
  \begin{lrbox}{\mcn@box}%
  \begin{minipage}{\dimexpr\linewidth-24pt\relax}%
}{%
  \end{minipage}%
  \end{lrbox}%
  \mcn@callout{mcnSecondary}{mcnBoxBg}{\mcn@title}{[EXR]}{\usebox{\mcn@box}}%
}

\newenvironment{solution}{%
  \ifmcn@showsolutions
    \par\vspace{0.4em}%
    \noindent{\sffamily\bfseries\color{mcnSecondary}Solution:}\par\vspace{0.2em}%
  \else
    \expandafter\comment
  \fi
}{%
  \ifmcn@showsolutions
    \par\vspace{0.6em}%
  \else
    \expandafter\endcomment
  \fi
}

\newsavebox{\mcn@box}

% Standard Proof environment wrapper
\renewenvironment{proof}[1][Proof]{%
  \par\vspace{0.4em}%
  \noindent{\sffamily\bfseries\color{mcnPrimary}#1:}\quad\ignorespaces
}{%
  \hfill$\blacksquare$\par\vspace{0.6em}%
}

% -------------------------------------------------------------------
% Code Snippets & Listings Integration
% -------------------------------------------------------------------
\lstset{
  basicstyle=\small\ttfamily\color{mcnText},
  keywordstyle=\bfseries\color{mcnPrimary},
  stringstyle=\color{mcnExample},
  commentstyle=\itshape\color{mcnRemark},
  numbers=left,
  numberstyle=\tiny\color{gray},
  stepnumber=1,
  numbersep=8pt,
  backgroundcolor=\color{mcnBoxBg},
  showstringspaces=false,
  tabsize=2,
  breaklines=true,
  breakatwhitespace=false,
  frame=single,
  rulecolor=\color{mcnBorder},
  xleftmargin=12pt,
  framexleftmargin=12pt
}

\newenvironment{codebox}[1][Code Snippet]{%
  \par\vspace{0.5em}%
  \noindent{\small\sffamily\bfseries\color{mcnPrimary}#1}\par\vspace{0.3em}%
}{%
  \par\vspace{0.5em}%
}

% -------------------------------------------------------------------
% Hyperref Configuration
% -------------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=mcnPrimary,
  citecolor=mcnSecondary,
  urlcolor=mcnSecondary,
  pdfborder={0 0 0},
  breaklinks=true
}

\endinput
