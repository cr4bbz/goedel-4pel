# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.16`

**Research gates represented:** Gate 0 through the current Gate-8 comparative/minimality/domain/entailment/converse-rigidity milestone

**Newest research milestone:** `fitting-converse-rigidity-v0.1`

**Next manuscript dependency:** explicit actualist quotient semantics, four-valued fixed-point filter analysis, and Gate-9 source/prior-art audit

The manuscript is deliberately separated from `docs/`:

- `docs/` is the research laboratory: alternatives, rejected definitions, conjectures, countermodels, and gate notes belong there.
- `paper/` contains established semantic claims, machine-checked results, explicit finite countermodels, or claims whose current verification status is stated explicitly.

Gates 1–7 establish the bilateral FDE kernel, relational modal control semantics, positivity decomposition, collapse analysis, Scott Godlikeness/essence/necessary existence reconstruction, and the first Lean/finite-model verification layer.

Gate 8 now adds:

- project-internal exact positive Godlikeness and its shorter T2 route;
- a bilateral Anderson candidate with classical recovery and a necessary-God / no-positive-collapse finite model;
- symmetry-only T3 theorems for Scott-after-T2 and Anderson, together with non-symmetric S4 countermodels;
- the Fitting intension/extension split;
- the unrestricted bilateral-comprehension obstruction;
- a repaired admissible bilateral Fitting domain that does not globally prohibit gluts;
- admissible Fitting essence/NE interfaces and classical recovery;
- a frame-free de-re possibility-to-necessity route;
- positive-only de-dicto stability;
- an A1-sensitive classification route with targeted consistency;
- a second `COMP`-independent route through Godlike indiscernibility;
- derivation of that indiscernibility from positive-profile saturation;
- bilateral quotient factorization under FDE negation closure;
- FDE-algebra preservation of quotient-respecting extensions and a finite counterexample to the converse;
- a literature-facing ultrafilter comparison showing that complement decision plus relevant consistency or `A1-R` returns to the classification route;
- the new entailment/domain distinction and profile-closure construction described below;
- derivation of positive `G` reflection from forward admissible positivity transport and persistence from converse positivity transport, without frame symmetry;
- complete-S5 Anderson and Fitting finite models with positive necessary Godlike existence but failure of positive modal collapse.

### Established in `paper-v0.13`: entailment and the quotient

Section `08c_fitting_entailment_quotient.tex` records the newest Gate-8 experiment.

The source-grounded distinction is that Fitting's classical `delta`-filter is a family of **positive extensions**. Its closure behavior is filter-level. The manuscript therefore separates that from the stronger idea that the ambient selected domain `Adm` itself should contain arbitrary entailment consequences.

The stronger domain-level proposal turns out to be dangerous: once FDE bottom is admissible, bottom positively entails every rigid extension vacuously. The new Lean module implements the resulting obstruction that global domain-level entailment closure forces unrestricted bilateral comprehension, and the corresponding consistency/Godlikeness obstruction.

A finite model over all sixteen bilateral extensions on two entities additionally shows that even the package

```text
A2+
full ambient-domain entailment closure
full FDE algebra closure
profile-compatible actual existence
```

does not force positive-profile saturation.

The positive construction is instead a canonical bilateral profile closure `Sat_w`. The newest Lean module implements its closure-operator properties and the characterization of profile-saturated admissible domains as fixed points of this operation. Because Fitting entailment is actualist, the manuscript isolates a further condition requiring actual existence to respect the same profile classes; under that condition the new module implements entailment descent through the profile closure. A finite counterexample demonstrates that this descent can fail when actual existence splits a profile class.

**Verification status:** the finite entailment regressions and the root-imported Lean theorem block have been validated locally with Lean 4.30.0.

### New in `paper-v0.14`: derived positive rigidity bridge

The minimized de-dicto Fitting theorem uses only positive `G`-extension persistence and reflection. The new Lean module `FittingRigidityBridge.lean` derives reflection from the Fitting-typed admissible rigidity condition `RPlusAdm`; adding frame symmetry derives persistence and therefore the complete positive stability interface `STAB_G+`.

This establishes an explicit assumption trade-off. The theorem remains frame-free when `STAB_G+` is primitive. If positive `G` stability is reconstructed from forward admissible positivity rigidity, symmetry re-enters precisely for the persistence direction. An exhaustive two-world / one-entity regression checks all 256 configurations over the negation-closed classical admissible domain `{T,F}` and retains separate countermodels showing that `RPlusAdm` without symmetry need not force persistence and symmetry without `RPlusAdm` need not force reflection.

### New in `paper-v0.15`: converse positivity transport

The persistence proof is sharpened by isolating `RPlusConverseAdm`: target positivity is transported back to the source along an existing accessibility edge, without requiring the converse edge. Lean proves that this condition directly yields positive `G` persistence. Together with forward `RPlusAdm`, it yields the complete positive stability interface and the minimized de-dicto theorem without a frame premise.

The exhaustive two-world regression retains 112 bidirectional-transport candidates. Thirty-two of them are asymmetric, so global accessibility symmetry is strictly stronger than the property-level transport used by the proof in this bounded family.

### New in `paper-v0.16`: visual Gate-7 countermodel

The finite-model section now includes a generated Kripke graph for the first (A1_L)-drop countermodel. The figure is produced by `formal/finite/visualize_gate7_models.py` from the same matrix generator used by the 873-model regression. Its two node tables expose every local FDE extension and positivity value together with the positive and negative support bits, while its arrows reproduce the model's accessibility relation.

The central manuscript thesis remains comparative: under involutive FDE negation the final signed collapse schemata are coupled, while decisive variation lies upstream in where positivity, reflection, necessary exemplification, property-domain quotient structure, actualist existence, and intension/extension stability are placed.

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

For formal validation of the newest manuscript claims:

```bash
cd ../formal/lean
lake build
```

## Status discipline

The manuscript distinguishes:

- `established`: follows from the fixed semantics or frozen classical baseline;
- `machine-checked`: accepted by the general Lean development or an executable named finite regression with an explicit bound;
- `open`: explicitly not yet settled;
- `conjectural`: a research hypothesis awaiting proof or countermodel.

No bounded finite search or fixture is promoted to an unbounded theorem. Exact higher-order correspondence with the frozen Scott/AFP control development and the published Anderson/Fitting formalizations remains part of the Gate-9 publication audit.
