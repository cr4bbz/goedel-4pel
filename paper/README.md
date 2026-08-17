# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.4`  
**Research gates represented:** Gate 0 through Gate 4  
**Next manuscript dependency:** Gate 5 Godlikeness, A2/A3, and possible exemplification

The manuscript is deliberately separated from `docs/`:

- `docs/` is the research laboratory: alternatives, rejected definitions, conjectures, countermodels, and gate notes belong there.
- `paper/` contains only claims that are either already established at the current semantic level or explicitly marked as open/conjectural.

Gate 2 adds the bilateral relational modal control semantics, modal duality and classical-recovery propositions, plus the paired-neighborhood representation.

Gate 3 adds the directional decomposition of A1, isolates the direct positive-support content of A4, corrects the negative modal-collapse target, and records local glut/gap obstructions to the classical `G + Z -> P(Z)` reflection step.

Gate 4 adds the collapse-channel equivalence theorem, two-world S5 countermodels separating the rigidity channels without A1, the strong-A1 rigidity-coupling theorem, the locally minimal `REF+` recovery package, and the conditional interface-level collapse theorem.

The central manuscript thesis has consequently shifted: under symmetric FDE negation, informative positive and negative modal collapse do not separate. The non-classical decomposition occurs upstream in positivity rigidity, reflection, and the higher-order interfaces that feed arbitrary propositions into the Gödel–Scott machinery.

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
