# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.5`  
**Research gates represented:** Gate 0 through Gate 5  
**Next manuscript dependency:** Gate 6 essence, necessary existence, A5, and the T3/GW branch

The manuscript is deliberately separated from `docs/`:

- `docs/` is the research laboratory: alternatives, rejected definitions, conjectures, countermodels, and gate notes belong there.
- `paper/` contains only claims that are either already established at the current semantic level or explicitly marked as open/conjectural.

Gate 2 adds the bilateral relational modal control semantics, modal duality and classical-recovery propositions, plus the paired-neighborhood representation.

Gate 3 adds the directional decomposition of A1, isolates the direct positive-support content of A4, corrects the negative modal-collapse target, and records local glut/gap obstructions to the classical `G + Z -> P(Z)` reflection step.

Gate 4 adds the collapse-channel equivalence theorem, two-world S5 countermodels separating the rigidity channels without A1, the strong-A1 rigidity-coupling theorem, the locally minimal `REF+` recovery package, and the conditional interface-level collapse theorem.

Gate 5 adds bilateral actualist quantifier clauses, semantic necessary positive entailment `NEnt+_E`, the truth-only possible-exemplification theorem `T1-T`, a glut countermodel to unrestricted `+P -> +◇∃E`, the weak/control split `A3+` versus `A3-T`, possible positive God-like existence, and the support-based bilateral Godlikeness definition `G-sup-v0.1`.

Gate 5 also audits the Gate-4 higher-order interfaces:

- `D1+` is discharged by `G-sup-v0.1`;
- `CONST` is discharged by full intensional property comprehension / lambda abstraction;
- `GW`, `COMP_P`, and `CONS_G` remain unforced.

The central manuscript thesis remains: under symmetric FDE negation, informative positive and negative modal collapse do not separate. The non-classical structure occurs upstream in A1 directionality, positivity rigidity, truth-only versus glutty positivity, reflection, and higher-order witness supply.

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
