# goedel-4pel

A research repository for a four-valued reconstruction and structural analysis of the Gödel–Scott ontological argument.

## Core question

> What becomes of the Gödel–Scott system when positivity, modal status, essence, and derivability are interpreted in a four-valued bilateral semantics that admits both inconsistency and incompleteness?

The project is not intended to produce a "stronger proof of God". Its aim is logical: use the Gödel–Scott theory as a controlled test case for four-valued modal reasoning and identify which assumptions drive possible exemplification, Godlikeness-as-essence, necessary existence, and modal collapse.

## Current thesis

The original conjecture that modal collapse separates into independent positive and negative channels is false for the present symmetric FDE semantics:

```text
MC+ : +phi => +Box phi
MC- : -phi => +Box not phi
MC+ <-> MC-
```

The informative non-classical structure occurs upstream.

For the support-based Scott control theory, the verified dependency spine is:

```text
A1-R + A2+ + A3-T
          |
          v
      +Diamond exists^E x G(x)

NegExemplification
+ G-sup
+ A1-L
+ R+
+ REG_G
          |
          v
          T2+

A5+ + T2+ + NE-sup + G-sup + S5
          |
          v
          T3+
          |
          v
          GW

T2+ + T3+ + G-sup + CONST
          |
          v
          MC+
          |
      FDE negation
          v
          MC-
```

The central support-theory question remains global T2 minimality: can the verified recovery package be weakened outside the bounded model families already searched?

Gate 8 now shows that the bottleneck is definition-sensitive along more than one axis:

```text
G-sup+:
  +P(phi) -> current +phi(x)

G-exact+:
  +P(phi) <-> current +phi(x)

Anderson G_A+:
  +P(phi) <-> necessary +phi(x) for the same individual
```

`G-exact+` internalizes local positive reflection. Anderson instead internalizes a modal persistence classification and simultaneously changes essence and necessary existence.

## Semantic stack

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

FDE-style, paraconsistent, paracomplete, classically recoverable. No object-language four-valued implication is fixed.

### Gate 2 — Modal lift

Frozen as `modal-v0.1` in `docs/MODAL_LIFT.md` with bilateral relational S5 control semantics.

### Gate 3 — Positivity decomposition

Frozen as `positivity-v0.1` in `docs/POSITIVITY_LIFT.md`:

```text
A1-L : -P(phi)     => +P(not phi)
A1-R : +P(not phi) => -P(phi)
R+   : +P(phi)     => +Box P(phi)
```

### Gate 4 — Collapse experiment

Frozen as `collapse-v0.1` in `docs/COLLAPSE_EXPERIMENT.md`.

Main result: corrected `MC+` and `MC-` are schema-equivalent under involutive FDE negation. Glut and gap countermodels isolate failures of the classical reflection mechanism.

### Gate 5 — Godlikeness and possibility

Frozen as `godlike-v0.1` in `docs/GODLIKENESS_AND_POSSIBILITY.md`.

```text
A1-R + A2+ => T1-T
T1-T : Pos_T(phi) => +Diamond exists^E x phi(x)
```

`G-sup-v0.1` defines positive Godlikeness by preservation of positively supported positive properties. An unrestricted `+P => +Diamond exists^E` theorem fails via a positivity glut.

### Gate 6 — Essence and necessary existence

Frozen as `essence-ne-v0.1` in `docs/ESSENCE_AND_NECESSARY_EXISTENCE.md`.

Natural bilateral essence does not make T2 automatic. Two explicit two-world S5 models refute `T2+` through glut and gap mechanisms.

A sufficient support-theory recovery route is:

```text
REG_G := COMP_P^G + CONS_G^G

NegExemplification
+ G-sup
+ A1-L
+ R+
+ REG_G
=> T2+
```

Conditional T3 then supplies `GW`, and T2/T3 plus constant-property embedding yield modal collapse.

### Gate 7 — Formal verification

Complete at `formal-v0.1`; frozen in `docs/FORMAL_VERIFICATION.md`.

Lean 4.30.0 machine-proves:

```text
MC+ <-> MC-
A1-R + A2+ => T1-T
NegExemplification + G-sup + A1-L + R+ + REG_G => T2+
PossibleGod + T2+ + A5+ + NE-sup + G-sup + S5 => T3+
T3+ => GW
T2+ + T3+ + G-sup + CONST => MC+
```

The finite oracle regression-checks the T1 glut obstruction and both T2 glut/gap countermodels. A broader exhaustive two-world / one-entity `G,Z` family contains **873** models satisfying all four current T2 recovery assumptions, and all satisfy `T2+`. Dropping any one of `A1-L`, `R+`, `COMP_P^G`, or `CONS_G^G` yields a T2 countermodel in that same bounded family.

Classical bilateral recovery of `Pos_T`, `NEnt`, Godlikeness, essence, and necessary existence is machine-checked under explicit classical coherence. Exact line-by-line correspondence with the full AFP/HOL Scott development remains a publication audit item.

### Gate 8 — Comparative variants

Gate 8 is in progress.

#### Project-internal exact positive Godlikeness

