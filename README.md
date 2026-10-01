# Boise State ECE Ph.D. Proposal LaTeX Starter

This repository is a starting point for Boise State University Electrical and Computer Engineering Ph.D. students preparing a research proposal. It contains a LaTeX class for common proposal formatting and a sample document showing a possible proposal structure.

This is a student-maintained starting template, not an official university policy document. Confirm current formatting, page limits, required content, and logo use with your advisor and department before submitting.

## What's Included

- `eceproposal.cls`: the document class. It sets 12-point type, US letter paper, one-inch margins, single spacing, section-heading styles, page headers and footers, and linked PDF bookmarks.
- `main.tex`: a starter proposal with cover page, project summary, project description, objectives, risk register, and bibliography.
- `ProposalExam.bib`: a sample BibTeX database used by the starter document.
- `class_extra/`: Boise State and AMPS logo image assets used on the cover. Keep this directory and its expected filenames alongside the document.

## Requirements

Install a LaTeX distribution with XeLaTeX and BibTeX, plus the packages used by the class and the `IEEEtran` bibliography style. TeX Live (including a sufficiently complete package collection) or MiKTeX can provide these. On Linux, also make sure the `Times New Roman` font is installed and visible to XeLaTeX; the class requests this font when using XeLaTeX or LuaLaTeX.

For VS Code, install the **LaTeX Workshop** extension and make sure the LaTeX executables (`xelatex` and `bibtex`) are on your system `PATH`.

## Quick Start

1. Open this folder in VS Code, or copy the starter files into a new folder. Keep `eceproposal.cls`, `main.tex`, `ProposalExam.bib`, and `class_extra/` together.
2. Edit the metadata near the top of `main.tex`: title, author, advisor, department, institution, and proposal date.
3. Replace the instructional placeholder text with your proposal content. Update the citation and bibliography entries as needed.
4. Build `main.tex` with the XeLaTeX/BibTeX recipe described below.

You can manage bibliography entries in Zotero and use [Better BibTeX](https://retorque.re/zotero-better-bibtex/) to export a `.bib` file and automatically update it as your Zotero library changes. See the Better BibTeX documentation for setup details.

The document's first lines identify `main.tex` as the root file and request XeLaTeX. The build recipe should use the same engine. If you rename the root `.tex` file, update the root-file directive.

## VS Code Setup

Put project-specific settings in `.vscode/settings.json` at the root of the proposal folder. This keeps the setup with the project instead of changing settings for every VS Code workspace on your machine. The following is a small LaTeX Workshop configuration based on the provided setup, with the engine aligned to the starter document:

```json
{
	"latex-workshop.latex.autoBuild.run": "onSave",
	"latex-workshop.latex.autoClean.run": "never",
	"latex-workshop.latex.view.pdf.viewer": "tab",
	"latex-workshop.latex.recipe.default": "first",
	"latex-workshop.latex.recipes": [
		{
			"name": "xelatex -> bibtex -> xelatex * 2",
			"tools": ["xelatex", "bibtex", "xelatex", "xelatex"]
		}
	],
	"latex-workshop.latex.tools": [
		{
			"name": "xelatex",
			"command": "xelatex",
			"args": [
				"-synctex=1",
				"-interaction=nonstopmode",
				"-file-line-error",
				"%DOC%"
			]
		},
		{
			"name": "bibtex",
			"command": "bibtex",
			"args": ["%DOCFILE%"]
		}
	]
}
```

To build, open `main.tex` and select **LaTeX Workshop: Build LaTeX project** from the Command Palette (`Ctrl+Alt+B` on Windows/Linux; `Cmd+Option+B` on macOS). With auto-build enabled, saving the root document also starts a build. Open the generated PDF from the LaTeX Workshop PDF view.

The recipe runs XeLaTeX, BibTeX, then XeLaTeX twice so citations, references, and bookmarks can settle. `never` preserves auxiliary files after builds; use **LaTeX Workshop: Clean up auxiliary files** when you want to remove generated build files. The repository's `.gitignore` excludes these outputs from Git.

If your settings use a pdfLaTeX recipe while `main.tex` requests XeLaTeX, select a matching recipe or change the root-file program directive to `pdflatex` if you intentionally want pdfLaTeX. The class has a pdfLaTeX path using `newtxtext`; XeLaTeX and LuaLaTeX use `fontspec` and require `Times New Roman` to be available.

### Build from a Terminal

From the project directory, run:

```sh
xelatex main.tex
bibtex main
xelatex main.tex
xelatex main.tex
```

Run all four commands after changing citations or bibliography entries. For ordinary text edits, XeLaTeX alone is often enough, but LaTeX Workshop can run the full recipe consistently.

## Class Features

### Cover Metadata and Logos

Set the cover information in the document preamble, before `\begin{document}`:

```latex
\title{Your Proposal Title}
\author{Your Name}
\advisor{Advisor Name}
\department{Department of Electrical and Computer Engineering}
\institution{Boise State University}
\proposaldate{Month Year}
```

The class places the Boise State logo at the top left and the AMPS logo at the bottom right by default. Adjust their locations and widths in the preamble if needed:

```latex
\boiselogoposition{top-left}
\boiselogowidth{2.5in}
\lablogoposition{bottom-right}
\lablogowidth{1.0in}
```

Supported positions are `top-left`, `top-right`, `bottom-left`, and `bottom-right`. The class currently refers to `class_extra/boisestate-leftalignedlogo-2color-cmyk.png` and `class_extra/AMPS_Figma_Logo.jpg` by fixed relative paths; keep those files in place unless you also edit the class.

### Summary and Project Description

Use `\maketitle` to create the cover. The `projectsummary` environment creates a separate, unnumbered summary page with PDF bookmarks. The helper commands provide the summary headings:

```latex
\begin{projectsummary}
	\section*{Project Summary}
	\summaryoverview{Your overview.}
	\summaryintellectualmerit{Your intellectual merit.}
	\summarybroadersignificance{Your broader significance.}
\end{projectsummary}
```

Use `\projectdescription` to start the project description on a new page and add its top-level PDF bookmark. Normal numbered sections and subsections follow it.

The `objectiveslist` environment numbers objectives with bold labels. The `riskregister` environment formats rows as a four-column table; provide each row as four `&`-separated cells ending with `\\`:

```latex
\begin{objectiveslist}
	\item Develop a method.
	\item Validate the method.
\end{objectiveslist}

\begin{riskregister}
	Latency & Processing time exceeds target & Optimize implementation & Use a simpler model \\
\end{riskregister}
```

The class sets the document to single-spaced text. It does not determine whether the content or proposal structure satisfies current program requirements.

## Troubleshooting

- **`eceproposal.cls` not found:** compile from the project folder and keep the class file beside `main.tex`.
- **Logo file not found:** keep the `class_extra/` directory and the expected image filenames beside the document.
- **`Times New Roman` not found:** install that font for your operating system, or change the `\setmainfont` choice in the class to a font installed on your system and approved for your document.
- **Citations show as question marks:** check the citation key in the `.bib` file and run the full XeLaTeX, BibTeX, XeLaTeX, XeLaTeX sequence.
- **Bibliography style not found:** install the TeX distribution package that provides `IEEEtran.bst`.
- **VS Code cannot find XeLaTeX or BibTeX:** install the LaTeX distribution and restart VS Code after ensuring its executable directory is on `PATH`.