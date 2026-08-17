# Formalization

Gate 7 is complete at `formal-v0.1`. Gate 8 extends that verified control theory with comparative variants, frame minimization, and a substantive bilateral Fitting branch with theorem-level assumption reduction.

The formal layer deliberately has two roles:

1. `finite/` is the executable finite-model oracle for countermodels and bounded assumption searches.
2. `lean/` contains general semantic theorems that must not depend on a finite bound.

## Finite-model oracle

Gate 7 regression-checks the T1/T2 glut-gap countermodels, collapse-schema equivalence, the original 204-model T2 control search, and the broader 873-model bounded Scott assumption search.

Gate 8 adds:

- `gate8_compare.py` for support/exact/Anderson comparison;
- `gate8_anderson.py` for the bilateral Anderson necessary-God / no-positive-collapse fixture;
- `gate8_frames.py` and `gate8_scott_frames.py` for non-symmetric S4 countermodels;
- `gate8_fitting.py` for the admissible Fitting de-re/de-dicto separation;
- `gate8_fitting_no_collapse.py` for a complete-S5 admissible Fitting model with positive necessary Godlike existence, genuine `B` information, and failure of positive modal collapse;
- `gate8_fitting_minimality.py` for two strictness fixtures: targeted negative-classification consistency versus full consistency on the A1-L-only route, and positive-only G-extension stability versus full bilateral stability under a stronger S5 control stack.

Run from the repository root:

```bash
python3 -m unittest discover -s formal/finite -p 'test_*.py' -v
python3 formal/finite/checker.py
python3 formal/finite/gate7_search.py
python3 formal/finite/gate8_compare.py
python3 formal/finite/gate8_anderson.py
python3 formal/finite/gate8_frames.py
python3 formal/finite/gate8_scott_frames.py
python3 formal/finite/gate8_fitting.py
python3 formal/finite/gate8_fitting_no_collapse.py
python3 formal/finite/gate8_fitting_minimality.py
```

## Lean layer

The package is pinned to Lean 4.30.0 and uses declarative `lakefile.toml` configuration.

Current comparative modules include:

```text
Goedel4PEL/GoedelScott/GodlikeVariants.lean
Goedel4PEL/GoedelScott/AndersonInterfaces.lean
Goedel4PEL/GoedelScott/AndersonBilateral.lean
Goedel4PEL/GoedelScott/AndersonFrames.lean
Goedel4PEL/GoedelScott/ScottFrames.lean
Goedel4PEL/GoedelScott/FittingTypes.lean
Goedel4PEL/GoedelScott/FittingSemantics.lean
Goedel4PEL/GoedelScott/FittingRecovery.lean
Goedel4PEL/GoedelScott/FittingNecessaryExistence.lean
Goedel4PEL/GoedelScott/FittingDeDicto.lean
Goedel4PEL/GoedelScott/FittingAdmissible.lean
Goedel4PEL/GoedelScott/FittingAdmissibleRecovery.lean
Goedel4PEL/GoedelScott/FittingAdmissibleNecessaryExistence.lean
Goedel4PEL/GoedelScott/FittingMinimality.lean
Goedel4PEL/GoedelScott/FittingMinimalityInteractions.lean
```

### Gate-7 control spine

Lean machine-proves the current Scott control results, including:

```text
MC+ <-> MC-
A1-R + A2+ => T1-T
NegExemplification + G-sup + A1-L + R+ + REG_G => T2+
T3+ + Reflexive(R) => GW
T2+ + T3+ + G-sup + CONST + Reflexive(R) => MC+
```

Gate 8 strengthens the later Scott T3 dependency to symmetry alone once `T2+` is available.

### Gate-8 Scott / Anderson frame results

Lean proves both current T3 routes from symmetry alone:

```text
Scott after T2+:
Symmetric(R) + PossibleGod + T2+ + A5+ + NE-sup + G-sup => T3+

Anderson:
Symmetric(R)
+ Possible +G_A
+ AndersonGRealization
+ AndersonGPositive
+ A2+
+ AndersonNERealization
+ AndersonNEPositive
=> AndersonT3+
```

Reflexivity and transitivity are absent from those theorems. Separate finite S4-style models show that reflexivity plus transitivity do not replace symmetry in either current route.

### Gate-8 Fitting: unrestricted obstruction

The initial Fitting type split is retained:

```text
Extension Entity
Intension World Entity := World -> Extension Entity
```

and positivity consumes extensions rather than intensions.

