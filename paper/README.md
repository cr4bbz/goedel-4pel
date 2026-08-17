# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.6`  
**Research gates represented:** Gate 0 through Gate 6  
**Next manuscript dependency:** Gate 7 mechanization and T2 minimality

The manuscript is deliberately separated from `docs/`:

- `docs/` is the research laboratory: alternatives, rejected definitions, conjectures, countermodels, and gate notes belong there.
- `paper/` contains only claims that are already established at the current semantic level, supported by explicit finite countermodels, or explicitly marked open/conjectural.

Gate 2 adds the bilateral relational modal control semantics and paired-neighborhood representation.

Gate 3 adds the directional A1 decomposition and positivity-rigidity analysis.

Gate 4 adds collapse-channel equivalence, rigidity countermodels, and the local reflection/minimality analysis.

Gate 5 adds bilateral actualist quantification, semantic necessary positive entailment, `T1-T`, the A3 split, possible positive God-like existence, and `G-sup-v0.1`.

Gate 6 adds:

- signed necessary-entailment counter-support `NEnt-_E`;
- bilateral `Ess-sup-v0.1` and `NE-sup-v0.1`;
- two explicit two-world S5 countermodels refuting automatic `T2+` by glut and gap mechanisms;
- a sufficient relevant-regularity route to `T2+`;
- the result that `A5+` alone suffices for the positive T3 branch once a God-like witness exists;
- conditional `T3+ : +□∃ᴱx G(x)` and discharge of `GW`;
- the essence-compressed theorem `T2+ + T3+ + CONST => MC+`, with `MC-` following by Gate 4;
- a concrete inconsistency-tolerance pattern in which glutty positivity of `NE` does not destroy the positive T3 branch.

The central manuscript thesis is now sharper: under symmetric FDE negation the final collapse schemata are coupled, while the decisive non-classical obstruction is the recovery of positive Godlikeness-as-essence. The next phase is therefore mechanization plus minimization of the assumptions sufficient for `T2+`.

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
