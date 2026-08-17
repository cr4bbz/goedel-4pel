# goedel-4pel

A research repository for a four-valued reconstruction and structural analysis of the Gödel–Scott ontological argument.

## Core question

> What becomes of the Gödel–Scott system when positivity, modal status, essence, and derivability are interpreted in a four-valued bilateral semantics that admits both inconsistency and incompleteness?

The project is not intended to produce a "stronger proof of God". Its aim is logical: use Gödel–Scott as a controlled test case for four-valued modal reasoning and identify which assumptions drive possible exemplification, Godlikeness-as-essence, necessary existence, and modal collapse.

## Current thesis

Under the present involutive FDE negation, the informative signed collapse schemata are coupled:

```text
MC+ : +phi => +Box phi
MC- : -phi => +Box not phi
MC+ <-> MC-
```

The main non-classical structure therefore occurs upstream.

For the Scott-support control theory, the verified dependency spine is:

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

A5+ + T2+ + NE-sup + G-sup
+ Symmetric(R)
          |
          v
          T3+

T3+ + Reflexive(R) => GW

T2+ + T3+ + G-sup + CONST
+ Reflexive(R)
          |
          v
          MC+ <-> MC-
```

The central Scott question remains global T2 minimality.

Gate 8 shows that the bottleneck is strongly **definition-sensitive**:

```text
Scott G-sup:
  +P(phi) -> current +phi(x)

project G-exact+:
  +P(phi) <-> current +phi(x)

Anderson G_A+:
  +P(phi) <-> necessary +phi(x) for the same individual

Fitting:
  positivity and essence range over selected rigid extensions,
  while Godlikeness remains intensional
```

The three architectures move modal/informational work to different interfaces rather than merely changing the accessibility relation.

## Semantic stack

### Gates 0–7

- **Gate 0:** frozen Scott baseline and classical collapse spine.
- **Gate 1:** `kernel-v0.1`, bilateral FDE kernel with `T/F/B/N`.
- **Gate 2:** `modal-v0.1`, bilateral relational S5 control semantics.
- **Gate 3:** `positivity-v0.1`, directional A1 split and rigidity channels.
- **Gate 4:** `collapse-v0.1`, schema-level `MC+ <-> MC-`, reflection obstructions, conditional collapse.
- **Gate 5:** `godlike-v0.1`, actualist quantification, `T1-T`, possible Godlike existence, `G-sup-v0.1`.
- **Gate 6:** `essence-ne-v0.1`, bilateral essence/NE, glut-gap T2 countermodels, sufficient Scott T2 recovery, conditional T3/collapse.
- **Gate 7:** `formal-v0.1`, Lean theorem spine, classical recovery, finite countermodels, and bounded assumption searches.

Gate 7 is complete. The broader exhaustive two-world / one-entity `G,Z` family contains **873** models satisfying the full current Scott T2 recovery package; all satisfy `T2+`. Dropping any one of `A1-L`, `R+`, `COMP_P^G`, or `CONS_G^G` yields a T2 countermodel in the same bounded family. This is bounded evidence, not a global minimality theorem.

## Gate 8 — Comparative variants

Gate 8 is in progress, but the core Scott/Anderson/Fitting comparison is now machine-supported.

### Exact positive Godlikeness

`docs/GODLIKENESS_VARIANTS.md` introduces the project-internal condition:

```text
G-exact+(x): +phi(x) iff +P(phi)
```

Lean proves:

```text
G-exact+ => G-sup+
G-exact+ + R+ => T2-exact+
```

The exact condition internalizes the local positive-reflection step while still permitting genuine gluts.

### Anderson

The bilateral Anderson candidate is frozen in `docs/ANDERSON_BILATERAL.md`.

Its positive source interface classifies necessary exemplification through positivity. Project-specific negative evidence clauses have machine-checked classical recovery.

Lean reduces the positive Anderson T3 route to symmetry alone:

```text
Symmetric(R)
+ Possible +G_A
+ AndersonGRealization
+ AndersonGPositive
+ A2+
+ AndersonNERealization
+ AndersonNEPositive
=> AndersonT3+
```

A non-symmetric S4 fixture refutes this T3 conclusion, while a separate complete-S5 bilateral Anderson model has positive necessary Godlike existence and failure of positive modal collapse for a contingent `Q(a)`.

### Scott frame minimization

`docs/FRAME_MINIMIZATION.md` records that, once Scott `T2+` is available:

```text
Symmetric(R)
+ PossibleGod
+ T2+
+ A5+
+ NE-sup
+ G-sup
=> T3+
```

No reflexivity or transitivity premise is used. A reflexive-transitive but non-symmetric finite countermodel shows that S4 alone does not replace symmetry in the current route. This establishes sufficiency of symmetry, not unique global minimality.

### Fitting

The Fitting milestones are:

```text
fitting-types-v0.1
fitting-bilateral-v0.2
fitting-minimality-v0.2
fitting-domain-v0.2
```

with the latter frozen in `docs/FITTING_DOMAIN_STRUCTURE.md`.

Fitting distinguishes:

```text
Extension Entity
Intension World Entity := World -> Extension Entity
```

and positivity is extension-typed.

#### Unrestricted-comprehension obstruction

The naive unrestricted four-valued lift is too strong. Since the full bilateral extension type contains a universal glut extension, Lean proves:

```text
ConsGG -> forall w x, not GodPlus(w,x)
RegG   -> forall w x, not GodPlus(w,x)
```

The substantive candidate therefore uses a **selected admissible extension domain** `Adm(X)`, initially required only to be closed under FDE negation. This is not a global consistency restriction; admissible extensions may still carry `B` information.

#### Extensional essence and classical recovery

Lean proves a non-vacuous admissible Fitting essence theorem with no `R+` premise, and under classical coherence proves complementary recovery for extensional entailment, Godlikeness, essence, necessary actual exemplification, and necessary existence.

#### De re versus de dicto

The admissible Fitting chain proves a frame-free de-re possibility-to-necessity result. For positive de-dicto lifting, full bilateral extension stability is stronger than necessary. The minimized bridge is:

```text
GPosPersistsAlongRAdm
GPosReflectsAlongRAdm
STAB_G^+ := persistence + reflection
```

A complete-S5 finite fixture shows that positive-only stability is strictly weaker than full bilateral `STAB_G` even under a stronger surrounding control stack.

#### A1-sensitive classification route

The classification-based essence proof needs only consistency on the negatively classified branch:

```text
RegGNegClassAdm := CompPGAdm + NegClassConsistencyAdm
```

Together with `A1-L` this is sufficient for the essence/NE route. Lean also proves that restoring `A1-R` reconstructs the older full relevant consistency condition from this targeted package.

#### Alternative recovery without `COMP`

A second route bypasses positivity classification:

```text
GodlikeIndiscernibilityAdm:
  Adm(Y)
  + GodPlusAdm(w,x)
  + GodPlusAdm(w,y)
  -> (Y.pos(x) <-> Y.pos(y))
