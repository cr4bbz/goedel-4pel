# goedel-4pel

A research repository for a four-valued reconstruction and structural analysis of the Gödel–Scott ontological argument.

## Core question

> What becomes of the Gödel–Scott system when positivity, modal status, essence, and derivability are interpreted in a four-valued bilateral semantics that admits both inconsistency and incompleteness?

The project is not intended to produce a "stronger proof of God". Its aim is logical: use the Gödel–Scott theory as a tightly studied test case for four-valued modal reasoning and identify which classical assumptions drive positivity, possible exemplification, essence, necessary existence, and modal collapse.

## Current research thesis

The original conjecture that modal collapse itself might decompose into independent positive and negative channels is false for the current symmetric FDE semantics:

```text
MC+ : +φ => +□φ
MC- : -φ => +□¬φ
MC+ <-> MC-
```

The informative non-classical structure occurs **upstream**.

After Gate 6 the strongest dependency picture is:

```text
A1-R + A2+ + A3-T
          |
          v
      +◇∃ᴱx G(x)

A1-L + R+ + REG_G + G-sup
          |
          v
          T2+

A5+ + T2+ + NE-sup + S5
          |
          v
          T3+
          |
          v
          GW

T2+ + T3+ + CONST
          |
          v
          MC+
          |
      FDE negation
          v
          MC-
```

The decisive open semantic question is now:

> **What are the weakest principled four-valued conditions under which positive Godlikeness-as-essence (`T2+`) follows?**

Gate 7 has begun to turn this dependency picture into executable regressions and Lean theorems. The first combined finite-model/Lean CI milestone is green.

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

The kernel is FDE-style, paraconsistent, paracomplete, and classically recoverable. No object-language four-valued implication is fixed.

### Gate 2 — Modal lift

Frozen as `modal-v0.1` in `docs/MODAL_LIFT.md`.

```text
+□φ : every accessible world positively supports φ
-□φ : some accessible world negatively supports φ
+◇φ : some accessible world positively supports φ
-◇φ : every accessible world negatively supports φ
```

The control semantics is relational S5, with a paired-neighborhood representation retained for later comparison.

### Gate 3 — Positivity decomposition

Frozen as `positivity-v0.1` in `docs/POSITIVITY_LIFT.md`.

```text
A1-L : -P(φ)  => +P(¬φ)
A1-R : +P(¬φ) => -P(φ)
R+    : +P(φ) => +□P(φ)
```

The A1 directions are independent. Strong A1 recouples positive and universal-negative positivity rigidity.

### Gate 4 — Collapse experiment

Frozen as `collapse-v0.1` in `docs/COLLAPSE_EXPERIMENT.md`.

Main results:

- `MC+ <-> MC-` under involutive FDE negation;
- finite S5 countermodels separate rigidity channels without A1;
- the classical `G + Z -> P(Z)` bridge fails through distinct glut and gap mechanisms;
- a local consistency/completeness package recovers that reflection route.

### Gate 5 — Godlikeness and possibility

Frozen as `godlike-v0.1` in `docs/GODLIKENESS_AND_POSSIBILITY.md`.

Gate 5 introduces bilateral actualist quantifiers and semantic necessary positive entailment:

```text
A2+ : +P(φ) and NEnt+_E(φ,ψ) => +P(ψ)
Pos_T(φ) := +P(φ) and not(-P(φ))
A1-R + A2+ => T1-T
T1-T : Pos_T(φ) => +◇∃ᴱx φ(x)
```

A positivity glut refutes the unrestricted `+P -> +◇∃ᴱ` version.

The Scott-control A3 is:

```text
A3-T : Pos_T(G)
```

yielding positive possible God-like existence.

The control Godlikeness definition is:

```text
+G(x) iff every +P(φ) is +φ(x)
-G(x) iff some +P(φ) is -φ(x)
```

This is `G-sup-v0.1` and recovers Scott D1 classically.

### Gate 6 — Essence and necessary existence

Frozen as `essence-ne-v0.1` in `docs/ESSENCE_AND_NECESSARY_EXISTENCE.md`.

Gate 6 defines:

```text
NEnt-_E(φ,ψ): some accessible actual +φ-instance is -ψ
```

and bilateral control semantics for essence and necessary existence:

```text
Ess-sup-v0.1
NE-sup-v0.1
```

Both recover Scott D2/D3 on the `T/F` fragment.

#### T2 is the bottleneck

```text
T2+ : +G(x) => +Ess(G,x)
```

is **not automatic**. Two explicit two-world S5 models satisfy the Gate-5 control stack plus strong A1 and `R+` while refuting T2:

- a glut model, where a locally possessed property is inconsistently exemplified and not necessarily shared;
- a gap model, where positivity gives no information capable of forcing necessary sharing.

A sufficient recovery route is:

```text
COMP_P^G : relevant positivity completeness
CONS_G^G : relevant exemplification consistency
REG_G    : COMP_P^G + CONS_G^G

A1-L + R+ + G-sup-v0.1 + REG_G => T2+
```

`REG_G` is sufficient, not claimed globally necessary.

#### T3 and GW

For A5 distinguish:

```text
A5+ : +P(NE)
A5-T : Pos_T(NE)
```

