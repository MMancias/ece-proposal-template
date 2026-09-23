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
\RequirePackage{newtxtext,newtxmath}           % Times New Roman font
\RequirePackage{setspace}                      % Line spacing control
\RequirePackage{titlesec}                      % Section header styling
\RequirePackage{fancyhdr}                      % Headers and footers
\RequirePackage{enumitem}                      % List customization
\RequirePackage{booktabs}                      % Clean tables
\RequirePackage{tabularx}                      % Auto-wrapping tables
\RequirePackage{xcolor}                        % Color formatting
\RequirePackage{graphicx}                      % Figure inclusion
\RequirePackage{environ}                       % Environment capture
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

% --- Title Block Command (12pt Throughout) ---
\renewcommand{\maketitle}{%
  \begin{singlespace}
    \begin{center}
      {\bfseries \@title \par}
      \vspace{1em}
      {\@author \par}
      \vspace{0.5em}
      {\@department \par \@institution \par}
      \vspace{0.5em}
      {\textbf{Advisor:} \@advisor \par}
      \vspace{0.5em}
      {\@proposaldate \par}
    \end{center}
  \end{singlespace}
  \vspace{1em}
  \hrule
  \vspace{1.5em}
}

% --- Standalone 1-Page Project Summary Environment ---
\newenvironment{projectsummary}{%
  \pagestyle{empty}
  \hypersetup{pageanchor=false}
  \begin{center}
    {\bfseries \@title \par}
    \vspace{0.5em}
    {\textbf{FI:} \@author \quad | \quad \textbf{Advisor:} \@advisor \par}
    {\@department, \@institution \par}
  \end{center}
  \vspace{0.5em}
  \hrule
  \vspace{1em}
}{%
  \vfill
  \newpage
  \pagestyle{fancy}
  \hypersetup{pageanchor=true}
  \pagenumbering{arabic}
}

% --- Summary Subheadings ---
\newcommand{\summaryoverview}[1]{\noindent\textbf{Overview: } #1 \par\vspace{0.8em}}
\newcommand{\summaryintellectualmerit}[1]{\noindent\textbf{Intellectual Merit \& Contributions: } #1 \par\vspace{0.8em}}
\newcommand{\summarybroadersignificance}[1]{\noindent\textbf{Broader Significance: } #1 \par\vspace{0.8em}}

% --- Custom Environments ---
\newenvironment{objectiveslist}{%
  \begin{enumerate}[label=\textbf{Objective \arabic*:}, leftmargin=*]
}{%
  \end{enumerate}
}

\NewEnviron{riskregister}{%
  \begin{table}[htbp]
  \centering
  \small
  \caption{Risk Register, Triggers, Mitigation Strategies, and Alternative Paths} % can modify these for table caption
  \label{tab:risk_register}
  \begin{tabularx}{\textwidth}{>{\bfseries}l X X X} % number of columns and their alignment can be modified here
  \toprule
  Risk & Observable Trigger & Mitigation Strategy & Alternative Path \\ % can modify these for table headers
  \midrule
  \BODY
  \bottomrule
  \end{tabularx}
  \end{table}
}

\setstretch{1.15}