The support/exact comparison is frozen in `docs/GODLIKENESS_VARIANTS.md`.

```text
G-exact+(x): +phi(x) iff +P(phi)
```

Lean proves:

```text
G-exact+ => G-sup+
G-exact+ + R+ => T2-exact+
```

Finite regressions show that exact positive Godlikeness is compatible with genuine `B` gluts and that both Gate-6 T2 countermodels exploit the freedom absent from exactness.

`G-exact+` remains a project-internal comparison name. It is not Anderson or Fitting.

#### Anderson comparison

A literature-grounded positive Anderson interface and a project bilateral lift are now mechanized.

The positive Anderson pattern is represented without introducing an object-language biconditional:

```text
+P(phi) <-> necessary +phi(x)
```

for the same fixed individual.

Lean machine-checks:

- on reflexive frames, Anderson positive Godlikeness implies `G-sup+`;
- Anderson positive Godlikeness and `G-exact+` are not identified;
- the positive Anderson essence bridge from `A2+`, `R+`, positive `G_A`, realization, and reflexivity;
- the positive Anderson necessary-existence chain;
- positive necessary actual Godlike existence from explicit possible Godlikeness on the S5 control frames.

The bilateral candidate is frozen as `anderson-bilateral-v0.1` in `docs/ANDERSON_BILATERAL.md`.

Its negative clauses record explicit mismatch evidence for Anderson's two equivalence directions rather than mere meta-level failure. Under classical coherence Lean proves:

```text
-AndNecEx(phi,x) <-> not +AndNecEx(phi,x)
-G_A(x)          <-> not +G_A(x)
-E_A(phi,x)      <-> not +E_A(phi,x)
-AndBoxExists    <-> not +AndBoxExists
-NE_A(x)         <-> not +NE_A(x)
```

A two-world complete-S5 executable model satisfies the currently encoded bilateral Anderson candidate, including bilateral realization of `G_A` and `NE_A`, and has positive necessary Godlike existence while positive modal collapse fails for a contingent formula application `Q(a)`:

```text
+Q(a) @ w0
not +Box Q(a) @ w0
P(Q) = P(notQ) = N.
```

This is a theorem/model result for the project's bilateral Anderson candidate, not a claim that Anderson historically specified a unique four-valued semantics.

#### Fitting boundary

A faithful Fitting comparison is intentionally deferred until the semantic types distinguish intensional properties from their extensions. Reusing the current single `Property` type would erase the central feature of Fitting's revision.

## Verification

From the repository root:

```bash
python3 -m unittest discover -s formal/finite -p "test_*.py" -v
python3 formal/finite/checker.py
python3 formal/finite/gate7_search.py
python3 formal/finite/gate8_compare.py
python3 formal/finite/gate8_anderson.py
```

Lean:

```bash
cd formal/lean
lake build
```

The Lean package is pinned to Lean 4.30.0 and uses `lakefile.toml`. GitHub Actions runs both the finite regressions and `lake build`.

## Research gates

- **Gates 0–7:** complete for the current S5 control theory.
- **Gate 8:** in progress. Current frontier: exact modal-frame dependencies of the Scott and Anderson routes, followed by the Fitting intension/extension split and paired neighborhoods.
- **Gate 9:** publication consolidation and dedicated prior-art / exact-HOL correspondence audit.

## Paper

The living manuscript is in `paper/`.

Current version:

```text
paper-v0.7
```

Build from `paper/` with:

```bash
latexmk -pdf main.tex
```

## Repository layout

```text
.
├── README.md
├── ROADMAP.md
├── docs/
│   ├── SCOTT_BASELINE.md
│   ├── FOUR_VALUED_KERNEL.md
│   ├── MODAL_LIFT.md
│   ├── POSITIVITY_LIFT.md
│   ├── COLLAPSE_EXPERIMENT.md
│   ├── GODLIKENESS_AND_POSSIBILITY.md
│   ├── ESSENCE_AND_NECESSARY_EXISTENCE.md
│   ├── FORMAL_VERIFICATION.md
│   ├── GODLIKENESS_VARIANTS.md
│   ├── ANDERSON_POSITIVE_FRAGMENT.md
│   └── ANDERSON_BILATERAL.md
├── formal/
│   ├── README.md
│   ├── finite/
│   │   ├── checker.py
│   │   ├── gate7_search.py
│   │   ├── gate8_compare.py
│   │   ├── gate8_anderson.py
│   │   └── test_checker.py
│   └── lean/
│       ├── lean-toolchain
│       ├── lakefile.toml
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
    └── workflows/
        └── formal.yml
```

## Non-goals

- theological evaluation of the conclusion;
- changing semantics merely to rescue failed conjectures;
- treating four-valued implication choices as interchangeable;
- identifying project-internal variants with literature variants before source-level comparison;
- claiming uniqueness for the project-specific bilateral Anderson lift;
- claiming novelty before the dedicated prior-art and publication audit.

## Status

**Phase:** Gate 7 complete; Gate 8 in progress; bilateral Anderson milestone green; `paper-v0.7` remains the synchronized manuscript baseline.
