# goedel-4pel

A research repository for a four-valued reconstruction and structural analysis of the Gödel–Scott ontological argument.

## Core question

> What becomes of the Gödel–Scott system when positivity, modal status, and derivability are interpreted in a four-valued bilateral semantics that admits both inconsistency and incompleteness?

The project is not intended to produce a "stronger proof of God". Its aim is logical: to use the Gödel–Scott theory as a tightly studied test case for four-valued modal reasoning and to identify exactly which classical assumptions drive positivity rigidity, reflection, existence results, and modal collapse.

## Current research thesis

The project originally asked whether modal collapse itself decomposes into independent positive and negative persistence principles. Gate 4 falsifies that conjecture for the current FDE semantics:

```text
MC+ : +φ => +□φ
MC- : -φ => +□¬φ
MC+ <-> MC-
```

because FDE negation is involutive and the schemata range over all formulas.

The non-classical decomposition therefore occurs **upstream of modal collapse**.

Gate 5 sharpens that thesis further. The two directions of A1 now have visibly different proof-theoretic jobs:

```text
A1-R -> truth-only possible exemplification (T1-T)
A1-L -> local G+Z -> P(Z) reflection (REF+)
```

and positive support must be distinguished from truth-only positivity when gluts are allowed.

## Current semantic stack

### Gate 0 — Scott baseline

Frozen in `docs/SCOTT_BASELINE.md` and structurally analyzed in `docs/MODAL_COLLAPSE_SPINE.md`.

### Gate 1 — Four-valued kernel

Frozen as `kernel-v0.1` in `docs/FOUR_VALUED_KERNEL.md`:

```text
T = (1,0)
F = (0,1)
B = (1,1)
N = (0,0)
```

The kernel uses FDE-style negation, conjunction, disjunction, positive semantic consequence, paraconsistency, paracompleteness, and classical recovery. No object-language four-valued implication is fixed.

### Gate 2 — Modal lift

Frozen as `modal-v0.1` in `docs/MODAL_LIFT.md`.

The bilateral relational control semantics is:

```text
+□φ : every accessible world positively supports φ
-□φ : some accessible world negatively supports φ
+◇φ : some accessible world positively supports φ
-◇φ : every accessible world negatively supports φ
```

It preserves box/diamond duality, recovers classical Kripke semantics on the `T/F` fragment, and admits an exact paired-neighborhood representation.

### Gate 3 — Positivity decomposition

Frozen as `positivity-v0.1` in `docs/POSITIVITY_LIFT.md`.

Scott A1 decomposes into:

```text
A1-L : -P(φ)  => +P(¬φ)
A1-R : +P(¬φ) => -P(φ)
```

The direct A4 lifting is:

```text
R+ : +P(φ) => +□P(φ)
```

and informative universal negative rigidity is:

```text
R-nec- : -P(φ) => +□¬P(φ)
```

Without A1, these rigidity channels are independent. Strong A1 makes them interderivable.

### Gate 4 — Collapse experiment

Frozen as `collapse-v0.1` in `docs/COLLAPSE_EXPERIMENT.md`.

Main results:

1. corrected `MC+` and `MC-` are equivalent under FDE negation;
2. the rigidity channels separate without A1 and recouple under strong A1;
3. the classical local reflection bridge
   ```text
   G(x), Z(x) => P(Z)
   ```
   fails by distinct glut and gap mechanisms;
4. the locally minimal recovery package is
   ```text
   A1-L + D1+ + CONS_G + COMP_P => REF+
   ```
5. adding `R+ + GW + CONST` yields an interface-level derivation of modal collapse.

### Gate 5 — Godlikeness and possibility

Frozen as `godlike-v0.1` in `docs/GODLIKENESS_AND_POSSIBILITY.md`.

Gate 5 introduces bilateral actualist quantifier clauses while keeping the existence relation classical at the metalanguage level, and defines semantic necessary positive entailment:

```text
NEnt+_E(φ,ψ,w):
  at every accessible world,
  every actually existing +φ-instance is a +ψ-instance
```

The A2 control lifting is:

```text
A2+ : +P(φ) and NEnt+_E(φ,ψ) => +P(ψ)
```

