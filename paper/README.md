# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.9`  
**Research gates represented:** Gate 0 through the current Gate-8 comparative milestone  
**Next manuscript dependency:** Gate-8 assumption minimization / paired-neighborhood generalization and Gate-9 source/prior-art audit

The manuscript is deliberately separated from `docs/`:

- `docs/` is the research laboratory: alternatives, rejected definitions, conjectures, countermodels, and gate notes belong there.
- `paper/` contains only claims that are established at the current semantic level, machine-checked, supported by explicit finite countermodels, or explicitly marked open/conjectural.

Gates 1–7 establish the bilateral FDE kernel, relational modal control semantics, positivity decomposition, collapse analysis, Scott Godlikeness/essence/necessary existence reconstruction, and the first Lean/finite-model verification layer.

Gate 8 adds:

- project-internal exact positive Godlikeness and its shorter T2 route;
- a bilateral Anderson candidate with classical recovery and a necessary-God / no-positive-collapse finite model;
- symmetry-only T3 theorems for Scott-after-T2 and Anderson, together with non-symmetric S4 countermodels;
- the Fitting intension/extension split;
- a machine-checked obstruction showing that unrestricted bilateral extension comprehension makes the naive Fitting `REG_G` route incompatible with positive Godlikeness;
- a repaired, non-vacuous Fitting candidate over a selected FDE-negation-closed admissible extension domain that does not globally prohibit gluts;
- machine-checked admissible Fitting essence/NE interfaces and classical recovery;
- a frame-free de-re possibility-to-necessity theorem;
- an explicit `STAB_G` bridge for de-dicto lifting;
- a finite de-re/de-dicto separation model when `STAB_G` fails;
- a complete-S5 admissible Fitting model with positive necessary Godlike existence, genuine `B` extension information, and failure of positive modal collapse.

The central manuscript thesis is therefore now comparative: under involutive FDE negation the final signed collapse schemata are coupled, while the decisive variation lies upstream in where positivity, reflection, necessary exemplification, and intension/extension structure are placed.

The open minimality claims remain explicit. The Scott T2 finite search does not establish global minimality; the symmetry-only T3 theorems establish sufficiency rather than unique weakest frame conditions; and the Fitting admissible-domain assumptions and `STAB_G` have not yet been globally minimized.

## Build

From this directory:

```bash
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

or, with `latexmk`:

```bash
latexmk -pdf main.tex
```

Generated PDF and auxiliary files are not source-of-truth artifacts. The `.tex` and `.bib` files are canonical.

## Status discipline

The manuscript distinguishes:

- `established`: follows from the fixed semantics or frozen classical baseline;
- `machine-checked`: represented by a general Lean theorem or executable named countermodel/regression with an explicit bound;
- `open`: explicitly not yet settled;
- `conjectural`: a research hypothesis awaiting proof or countermodel.

No bounded finite search or fixture is promoted to an unbounded theorem. Exact higher-order correspondence with the frozen Scott/AFP control development and the published Anderson/Fitting formalizations remains part of the Gate-9 publication audit.
