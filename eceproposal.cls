%%% =========================================================================
%%% Custom LaTeX Class for ECE Doctoral Research Proposal
%%% =========================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eceproposal}[2026/09/23 V1.3 ECE Ph.D. Proposal Class]

% Base class inheritance (12pt font default)
\LoadClass[12pt,letterpaper]{article}

% --- Core Packages & Math ---
\RequirePackage[margin=1in]{geometry}          % Standard 1-inch margins
\RequirePackage{amsmath,amssymb}               % Load before newtxmath
\RequirePackage{iftex}
\ifPDFTeX
  \RequirePackage{newtxtext}                   % Times-compatible text for pdfLaTeX
\else
  \RequirePackage{fontspec}
  \setmainfont{Times New Roman}                % Use actual Times New Roman with XeLaTeX/LuaLaTeX
\fi
\RequirePackage{newtxmath}                     % Times-style math
\RequirePackage{setspace}                      % Line spacing control
\RequirePackage{titlesec}                      % Section header styling
\RequirePackage{fancyhdr}                      % Headers and footers
\RequirePackage{enumitem}                      % List customization
\RequirePackage{booktabs}                      % Clean tables
\RequirePackage{tabularx}                      % Auto-wrapping tables
\RequirePackage{xcolor}                        % Color formatting
\RequirePackage{graphicx}                      % Figure inclusion
\RequirePackage{eso-pic}                       % Cover-page logo placement
\RequirePackage{environ}                       % Environment capture
\RequirePackage{cite}                          % Sort and compress numeric citations
\RequirePackage[colorlinks=true,
  linkcolor=blue!80!black,
  citecolor=blue!80!black,
  urlcolor=blue!80!black]{hyperref} % Hyperlinks

% --- Fix Header Height for 12pt Font ---
\setlength{\headheight}{15pt}

