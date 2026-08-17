# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.1`  
**Research gates represented:** Gate 0 and Gate 1  
**Next manuscript dependency:** Gate 2 modal semantics

The manuscript is deliberately separated from `docs/`:

- `docs/` is the research laboratory: alternatives, rejected definitions, conjectures, countermodels, and gate notes belong there.
- `paper/` contains only claims that are either already established at the current semantic level or explicitly marked as open/conjectural.

## Build

From this directory, a standard BibTeX workflow is:

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

If `latexmk` is installed:

```bash
latexmk -pdf main.tex
```

Generated PDF and auxiliary files should not be treated as source-of-truth artifacts. The `.tex` and `.bib` files are canonical.

## Status discipline

The manuscript uses three conceptual labels:

- `established`: follows from the currently fixed semantics or frozen classical baseline;
- `open`: explicitly not yet settled;
- `conjectural`: a research hypothesis awaiting proof or countermodel.

No result should be promoted from `open` or `conjectural` without a corresponding proof, model analysis, or mechanized check recorded in the repository.