A naive unrestricted bilateral extension domain turned out to be too strong for the intended `REG_G` recovery route. Because the full `Extension` type contains a universal glut extension, Lean proves:

```text
ConsGG M -> forall w x, not GodPlus M w x
RegG  M -> forall w x, not GodPlus M w x
```

Thus the earlier unrestricted Fitting recovery implication remains logically valid but is not used as a substantive non-vacuous theorem.

### Gate-8 Fitting: admissible extensional domain

The substantive candidate introduces:

```text
AdmissibleSemantics
  base          : Fitting.Semantics
  admissible    : Extension Entity -> Prop
  negate_closed : admissible X -> admissible (negate X)
```

This does not globally require consistency. The finite oracle contains a negation-closed admissible domain with a genuine `B` extension.

Lean proves the non-vacuous extensional essence recovery theorem:

```text
GAdmissible
+ GRealizationAdm
+ A1LAdm
+ RegGAdm
----------------
GodPlusAdm(x) => EssPlusAdm(current G extension, x)
```

No `R+` premise occurs.

Under classical coherence on the selected extensional domain Lean proves:

```text
EntailMinus    <-> not EntailPlus
GodMinusAdm    <-> not GodPlusAdm
EssMinusAdm    <-> not EssPlusAdm
BoxExistsMinus <-> not BoxExistsPlus
NEMinusAdm     <-> not NEPlusAdm
```

### Fitting theorem-level minimization

`FittingMinimality.lean` replaces full relevant consistency by the proof-local condition:

```text
NegClassConsistencyAdm:
  Adm(Y)
  + GodPlusAdm(w,x)
  + Y.pos(x)
  + pNeg(w,Y)
  -> not Y.neg(x)
```

with

```text
RegGNegClassAdm := CompPGAdm + NegClassConsistencyAdm.
```

Lean proves the same admissible Fitting essence and de-re necessary-existence route from `A1-L + RegGNegClassAdm`.

The weakening is A1-sensitive. `FittingMinimalityInteractions.lean` proves:

```text
A1-R + RegGNegClassAdm => RegGAdm
```

more precisely reconstructing full `ConsGGAdm` from `A1-R`, positivity completeness, and the targeted consistency premise. Hence the reduction is genuine for the A1-L-only recovery route but not a global weakening of a theory that independently retains A1-R.

### Fitting positive-only de-dicto stability

The positive de-dicto theorem uses only positive G-membership transport. Lean separates:

```text
GPosPersistsAlongRAdm
GPosReflectsAlongRAdm
GPosStableAlongRAdm := persistence + reflection
```

and proves:

```text
full bilateral G-extension stability
=> positive-only G stability
```

as well as the minimized theorem:

```text
GAdmissible
+ GRealizationAdm
+ A1LAdm
+ RegGNegClassAdm
+ NE realization
+ A5+
+ GPosStableAlongRAdm
+ de-dicto possible actual Godlikeness
--------------------------------------
  de-dicto necessary actual Godlikeness
```

No negative-extension stability and no S4/S5 frame property is required.

The finite strictness fixture keeps both A1 directions and even the old full `RegGAdm` on a complete S5 frame. Positive membership in G is identical across worlds while negative support about a non-Godlike entity drifts. Thus positive-only stability holds, full bilateral stability fails, and positive necessary de-dicto Godlikeness still holds.

### Fitting de re and de dicto

The admissible necessary-existence chain yields a frame-free de-re theorem. The earlier three-world model shows that de-re necessity need not imply de-dicto necessity when positive G-extension transport fails. A separate complete-S5 model has positive necessary actual Godlikeness while a contingent `Q(a)` refutes `MC+`; the admissible extension domain still contains genuine inconsistent `B` information.

Build locally:

```bash
cd formal/lean
lake build
```

## CI and discipline

GitHub Actions runs both finite regressions and `lake build`. The Fitting minimization theorems and both strictness fixtures are part of the root build/regression suite.

Finite searches and fixtures are always reported with their exact bounds. General claims are promoted to machine-checked status only when represented by Lean theorems.

## Next Gate-8 formal work

The main remaining work is:

1. weaken `CompPGAdm` without merely postulating the desired reflection conclusion;
2. determine whether positive persistence or positive reflection follows from other principled Fitting assumptions;
3. justify additional closure conditions for the admissible extension domain;
4. rerun selected Scott/Anderson/Fitting results over paired-neighborhood semantics;
5. complete the source-level publication audit.
