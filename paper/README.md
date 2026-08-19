# Paper workspace

This directory contains the living manuscript for `goedel-4pel`.

## Current status

**Version:** `paper-v0.20`

**Compiled manuscript:** [`main.pdf`](main.pdf)

**Research gates represented:** Gates 0–12; the comparative Gate-8 branch remains active

**Newest research milestone:** `fitting-delta-filter-v0.1` / `paper-v0.20`

**Next manuscript dependency:** selected higher-order paired-neighborhood transport theorems, filter-strength analysis for the essence/NE route, and the remaining line-by-line Gate-9 source audit

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
- an explicit actualist entity quotient, bilateral extension push/pull equivalences, and quotient-level entailment;
- prime and non-adjunctive four-valued delta-filter candidates on the quotient algebra;
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

**Verification status:** the finite entailment regressions and the root-imported Lean theorem block are validated by Lean CI; the publication-correspondence signature gate is compiled through the root import.

### New in `paper-v0.17`: explicit actualist profile quotient

The Lean development now constructs `ProfileQuotient M w`, the quotient of entities by positive admissible-property profiles at the source world. Every bilateral extension on quotient classes pulls back to a profile-respecting entity extension, and every profile-respecting extension pushes forward; both round trips are proved up to bilateral extensional equivalence.

The earlier compatibility premise is characterized exactly: `ProfileExistenceSaturatedAdm` holds iff actual existence at every accessible target factors through the corresponding source quotient. Under this condition, actualist entailment evaluated directly on quotient classes is equivalent to ordinary entailment between pullbacks. A finite regression checks all 16 saturated bilateral extensions and all 256 ordered entailment comparisons, preserves both `B` and `N`, and confirms that split existence blocks factorization.

### New in `paper-v0.18`: quotient delta-filters

The quotient extension algebra now carries a truth-order delta-filter definition with a verified classical boundary. Lean proves that point evaluation is a proper prime delta-filter which designates `B` while leaving `N` and its negation undesignated. Primeness therefore does not entail complement decision in the four-valued algebra.

The exhaustive two-point audit finds 166 proper upsets, 15 ordinary delta-filters, 4 prime delta-filters, 112 proper two-filters, and 10 prime two-filters. Every prime ordinary filter is non-deciding. A non-prime ordinary filter additionally supplies two non-vacuous Godlike points and a possessed extension for which local `COMP` fails.

### New in `paper-v0.20`: fixed-point delta-filter, property domain, correspondence appendix

Section `08d_fitting_delta_filter.tex` lifts the classical extensional `delta`-filter to the admissible fixed-point algebra, in the FDE truth order rather than the information order used by the profile hull. Lean derives both admissible A1 directions and the dual-ideal laws for negative positivity support, and proves that the filter notion coincides with the source-style positive-set filter on the classically coherent fragment. Ultrafilter maximality is kept separate: it is exactly complement decision and therefore returns to the classification route, while a 12-element finite witness with genuine gaps and gluts satisfies the filter plus relevant consistency without `COMP`.

Section `05_positivity.tex` now states the Scott-branch property domain explicitly. Properties form an arbitrary type with primitive signed exemplification, signed positivity, a negation operation, and a distinguished `G`; no comprehension principle is assumed. Involutivity of property negation is flagged as an additional assumption used by the substitution arguments but not by the mechanized `T1-T` and `T2+` theorems.

Appendix A maps every "Lean proves ..." claim to the declaration that discharges it and every bounded count to its fixture. Building it corrected two premise lists that were incomplete relative to Lean.

### New in `paper-v0.19`: paired-neighborhood bridge

The previously semantic paired-neighborhood representation is now machine-checked. Lean proves all four clauses, bilateral box/diamond duality, exact relational embedding, complement duality of relational pairs, and classical recovery for arbitrary complement-dual frames.

The bounded two-world audit exhausts all 256 local universal/hit family pairs. Sixteen are complement-dual, four are principal relational, and twelve are genuinely non-principal while retaining classical modal bivalence. Across arbitrary non-dual frames, classical inputs realize `T`, `F`, `B`, and `N`. The v1 synthesis document records which results are general theorems, bounded audits, explicit witnesses, or still-open publication dependencies.

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

## Formal correspondence appendix

`sections/A_formal_correspondence.tex` maps every "Lean proves ..." claim in the manuscript to the named declaration that discharges it, and every bounded count to the fixture that produces it. Where the prose abbreviates a premise list as a "stack", the Lean signature named there is the authoritative statement.

The appendix rots silently if a declaration is renamed, so it is checkable:

```bash
python paper/check_correspondence.py
```

The script resolves every identifier in the appendix against the actual Lean and Python sources and reports any that no longer exist. It currently checks 136 identifiers and runs in the dedicated CI correspondence job. The machine-readable `paper/correspondence_manifest.json` records all 68 appendix claims, their 136 references, and whether each claim is a general Lean result or bounded finite evidence. The root-imported `Goedel4PEL.PublicationCorrespondence` module additionally compiles exact premise/conclusion signatures for seven selected theorem-level claims.

## Status discipline

The manuscript distinguishes:

- `established`: follows from the fixed semantics or frozen classical baseline;
- `machine-checked`: accepted by the general Lean development or an executable named finite regression with an explicit bound;
- `open`: explicitly not yet settled;
- `conjectural`: a research hypothesis awaiting proof or countermodel.

No bounded finite search or fixture is promoted to an unbounded theorem. Gate 9 now includes a reproducible first prior-art pass and source-correspondence matrix; exact line-by-line higher-order correspondence with the frozen Scott/AFP control development and the complete Anderson/Fitting formalizations remains open.
