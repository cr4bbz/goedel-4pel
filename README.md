# goedel-4pel

A research repository for a four-valued reconstruction and structural analysis of the Gödel–Scott ontological argument.

## Core question

> What becomes of the Gödel–Scott system when positivity, modal status, and derivability are interpreted in a four-valued bilateral semantics that admits both inconsistency and incompleteness?

The project is not intended to produce a "stronger proof of God". Its aim is logical: to use the Gödel–Scott theory as a tightly studied test case for four-valued modal reasoning, and to identify exactly which classical assumptions drive existence results, positivity rigidity, and modal collapse.

## Primary research target

The most promising target is a decomposition of classical modal collapse into independent positive and negative information channels.

Classically, one studies a schema of the form

```text
φ → □φ
```

In a bilateral four-valued semantics we instead ask whether the following can separate:

```text
MC+ : positive support for φ  => positive support for □φ
MC- : negative support for φ  => negative support for □φ
```

Likewise, the classical rigidity axiom for positivity

```text
P(φ) → □P(φ)
```

may conceal more than one independent persistence principle.

## Working hypotheses

1. **H1 — Collapse decomposition.** Classical modal collapse decomposes into at least two non-equivalent bilateral collapse principles.
2. **H2 — Rigidity sensitivity.** These collapse principles depend differently on positive and negative rigidity of the positivity predicate.
3. **H3 — Non-trivial inconsistency tolerance.** Some inconsistent positivity assignments can be tolerated without trivializing the Gödel–Scott theory.
4. **H4 — Gap/glut asymmetry.** Incomplete positivity information and inconsistent positivity information affect Godlikeness, possibility, essence, and necessary existence in importantly different ways.
5. **H5 — Classical recovery.** Under suitable consistency/completeness constraints, the four-valued system recovers a chosen classical Gödel–Scott baseline.

## Methodological rule

No theorem is treated as "the four-valued Gödel theorem" until all of the following are fixed explicitly:

- truth/information values and designated values;
- propositional connectives and consequence;
- modal semantics;
- quantification over individuals and properties;
- semantics of the positivity predicate `P`;
- the exact lifting of each Gödel–Scott axiom;
- the chosen classical baseline used for recovery/comparison.

This is important because there is no unique way to lift a classical higher-order modal theory into a four-valued setting.

## Research gates

### Gate 0 — Baseline and notation
Freeze one exact Gödel–Scott baseline and write every definition and axiom in a machine-oriented normal form.

**Exit criterion:** an unambiguous baseline document with `P`, `G`, `Ess`, `NE`, `□`, `◇`, and the target theorems.

### Gate 1 — Four-valued kernel
Specify the four values as independent positive/negative information and define negation, conjunction, disjunction, implication/consequence, and designatedness.

**Exit criterion:** truth/information tables plus classical-recovery lemmas for the two classical values.

### Gate 2 — Modal lift
Define the four-valued semantics of `□` and `◇`. Compare a relational baseline with the project's preferred neighborhood-style formulation before committing to one.

**Exit criterion:** explicit positive and negative satisfaction clauses, duality results or documented failures, and small countermodels.

### Gate 3 — Positivity lift
Treat `P(φ)` itself as four-valued. Enumerate non-equivalent liftings of the Gödel–Scott positivity axioms instead of silently translating `→` and `↔`.

**Exit criterion:** an axiom matrix showing which liftings are conservative, stronger, weaker, or independent.

### Gate 4 — Collapse experiment
Define `MC+` and `MC-`, split positivity rigidity into bilateral components, and search for the minimal combinations that force each collapse principle.

**Exit criterion:** theorem/countermodel table for every rigidity/collapse combination.

### Gate 5 — Godlikeness and possibility
Lift `G(x)` and the theorem that positive properties are possibly exemplified. Determine how `T/F/B/N` statuses propagate into `◇∃x G(x)`.

**Exit criterion:** state-transition classification for Godlikeness and possible exemplification.

### Gate 6 — Essence and necessary existence
Only after Gates 1–5 are stable, lift `Ess` and `NE` and study `□∃x G(x)`.

**Exit criterion:** exact preservation/failure results for the standard Gödel–Scott theorem chain.

### Gate 7 — Mechanization
Formalize the settled system in Lean and add finite-model/countermodel tooling where useful.

**Exit criterion:** machine-checked core definitions, recovery theorems, key preservation results, and independent countermodels for failed claims.

### Gate 8 — Comparative variants
Compare Scott with selected Anderson/Fitting-style variants under the same four-valued semantics.

**Exit criterion:** a comparative table explaining which classical repairs remain repairs in the four-valued setting.

### Gate 9 — Paper
Turn the strongest structural result into a paper. The target is not "Gödel in four values" but a precise theorem about bilateral rigidity, collapse, and/or inconsistency tolerance.

## Repository layout

```text
.
├── README.md
├── ROADMAP.md
├── docs/
│   ├── RESEARCH_PROGRAM.md
│   ├── AXIOM_MATRIX.md
│   └── CONJECTURES.md
├── formal/
│   └── README.md
└── .github/
    └── ISSUE_TEMPLATE/
        └── research-result.md
```

## Non-goals for the first phase

- epistemic/belief operators;
- theological evaluation of the conclusion;
- immediate formalization of every Gödel variant;
- treating all possible four-valued implications as interchangeable;
- claiming novelty before a dedicated literature review is complete.

The belief operator is deliberately postponed. Four-valued modality and four-valued positivity already create enough structure for a first paper-sized problem.

## Status

**Phase:** research design / Gate 0.

The next concrete task is to freeze the exact Scott baseline and complete the first version of `docs/AXIOM_MATRIX.md`.
