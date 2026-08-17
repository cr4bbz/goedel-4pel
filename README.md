# goedel-4pel

A research repository for a four-valued reconstruction and structural analysis of the Gödel–Scott ontological argument.

## Core question

> What becomes of the Gödel–Scott system when positivity, modal status, and derivability are interpreted in a four-valued bilateral semantics that admits both inconsistency and incompleteness?

The project is not intended to produce a "stronger proof of God". Its aim is logical: to use the Gödel–Scott theory as a tightly studied test case for four-valued modal reasoning and to identify exactly which classical assumptions drive positivity rigidity, reflection, existence results, and modal collapse.

## Current research thesis

The project originally asked whether modal collapse itself decomposes into independent positive and negative persistence principles. Gate 4 falsifies that conjecture for the current FDE semantics.

The informative collapse schemata are:

```text
MC+ : +φ => +□φ
MC- : -φ => +□¬φ
```

Because FDE negation is involutive and the schemata range over all formulas:

```text
MC+ <-> MC-
```

So the non-classical decomposition occurs **upstream of modal collapse**.

The strongest current structural picture is:

```text
A1 directions               independent
        ↓
positivity rigidity          independent without A1
        ↓                    coupled by strong A1
G + Z -> P(Z) reflection     fails by distinct glut/gap mechanisms
        ↓
classical recovery bridge    needs explicit regularity assumptions
        ↓
modal collapse               recoupled by FDE negation
```

## Current semantic stack

### Gate 0 — Scott baseline

Frozen in `docs/SCOTT_BASELINE.md` and analyzed in `docs/MODAL_COLLAPSE_SPINE.md`.

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

Scott A1 decomposes into two independent directional clauses:

```text
A1-L : -P(φ)  => +P(¬φ)
A1-R : +P(¬φ) => -P(φ)
```

Strong A1 is their conjunction and induces:

```text
v(P(¬φ)) = swap(v(P(φ)))
```

The direct A4 lifting is:

```text
R+ : +P(φ) => +□P(φ)
```

Informative universal negative rigidity is:

```text
R-nec- : -P(φ) => +□¬P(φ)
```

The old candidates `-P => -□P` and `-φ => -□φ` are retired because they follow automatically on reflexive frames.

### Gate 4 — Collapse experiment

Frozen as `collapse-v0.1` in `docs/COLLAPSE_EXPERIMENT.md`.

Gate 4 establishes:

1. **Collapse-channel equivalence**
   ```text
   MC+ <-> MC-
   ```
   under the fixed FDE negation.

2. **Rigidity independence without A1**
   ```text
   R+  does not imply  R-nec-
   R-nec-  does not imply  R+
   ```
   with two-world S5 countermodels.

3. **Rigidity coupling under strong A1**
   ```text
   A1-L + A1-R  =>  (R+ <-> R-nec-)
   ```

4. **Local reflection obstruction**

   The classical bridge
   ```text
   G(x), Z(x) => P(Z)
   ```
   does not survive the minimal four-valued lift. Gluts and gaps block it for different reasons.

5. **Locally minimal reflection-recovery package**
   ```text
   A1-L
   + D1+
   + CONS_G
   + COMP_P
   ---------
   REF+
   ```
   where each member is individually indispensable relative to the other three at the abstract interface.

6. **Conditional interface-level collapse package**
   ```text
   A1-L
   + D1+
   + CONS_G
   + COMP_P
   + R+
   + GW
   + CONST
   ---------
   MC+  and therefore MC-
   ```

`D1+`, `GW`, and `CONST` are explicitly temporary interfaces, not yet axioms of the final four-valued Gödel–Scott theory.

## Working hypotheses after Gate 4

1. **H1 — Upstream decomposition.** The informative four-valued structure lies in positivity-negation transfer, rigidity, reflection, and higher-order witness/property infrastructure rather than in a final split of modal collapse.
2. **H2 — A1 channel coupling.** Strong A1 recouples otherwise independent positivity-rigidity channels.
3. **H3 — Non-trivial inconsistency tolerance.** Some inconsistent positivity or exemplification assignments may be tolerated without trivializing the reconstructed theorem chain.
4. **H4 — Gap/glut asymmetry.** Incomplete and inconsistent information obstruct Gödel–Scott reasoning in structurally different ways.
5. **H5 — Classical recovery.** Suitable restrictions should recover the frozen Scott baseline.
6. **H6 — Interface refinement.** The full reconstruction may derive or weaken `CONS_G`, `COMP_P`, `GW`, or `CONST` rather than requiring them as primitive assumptions.

## Methodological rule

No theorem is treated as "the four-valued Gödel theorem" until all of the following are fixed explicitly:

- truth/information values and designated values;
- propositional connectives and consequence;
- modal semantics;
- quantification over individuals and properties;
- semantics of the positivity predicate `P`;
- the exact lifting of each Gödel–Scott axiom;
- the chosen classical baseline used for recovery/comparison.

Failed conjectures are retained as results rather than rescued by changing the semantics after the fact.

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
Next: lift A2 and A3, freeze the final four-valued `G(x)`, define the required quantifier/consequence interfaces, and classify possible exemplification. In particular, test whether `D1+`, `GW`, and `CONST` are justified or must be replaced.

### Gate 6 — Essence and necessary existence
Lift `Ess` and `NE` and classify the status of `□∃x G(x)`.

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
paper-v0.4
```

It contains the defensible Gate 0–4 material. Later sections remain explicit about unresolved higher-order choices.

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

**Phase:** Gate 4 complete at the semantic/interface-analysis level; `paper-v0.4` synchronized; Gate 5 next.

The next concrete task is to lift A2/A3 and freeze the four-valued Godlikeness/possible-exemplification layer while testing whether the Gate-4 interfaces arise naturally or require revision.