```

Lean proves current-G essence and the subsequent frame-free de-re NE route from this interface with no A1 direction, `COMP`, or exemplification-consistency premise.

A finite model with a relevant positivity value `N` shows that `COMP_P^G(adm)` is route-specific rather than globally necessary for the current Fitting essence/NE conclusion.

#### Positive-profile quotient domain

The indiscernibility interface is no longer primitive. Define:

```text
PositiveProfileEqAdm(w,x,y):
  every positively supported admissible extension
  contains x and y alike
```

Lean proves this is an equivalence relation and that any two positive Fitting-Godlike individuals are equivalent.

The domain condition

```text
PositiveProfileSaturatedAdm:
  Adm(Y)
  + PositiveProfileEqAdm(w,x,y)
  -> (Y.pos(x) <-> Y.pos(y))
```

implies `GodlikeIndiscernibilityAdm` and therefore the COMP-independent essence/NE route.

Because `Adm` is already FDE-negation-closed, Lean proves that positive profile saturation is equivalent to **bilateral** profile saturation: both positive and negative membership of each admissible extension factor through the same entity quotient.

A nontrivial finite witness has two distinct positive Godlike entities in one profile class while a relevant admissible extension has positivity value `N`; `COMP` fails but essence and NE recovery succeed.

#### FDE algebra on the quotient

`FittingAdmissibleAlgebra.lean` defines pointwise FDE conjunction/disjunction and top/bottom extensions. Lean proves that all bilateral extensions respecting a fixed positive-profile quotient are closed under:

```text
FDE negation
FDE conjunction
FDE disjunction
FDE top / bottom
```

Thus quotient-respecting extensions form a De-Morgan-style subalgebra of the full bilateral extension algebra.

This is an algebraic **preservation** theorem, not a claim that `Adm` itself must be closed under those operations.

A separate finite regression proves the converse fails: the complete classical four-extension algebra over two entities is fully closed under these FDE operations but can still contain a singleton extension distinguishing two entities that positivity places in the same positive-profile class. Therefore:

```text
profile saturation
  => compatible with / preserved by FDE algebra