Only `A5+` is needed for the positive T3 branch once a positive God-like witness exists.

```text
possible +G
+ T2+
+ A5+
+ NE-sup
+ S5
--------
T3+ : +□∃ᴱx G(x)
```

On reflexive S5 frames:

```text
T3+ => GW
```

so Gate 6 discharges the global witness interface.

#### Essence-compressed modal collapse

```text
T2+ + T3+ + CONST => MC+
MC+ <-> MC-
```

Thus once T2 and T3 are available, modal collapse follows without separately assuming the earlier reflection package.

Gate 6 also shows a concrete inconsistency-tolerance pattern: `P(NE)=B` can survive the positive T3 branch.

### Gate 7 — Mechanization and finite-model verification

Gate 7 is **in progress** with two complementary verification tracks.

#### Finite-model oracle

`formal/finite/` now contains a standard-library-only Python checker and regression suite. The first milestone machine-checks:

- both Gate-6 two-world T2 countermodels;
- the glut/gap split of `CONS_G^G` versus `COMP_P^G`;
- schema-level `MC+ <-> MC-` on all 16 valuations of a negation-closed two-world formula family;
- `REG_G => T2+` over the complete currently generated two-world / one-entity `G,Z` search space, with 204 retained antecedent models and no T2 failure.

The 204-model result is explicitly bounded evidence, not a general proof.

#### Lean layer

`formal/lean/` is pinned to Lean 4.30.0 and currently formalizes:

- the four-valued carrier `T/F/B/N`;
- involutive FDE negation;
- positive and negative support;
- the general schema-level theorem `MC+ <-> MC-` under bilateral involutive negation.

GitHub Actions runs both the finite-model regressions and `lake build`. The first combined Gate-7 CI milestone is green.

The next formal target is the general Lean proof of the Gate-6 T2 recovery theorem after relational modality, actualist quantification, `NEnt+_E`, `G-sup`, and `Ess-sup` have been encoded.

## Working hypotheses after Gate 6

1. **H1 — T2 minimality.** Two distinct informational controls corresponding to glut and gap failure modes are likely needed to derive `T2+`, but the current `REG_G` package may be stronger than necessary.
2. **H2 — A1 division of labor.** `A1-R` controls possible exemplification; `A1-L` controls the sufficient essence-recovery route.
3. **H3 — Non-trivial inconsistency tolerance.** Glutty positivity, essence, or necessary existence can coexist with positive theorem components without explosion.
4. **H4 — Gap/glut asymmetry.** Incompleteness and inconsistency obstruct the reconstructed chain at different locations and by different mechanisms.
5. **H5 — Classical recovery.** The settled semantics should recover the frozen Scott chain end-to-end on `T/F` valuations.
6. **H6 — Upstream decomposition.** The main non-classical structure lies before T2/T3; the final collapse schemata are recoupled by FDE negation.

## Research gates

### Gates 0–6

Complete at the current semantic-design / reconstruction level.

### Gate 7 — Mechanization and finite-model verification

**In progress. First executable milestone complete and green.**

Next:

- formalize relational bilateral modality, actualist quantification, and `NEnt+_E` in Lean;
- formalize `G-sup-v0.1` and `Ess-sup-v0.1`;
- prove `A1-L + R+ + G-sup + REG_G => T2+` generally in Lean;
- machine-check `T1-T` and its glut countermodel;
- formalize conditional T3, `T3+ => GW`, and essence-compressed modal collapse;
- verify classical recovery end-to-end;
- search systematically for weaker substitutes for `COMP_P^G` and `CONS_G^G`.

### Gate 8 — Comparative variants

Compare `G-sup` with `G-exact`, selected Anderson/Fitting variants, weaker modal frames, and later paired-neighborhood semantics.

### Gate 9 — Publication consolidation

Run a dedicated prior-art search, finalize mechanized dependency/minimality claims, and turn the strongest verified structural theorem into a publication-ready paper.

## Paper workspace

The living LaTeX manuscript is in `paper/`.

Current version:

```text
paper-v0.6
```

Gate 7 is being recorded in the mechanization section while the manuscript version remains 0.6 until the gate produces a larger theorem-level milestone.

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
│   ├── ESSENCE_AND_NECESSARY_EXISTENCE.md
│   └── MODAL_COLLAPSE_SPINE.md
├── formal/
│   ├── README.md
│   ├── finite/
│   │   ├── checker.py
│   │   └── test_checker.py
│   └── lean/
│       ├── lean-toolchain
│       ├── lakefile.lean
│       ├── lake-manifest.json
│       ├── Goedel4PEL.lean
│       └── Goedel4PEL/
├── paper/
│   ├── main.tex
│   ├── references.bib
│   ├── README.md
│   ├── sections/
│   └── figures/
└── .github/
    ├── workflows/
    │   └── formal.yml
    └── ISSUE_TEMPLATE/
        └── research-result.md
```

## Non-goals for the first phase

- theological evaluation of the conclusion;
- changing semantics merely to preserve failed conjectures;
- treating four-valued implication choices as interchangeable;
- claiming novelty before a dedicated literature review and mechanization are complete.

## Status

**Phase:** Gate 7 in progress; first finite-model + Lean CI milestone green; `paper-v0.6` remains the current manuscript version.
