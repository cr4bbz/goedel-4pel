# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.3`  
**Research gates represented:** Gate 0 through Gate 3  
**Next manuscript dependency:** Gate 4 collapse-assumption lattice

The manuscript is deliberately separated from `docs/`:

- `docs/` is the research laboratory: alternatives, rejected definitions, conjectures, countermodels, and gate notes belong there.
- `paper/` contains only claims that are either already established at the current semantic level or explicitly marked as open/conjectural.

Gate 2 adds the bilateral relational modal control semantics, modal duality and classical-recovery propositions, plus the paired-neighborhood representation.

Gate 3 adds the directional decomposition of A1, isolates the direct positive-support content of A4, derives informative negative positivity rigidity from strong A1 plus positive rigidity, corrects the negative modal-collapse target, and records local glut/gap obstructions to the classical `G + Z -> P(Z)` reflection step.

The first collapse classification continues to use the S5 relational control semantics so that modal-frame generalization does not become a confounding variable.

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
