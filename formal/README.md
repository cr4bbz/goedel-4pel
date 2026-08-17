# Formalization

Gate 7 is complete at `formal-v0.1`. Gate 8 extends that verified control theory with comparative variants, frame minimization, a substantive bilateral Fitting branch, theorem-level assumption reduction, and admissible-domain structure analysis.

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
- `gate8_fitting_minimality.py` for targeted-consistency and positive-only-stability strictness fixtures;
- `gate8_fitting_comp.py` for the first `COMP_P^G(adm)` separation fixture via primitive Godlike indiscernibility;
- `gate8_fitting_profile_saturation.py` for a nontrivial quotient-domain fixture with two distinct positive Godlike individuals, profile saturation, a relevant positivity gap, failure of `COMP_P^G(adm)`, and successful essence/NE recovery.

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
python3 formal/finite/gate8_fitting_comp.py
python3 formal/finite/gate8_fitting_profile_saturation.py
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
Goedel4PEL/GoedelScott/FittingAlternativeRecovery.lean
Goedel4PEL/GoedelScott/FittingAdmissibleStructure.lean
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

Lean proves both current T3 routes from symmetry alone. Separate finite S4-style models show that reflexivity plus transitivity do not replace symmetry in either current route.

### Gate-8 Fitting: unrestricted obstruction

The initial Fitting type split is retained:

```text
Extension Entity
Intension World Entity := World -> Extension Entity
```

and positivity consumes extensions rather than intensions.

A naive unrestricted bilateral extension domain is too strong for the intended `REG_G` recovery route. Because the full `Extension` type contains a universal glut extension, Lean proves:

```text
ConsGG M -> forall w x, not GodPlus M w x
RegG  M -> forall w x, not GodPlus M w x
```

The substantive branch therefore uses a selected FDE-negation-closed admissible extension domain.

### Fitting classification-route minimization

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

Lean proves the admissible Fitting essence and de-re necessary-existence route from `A1-L + RegGNegClassAdm`. `FittingMinimalityInteractions.lean` proves that restoring `A1-R` reconstructs full `ConsGGAdm` from positivity completeness plus the targeted consistency premise.

### Fitting alternative recovery without positivity completeness

`FittingAlternativeRecovery.lean` introduces:

```text
GodlikeIndiscernibilityAdm:
  Adm(Y)
  + GodPlusAdm(w,x)
  + GodPlusAdm(w,y)
  -> (Y.pos(x) <-> Y.pos(y))
```

and Lean proves:

```text
GAdmissible
+ GRealizationAdm
+ GodlikeIndiscernibilityAdm
--------------------------------
GodPlusAdm(x) => EssPlusAdm(current G extension, x)
```

No A1 direction, `CompPGAdm`, or consistency premise occurs. The same route continues through the frame-free de-re necessary-existence theorem and, with positive-only G stability, through the positive de-dicto theorem.

### Fitting admissible-domain quotient structure

`FittingAdmissibleStructure.lean` derives the indiscernibility interface from a more structural condition.

Define positive-profile equivalence:

```text
PositiveProfileEqAdm(w,x,y):
  every positively supported admissible extension
  contains x and y alike
```

Lean proves reflexivity, symmetry, and transitivity. Any two positive Fitting-Godlike individuals are automatically positive-profile equivalent.

The selected domain is then required to respect these classes:

```text
PositiveProfileSaturatedAdm:
  Adm(Y)
  + PositiveProfileEqAdm(w,x,y)
  -> (Y.pos(x) <-> Y.pos(y))
```

Lean proves:

```text
PositiveProfileSaturatedAdm
=> GodlikeIndiscernibilityAdm
```

and therefore the full alternative essence/NE route follows without A1, `COMP`, or consistency.

Because `AdmissibleSemantics` is already closed under FDE negation, this positive saturation automatically fixes the negative membership channel as well. Lean proves:

```text
PositiveProfileSaturatedAdm
<-> BilateralProfileSaturatedAdm
```

where bilateral saturation preserves both `.pos` and `.neg` membership on each positive-profile equivalence class. Thus every admissible bilateral extension genuinely factors through the same entity quotient.

The finite `gate8_fitting_profile_saturation.py` fixture makes the theorem non-vacuous: `a` and `b` are two distinct positive Godlike individuals in one non-singleton profile class, every selected admissible extension respects that class, and the universal admissible extension is nevertheless a positivity gap. Hence `CompPGAdm` fails while current-G essence and NE recovery succeed.

### Ultrafilter-style comparison

The same module isolates only the maximality component suggested by the classical Fitting `delta`-ultrafilter analysis:

```text
PositiveComplementDecisionAdm:
  Adm(Y) -> pPos(w,Y) or pPos(w,neg Y)
```

This is not claimed to be a complete four-valued ultrafilter definition.

Lean proves:

```text
PositiveComplementDecisionAdm + ConsGGAdm
=> local positive reflection
=> CompPGAdm
```

and independently:

```text
PositiveComplementDecisionAdm + A1RAdm
=> CompPGAdm
```

Thus ultrafilter-style maximality naturally reconstructs the classification route under familiar additional resources. It does not explain the genuinely `COMP`-independent profile-quotient route.

### Positive-only de-dicto stability

The positive de-dicto theorem uses only positive G-membership transport. Lean separates persistence and reflection of the positive `G` extension and proves positive de-dicto possibility-to-necessity for both the classification and quotient recovery routes. No negative-extension stability and no S4/S5 frame property is required.

A complete-S5 strictness fixture keeps both A1 directions and the old full `RegGAdm`; positive membership in G is stable while negative support about a non-Godlike entity drifts. Full bilateral G stability fails, but positive necessary de-dicto Godlikeness still holds.

Build locally:

```bash
cd formal/lean
lake build
```

## CI and discipline

GitHub Actions runs both finite regressions and `lake build`. The Fitting minimization, alternative recovery, profile-saturation, and ultrafilter-interaction theorems are all part of the root build/regression suite.

Finite searches and fixtures are always reported with their exact bounds. General claims are promoted to machine-checked status only when represented by Lean theorems.

## Next Gate-8 formal work

The main remaining work is:

1. determine which algebraic operations and closure principles preserve the profile-saturated admissible quotient;
2. formulate a genuinely four-valued `delta`-filter/ultrafilter notion on that quotient and test whether it can avoid reconstructing `COMP`;
3. determine whether positive persistence or positive reflection follows from other principled Fitting assumptions;
4. rerun selected Scott/Anderson/Fitting results over paired-neighborhood semantics;
5. complete the source-level publication audit.