FDE algebra closure
  !=> profile saturation
```

So the quotient still needs an independent extensionality/saturation principle.

#### Ultrafilter comparison

The literature-facing maximality fragment is:

```text
PositiveComplementDecisionAdm:
  Adm(Y) -> pPos(w,Y) or pPos(w,neg Y)
```

Lean shows that complement decision plus full relevant consistency recovers local positive reflection and `COMP`; complement decision plus `A1-R` also recovers `COMP`. Ultrafilter-style maximality therefore reconnects to the classification route rather than explaining the classification-free quotient route.

#### Necessary Godlikeness without modal collapse

A separate complete-S5 finite fixture satisfies the encoded admissible Fitting stack and has positive necessary actual Godlikeness while a contingent intension satisfies:

```text
+Q(a) @ w0
not +Box Q(a) @ w0
```

The selected extension domain still contains genuine `B` information. This is an explicit finite countermodel for the current candidate, not a theorem that every Fitting semantics avoids collapse.

## Verification

From the repository root:

```bash
python3 -m unittest discover -s formal/finite -p "test_*.py" -v
python3 formal/finite/checker.py
python3 formal/finite/gate7_search.py
python3 formal/finite/gate8_compare.py
python3 formal/finite/gate8_anderson.py
python3 formal/finite/gate8_frames.py
python3 formal/finite/gate8_scott_frames.py
python3 formal/finite/gate8_fitting.py
python3 formal/finite/gate8_fitting_no_collapse.py
python3 formal/finite/gate8_fitting_minimality.py
python3 formal/finite/gate8_fitting_comp.py
python3 formal/finite/gate8_fitting_profile_saturation.py
python3 formal/finite/gate8_fitting_algebra.py
```

Lean:

```bash
cd formal/lean
lake build
```

The Lean package is pinned to Lean 4.30.0. GitHub Actions runs both formal tracks.

## Research gates

- **Gates 0–7:** complete for the original control theory.
- **Gate 8:** in progress. Major comparative milestones are green; the current Fitting frontier is the independent source of profile saturation, a genuinely four-valued `delta`-filter/ultrafilter on the quotient, derivation of positive G-stability directions, and paired-neighborhood generalization.
- **Gate 9:** publication consolidation, prior-art audit, and exact source/HOL correspondence.

## Paper

The living manuscript is in `paper/`.

Current version:

```text
paper-v0.12
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
│   ├── ANDERSON_BILATERAL.md
│   ├── FRAME_MINIMIZATION.md
│   ├── FITTING_TYPES.md
│   ├── FITTING_BILATERAL.md
│   ├── FITTING_MINIMALITY.md
│   └── FITTING_DOMAIN_STRUCTURE.md
├── formal/
│   ├── finite/
│   │   ├── gate8_fitting.py
│   │   ├── gate8_fitting_no_collapse.py
│   │   ├── gate8_fitting_minimality.py
│   │   ├── gate8_fitting_comp.py
│   │   ├── gate8_fitting_profile_saturation.py
│   │   └── gate8_fitting_algebra.py
│   └── lean/
│       └── Goedel4PEL/GoedelScott/
│           ├── FittingAdmissible.lean
│           ├── FittingMinimality.lean
│           ├── FittingAlternativeRecovery.lean
│           ├── FittingAdmissibleStructure.lean
│           └── FittingAdmissibleAlgebra.lean
└── paper/
```

## Non-goals

- theological evaluation of the conclusion;
- changing semantics merely to rescue failed conjectures;
- treating four-valued implication choices as interchangeable;
- silently identifying intensions and extensions;
- globally banning gluts to make the Fitting branch work;
- identifying project-specific bilateral or quotient clauses with unique historical readings;
- claiming global minimality from theorem-local weakenings, alternative recovery routes, or bounded finite fixtures;
- claiming novelty before the dedicated Gate-9 audit.

## Status

**Phase:** Gate 7 complete; Gate 8 in progress; Scott/Anderson frame results, admissible bilateral Fitting, `fitting-minimality-v0.2`, and `fitting-domain-v0.2` are green; manuscript baseline `paper-v0.12`.