Define truth-only positivity:

```text
Pos_T(φ) := +P(φ) and not(-P(φ))
```

Then Gate 5 proves:

```text
A1-R + A2+ => T1-T
T1-T : Pos_T(φ) => +◇∃ᴱx φ(x)
```

Mere `+P(φ)` does not suffice: a one-world S5 model with an empty actual domain and glutty positivity assignments satisfies the relevant A1/A2 support conditions while positive possible exemplification fails.

A3 therefore splits into:

```text
A3+ : +P(G)
A3-T : Pos_T(G)
```

The Scott-control branch adopts `A3-T`, yielding:

```text
+◇∃ᴱx G(x)
```

without globally banning positivity gluts.

The control Godlikeness definition is `G-sup-v0.1`:

```text
+G(x) iff every +P(φ) is +φ(x)
-G(x) iff some +P(φ) is -φ(x)
```

It recovers Scott D1 on the classical fragment and permits `T/F/B/N` statuses for Godlikeness.

### Gate-4 interface audit after Gate 5

```text
D1+    discharged by G-sup-v0.1
CONST  discharged by full property comprehension / lambda abstraction
GW     not discharged; only possible God-like existence is proved
COMP_P not implied; strong A1 preserves N/N positivity gaps
CONS_G not implied by support-based Godlikeness
```

Thus reconstructing A2, A3, and Godlikeness does **not** yet reconstruct modal collapse.

## Working hypotheses after Gate 5

1. **H1 — Upstream decomposition.** The informative four-valued structure lies in positivity-negation transfer, rigidity, truth-only versus glutty positivity, reflection, and higher-order witness supply.
2. **H2 — A1 division of labor.** `A1-R` controls the T1 branch while `A1-L` controls the local reflection branch.
3. **H3 — Non-trivial inconsistency tolerance.** Positivity gluts may remain in the theory even though Scott-style possible exemplification is restricted to truth-only positive properties.
4. **H4 — Gap/glut asymmetry.** Incomplete and inconsistent information obstruct the proof chain differently.
5. **H5 — Classical recovery.** Suitable `T/F` restrictions recover each frozen Scott fragment.
6. **H6 — Necessary-existence witness recovery.** A natural Gate-6 lift may or may not provide the global witness interface `GW`; this is the next decisive test.

## Methodological rule

No theorem is treated as "the four-valued Gödel theorem" until all relevant semantic and higher-order choices have been made explicit. Failed conjectures are retained as results rather than rescued by changing the semantics after the fact.

## Research gates

### Gate 0 — Baseline and notation
Complete at the semantic-design level.

### Gate 1 — Four-valued kernel
Complete at the semantic-design level.

### Gate 2 — Modal lift
Complete at the semantic-design level.

### Gate 3 — Positivity lift
Complete at the semantic-design level.

### Gate 4 — Collapse experiment
Complete at the semantic/interface-analysis level.

### Gate 5 — Godlikeness and possibility
Complete at the semantic-reconstruction level.

### Gate 6 — Essence and necessary existence
Next: lift `Ess`, `NE`, and A5; reconstruct or refute a four-valued T2/T3 branch; determine whether the resulting necessary-existence theorem is strong enough to discharge `GW` and whether it affects `CONS_G` or `COMP_P`.

### Gate 7 — Mechanization
Formalize the settled system in Lean and machine-check the finite models/countermodels.

### Gate 8 — Comparative variants
Compare Scott with selected Anderson/Fitting-style variants and later vary the modal frame / paired-neighborhood class.

### Gate 9 — Paper
Turn the strongest structural result into a publication-ready paper.

## Paper workspace

A living LaTeX manuscript lives in `paper/`.

Current version:

```text
paper-v0.5
```

It contains the defensible Gate 0–5 material.

Build from `paper/` with:

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
│   ├── COLLAPSE_EXPERIMENT.md
│   ├── GODLIKENESS_AND_POSSIBILITY.md
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
- changing the semantics merely to preserve a failed conjecture;
- claiming novelty before a dedicated literature review is complete.

## Status

**Phase:** Gate 5 complete at the semantic-reconstruction level; `paper-v0.5` synchronized; Gate 6 next.