% --- Metadata Variables ---
\def\advisor#1{\gdef\@advisor{#1}}
\def\department#1{\gdef\@department{#1}}
\def\institution#1{\gdef\@institution{#1}}
\def\proposaldate#1{\gdef\@proposaldate{#1}}
% Supported positions are top-left, top-right, bottom-left, and bottom-right.
\def\@boiselogoposition{top-left}
\def\@lablogoposition{bottom-right}
% control figure widths
\def\@boiselogowidth{2.5in}
\def\@lablogowidth{1.0in}
\newcommand{\boiselogoposition}[1]{\gdef\@boiselogoposition{#1}}
\newcommand{\lablogoposition}[1]{\gdef\@lablogoposition{#1}}
\newcommand{\boiselogowidth}[1]{\gdef\@boiselogowidth{#1}}
\newcommand{\lablogowidth}[1]{\gdef\@lablogowidth{#1}}

\newcommand{\@coverlogo}[3]{%
  \@ifundefined{@coverlogo@#1}{%
    % detect whether position names are followed
    \ClassError{eceproposal}{Invalid cover logo position `#1'}%
    {Use top-left, top-right, bottom-left, or bottom-right.}%
  }{%
    \csname @coverlogo@#1\endcsname{#2}{#3}%
  }%
}
\expandafter\def\csname @coverlogo@top-left\endcsname#1#2{%
  \AtPageUpperLeft{\put(72,-72){\makebox(0,0)[lt]{%
        \includegraphics[width=#2,keepaspectratio]{#1}}}}%
}
\expandafter\def\csname @coverlogo@top-right\endcsname#1#2{%
  \AtPageUpperRight{\put(-72,-72){\makebox(0,0)[rt]{%
        \includegraphics[width=#2,keepaspectratio]{#1}}}}%
}
\expandafter\def\csname @coverlogo@bottom-left\endcsname#1#2{%
  \AtPageLowerLeft{\put(72,72){\makebox(0,0)[lb]{%
        \includegraphics[width=#2,keepaspectratio]{#1}}}}%
}
\expandafter\def\csname @coverlogo@bottom-right\endcsname#1#2{%
  \AtPageLowerLeft{\put(0,72){\makebox[\dimexpr\paperwidth-72pt\relax][r]{%
        \includegraphics[width=#2,keepaspectratio]{#1}}}}%
}

\advisor{Advisor Name Missing}
\department{Department of Electrical and Computer Engineering}
\institution{University Name}
\proposaldate{\today}

% --- Section Header Format (12pt, Bold) ---
\titleformat{\section}{\normalfont\normalsize\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}{\normalfont\normalsize\bfseries}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\normalfont\normalsize\bfseries}{\thesubsubsection}{1em}{}
\titlespacing*{\section}{0pt}{12pt}{6pt}
\titlespacing*{\subsection}{0pt}{12pt}{6pt}
\titlespacing*{\subsubsection}{0pt}{12pt}{6pt}

% --- Page Style Setup ---
\pagestyle{fancy}
\fancyhf{}
\rhead{\small \leftmark}
\lhead{\small Ph.D. Research Proposal}
\rfoot{\small Page \thepage}
\lfoot{\small \@author}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

% --- Cover Page ---
\renewcommand{\maketitle}{%
  \hypersetup{pageanchor=false}%
  \begin{titlepage}
    \thispagestyle{empty}%
    \pdfbookmark[0]{Cover}{proposal:cover}%
    % code for cover letter images, may change as needed
    \AddToShipoutPictureFG*{%
      \@coverlogo{\@boiselogoposition}{class_extra/boisestate-leftalignedlogo-2color-cmyk.png}{\@boiselogowidth}%
      \@coverlogo{\@lablogoposition}{class_extra/AMPS_Figma_Logo.jpg}{\@lablogowidth}%
    }%
    \vspace*{\fill}%
    \begin{center}
      {\Large\bfseries \@title \par}
      \vspace{2em}
      {\@author \par}
      \vspace{1em}
      {\textbf{Advisor:} \@advisor \par}
      \vspace{1em}
      {\@department \par \@institution \par}
      \vspace{1em}
      {\@proposaldate \par}
    \end{center}
    \vspace*{\fill}%
  \end{titlepage}%
}

% --- Standalone Project Summary Environment ---
\newenvironment{projectsummary}{%
  \clearpage
  \thispagestyle{empty}%
  \hypersetup{pageanchor=false}
  \pdfbookmark[0]{Project Summary}{proposal:summary}%
}{%
  \vfill
  \clearpage
  \pagestyle{fancy}
  \hypersetup{pageanchor=true}
  \pagenumbering{arabic}
}

% --- Summary Subheadings ---
\newcommand{\summaryoverview}[1]{\pdfbookmark[1]{Overview}{proposal:summary:overview}\noindent\textbf{Overview: } #1 \par\vspace{0.8em}}
\newcommand{\summaryintellectualmerit}[1]{\pdfbookmark[1]{Intellectual Merit}{proposal:summary:merit}\noindent\textbf{Intellectual Merit} #1 \par\vspace{0.8em}}
\newcommand{\summarybroadersignificance}[1]{\pdfbookmark[1]{Broader Impact}{proposal:summary:significance}\noindent\textbf{Broader Impact: } #1 \par\vspace{0.8em}}

% --- Project Description Heading and Top-Level Bookmark ---
\newcommand{\projectdescription}{%
  \clearpage
  \phantomsection
  \pdfbookmark[0]{Project Description}{proposal:description}%
  \section*{Project Description}%
  \thispagestyle{fancy}%
}

% --- Custom Environments ---
\newenvironment{objectiveslist}{%
  \begin{enumerate}[label=\textbf{Objective \arabic*:}, leftmargin=*]
    }{%
  \end{enumerate}
}

\NewEnviron{riskregister}{%
  \begin{table}[htbp]
    \centering
    \caption{Risk Register, Triggers, Mitigation Strategies, and Alternative Paths} % can modify these for table caption
    \begin{tabularx}{\textwidth}{>{\bfseries}l X X X} % number of columns and their alignment can be modified here
      \toprule
      Risk & Observable Trigger & Mitigation Strategy & Alternative Path \\ % can modify these for table headers
      \midrule
      \BODY
      \bottomrule
    \end{tabularx}
  \end{table}
}

% Document body requirement: 12 pt and single-spaced. The cover is separately formatted above.
\setstretch{1.0}