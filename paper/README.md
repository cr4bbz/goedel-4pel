# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.8`  
**Research gates represented:** Gate 0 through the current Gate-8 comparative milestone  
**Next manuscript dependency:** extension-level Fitting essence / necessary-existence reconstruction

The manuscript is deliberately separated from `docs/`:

- `docs/` is the research laboratory: alternatives, rejected definitions, conjectures, countermodels, and gate notes belong there.
- `paper/` contains only claims that are established at the current semantic level, machine-checked, supported by explicit finite countermodels, or explicitly marked open/conjectural.

Gate 2 adds the bilateral relational modal control semantics and paired-neighborhood representation.

Gate 3 adds the directional A1 decomposition and positivity-rigidity analysis.

Gate 4 adds collapse-channel equivalence, rigidity countermodels, and the local reflection/minimality analysis.

Gate 5 adds bilateral actualist quantification, semantic necessary positive entailment, `T1-T`, the A3 split, possible positive God-like existence, and `G-sup-v0.1`.

Gate 6 adds bilateral essence and necessary existence, glut/gap T2 countermodels, a sufficient T2 recovery route, conditional positive T3, discharge of `GW`, and the essence-compressed modal-collapse theorem.

Gate 7 adds two verification layers:

- Lean 4.30.0 machine proofs of schema-level `MC+ <-> MC-`, `T1-T`, the conditional T2 recovery theorem, conditional T3, `T3+ => GW`, essence-compressed positive modal collapse, and classical bilateral recovery interfaces;
- executable finite-model regressions for the T1 glut obstruction and both T2 countermodels;
- a broader bounded T2 assumption search with 873 full-antecedent models, all satisfying `T2+`;
- bounded individual indispensability of `A1-L`, `R+`, `COMP_P^G`, and `CONS_G^G` in that generated family.

Gate 8 adds comparative and frame-sensitive results:

- the project-internal `G-exact+` comparison and the Lean theorem `G-exact+ + R+ => T2-exact+`;
- a bilateral Anderson candidate with machine-checked classical recovery and an executable necessary-God / no-positive-collapse model;
- general symmetry-only T3 theorems for both the Scott-support branch (after `T2+`) and the Anderson branch;
- reflexive-transitive but non-symmetric finite countermodels to the corresponding T3 claims, showing that S4 alone does not replace symmetry in these routes;
- explicit recognition that reflexivity belongs later to `T3+ => GW` and to the current essence-compressed collapse theorem, rather than to the reduced Scott T3 theorem;
- the first Fitting-specific Lean boundary, separating bilateral property extensions from world-indexed intensions and typing positivity over extensions.

The central manuscript thesis is now mechanically supported beyond the original S5 presentation: under involutive FDE negation the final collapse schemata are coupled, while the decisive non-classical structure lies upstream in positivity, possible exemplification, and especially the relation between Godlikeness and essence. Gate 8 further shows that the Scott T3 step itself requires substantially less modal frame structure than the original control proof suggested.

The open Scott minimality question is explicitly unbounded. The finite search does not show that the current T2 recovery package is globally weakest. Likewise, the symmetry-only T3 theorems establish sufficiency, not a unique globally weakest frame condition.

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

The manuscript distinguishes:

- `established`: follows from the fixed semantics or frozen classical baseline;
- `machine-checked`: represented by a general Lean theorem or executable named countermodel/regression with an explicit bound;
- `open`: explicitly not yet settled;
- `conjectural`: a research hypothesis awaiting proof or countermodel.

No bounded finite search is promoted to an unbounded theorem. Exact higher-order correspondence with the frozen Scott/AFP control development and the published Anderson/Fitting formalizations remains part of the publication audit.
