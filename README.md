# goedel-4pel

A research repository for a four-valued reconstruction and structural analysis of the Gödel–Scott ontological argument.

## Core question

> What becomes of the Gödel–Scott system when positivity, modal status, and derivability are interpreted in a four-valued bilateral semantics that admits both inconsistency and incompleteness?

The project is not intended to produce a "stronger proof of God". Its aim is logical: to use the Gödel–Scott theory as a tightly studied test case for four-valued modal reasoning, and to identify exactly which classical assumptions drive existence results, positivity rigidity, and modal collapse.

## Primary research target

The central target is a decomposition of classical modal collapse into informative positive and negative persistence channels.

Classically:

```text
φ → □φ
```

Under the fixed bilateral modal semantics the meaningful targets are:

```text
MC+ : +φ => +□φ
MC- : -φ => +□¬φ
```

with `MC-` equivalently expressible as:

```text
-φ => -◇φ
```

The superficially tempting clause `-φ => -□φ` is **not** used: on reflexive frames it follows automatically and therefore does not express universal negative persistence.

Likewise, Scott's positivity axioms are decomposed by information flow rather than translated syntactically.

## Working hypotheses

1. **H1 — Collapse separation.** Corrected `MC+` and `MC-` may separate under a natural four-valued Gödel–Scott lift.
2. **H2 — A1 channel coupling.** The two directional components of A1 play asymmetric roles in coupling the positive and negative persistence channels.
3. **H3 — Non-trivial inconsistency tolerance.** Some inconsistent positivity assignments can be tolerated without trivializing the Gödel–Scott theory.
4. **H4 — Gap/glut asymmetry.** Incomplete and inconsistent positivity information obstruct the classical proof spine in structurally different ways.
5. **H5 — Classical recovery.** Under suitable consistency/completeness constraints, the four-valued system recovers the chosen classical Gödel–Scott baseline.

## Current semantic stack

### Gate 0 — Scott baseline

Frozen in `docs/SCOTT_BASELINE.md` and analyzed structurally in `docs/MODAL_COLLAPSE_SPINE.md`.

### Gate 1 — Four-valued kernel

Frozen as `kernel-v0.1` in `docs/FOUR_VALUED_KERNEL.md`:

```text
T = (1,0)
F = (0,1)
B = (1,1)
N = (0,0)
```

The kernel uses FDE-style negation, conjunction, disjunction, positive semantic consequence, paraconsistency, paracompleteness, and classical recovery. No object-language four-valued implication is fixed yet.

### Gate 2 — Modal lift

Frozen as `modal-v0.1` in `docs/MODAL_LIFT.md`.

The control semantics is a bilateral relational Kripke lift:

```text
+□φ : every accessible world positively supports φ
-□φ : some accessible world negatively supports φ
+◇φ : some accessible world positively supports φ
-◇φ : every accessible world negatively supports φ
```

It preserves box/diamond duality, recovers classical Kripke semantics on the `T/F` fragment, and admits an exact paired-neighborhood representation.

For Gates 3–4, the Scott S5 relational frame class remains fixed as a control variable.

### Gate 3 — Positivity decomposition

Frozen as `positivity-v0.1` in `docs/POSITIVITY_LIFT.md`.

Scott A1 is decomposed into two independent directional clauses:

```text
A1-L : -P(φ)  => +P(¬φ)
A1-R : +P(¬φ) => -P(φ)
```

Strong A1 is their conjunction and induces:

```text
v(P(¬φ)) = swap(v(P(φ)))
```

so `T/F` are exchanged while `B/N` are preserved.

The direct A4 lifting is:

```text
R+ : +P(φ) => +□P(φ)
```

The old candidate `-P(φ) => -□P(φ)` is retired as reflexively trivial. Informative negative rigidity is:

```text
R-nec- : -P(φ) => +□¬P(φ)
```

and Gate 3 establishes:

```text
A1-L + A1-R + R+ => R-nec-
```

Thus strong A1 already acts as a channel coupler.

Gate 3 also shows that even strong A1 plus a minimal `D1+` support interface does not recover the classical local step

```text
G(x), Z(x) => P(Z)
```

without additional consistency/completeness structure. Gluts and gaps obstruct this step in different ways.

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
Freeze the exact Scott control theory and its proof dependencies. **Complete at the semantic-design level.**

### Gate 1 — Four-valued kernel
Fix the FDE-style propositional kernel and classical recovery. **Complete at the semantic-design level.**

### Gate 2 — Modal lift
Fix the bilateral relational control semantics and paired-neighborhood representation. **Complete at the semantic-design level.**

### Gate 3 — Positivity lift
Decompose A1 and A4, correct the rigidity/collapse channels, and expose the local reflection obstruction. **Complete at the semantic-design level.**

### Gate 4 — Collapse experiment
Construct the minimal assumption lattice around A1, rigidity, positivity completeness, and consistency of relevant God-like exemplification. Determine which nodes force `MC+`, corrected `MC-`, both, or neither.

### Gate 5 — Godlikeness and possibility
Freeze the final four-valued `G(x)`, lift A2/A3, and classify possible exemplification.

### Gate 6 — Essence and necessary existence
Lift `Ess` and `NE` and classify the status of `□∃x G(x)`.

### Gate 7 — Mechanization
Formalize the settled system in Lean and add finite-model/countermodel tooling.

### Gate 8 — Comparative variants
Compare Scott with selected Anderson/Fitting-style variants and later vary the modal frame / paired-neighborhood class.

### Gate 9 — Paper
Turn the strongest structural result into a paper centered on a precise decomposition, coupling, obstruction, or robustness theorem.

## Paper workspace

A living LaTeX manuscript lives in `paper/`.

Current version:

```text
paper-v0.3
```

It contains the defensible Gate 0–3 material. Open later sections remain explicitly marked rather than pre-filled with assumed results.

Build from `paper/` with either:

```bash
latexmk -pdf main.tex
```

or the standard `pdflatex` / `bibtex` sequence documented in `paper/README.md`.

## Repository layout

```text
.
├── README.md
├── ROADMAP.md
├── docs/
│   ├── RESEARCH_PROGRAM.md
│   ├── AXIOM_MATRIX.md
│   ├── CONJECTURES.md
│   ├── SCOTT_BASELINE.md
│   ├── FOUR_VALUED_KERNEL.md
│   ├── MODAL_LIFT.md
│   ├── POSITIVITY_LIFT.md
│   └── MODAL_COLLAPSE_SPINE.md
├── formal/
│   └── README.md
├── paper/
│   ├── main.tex
│   ├── references.bib
│   ├── README.md
│   ├── sections/
│   └── figures/
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

## Status

**Phase:** Gate 3 complete at the semantic-design level; `paper-v0.3` synchronized; Gate 4 next.

The next concrete task is to construct the Gate-4 assumption lattice and search systematically for proofs and smallest countermodels for corrected `MC+` and `MC-`.
