# Formalization

Gate 7 is complete at `formal-v0.1`. The frozen verification record is `docs/FORMAL_VERIFICATION.md`. Gate 8 extends that verified control theory with comparative variants, modal-frame minimization, and the first Fitting-specific type boundary.

The formal layer deliberately has two roles:

1. `finite/` is the executable finite-model oracle for countermodels and bounded assumption searches.
2. `lean/` contains general semantic theorems that must not depend on a finite bound.

## Finite-model oracle

The Gate-7 Python regression suite machine-checks the T1/T2 glut-gap countermodels, collapse-schema regression, the original 204-model T2 control search, and the broader 873-model bounded assumption search.

Gate 8 adds comparative and frame regressions:

- `gate8_compare.py` separates support-based, exact-positive, and Anderson positive Godlikeness and shows exact positive Godlikeness remains compatible with genuine `B` gluts;
- `gate8_anderson.py` validates the bilateral Anderson necessary-God / no-positive-collapse fixture;
- `gate8_frames.py` validates an Anderson S4-style non-symmetric countermodel to `AndersonT3+`;
- `gate8_scott_frames.py` validates the corresponding Scott-support S4-style non-symmetric countermodel to `T3+`.

Run from the repository root:

```bash
python3 -m unittest discover -s formal/finite -p 'test_*.py' -v
python3 formal/finite/checker.py
python3 formal/finite/gate7_search.py
python3 formal/finite/gate8_compare.py
python3 formal/finite/gate8_anderson.py
python3 formal/finite/gate8_frames.py
python3 formal/finite/gate8_scott_frames.py
```

## Lean layer

The package under `formal/lean/` is pinned to Lean 4.30.0 and uses declarative `lakefile.toml` configuration.

Current modules include:

```text
Goedel4PEL/FourValued/Truth.lean
Goedel4PEL/FourValued/Connectives.lean
Goedel4PEL/FourValued/Modal.lean
Goedel4PEL/FourValued/Actualist.lean
Goedel4PEL/GoedelScott/Semantics.lean
Goedel4PEL/GoedelScott/GodlikeVariants.lean
Goedel4PEL/GoedelScott/AndersonInterfaces.lean
Goedel4PEL/GoedelScott/AndersonBilateral.lean
Goedel4PEL/GoedelScott/AndersonFrames.lean
Goedel4PEL/GoedelScott/FittingTypes.lean
Goedel4PEL/GoedelScott/T1.lean
Goedel4PEL/GoedelScott/T2.lean
Goedel4PEL/GoedelScott/T3Collapse.lean
Goedel4PEL/GoedelScott/ScottFrames.lean
Goedel4PEL/Analysis/Collapse.lean
Goedel4PEL/Analysis/Recovery.lean
```

### Gate-7 machine-proved spine

The original Gate-7 control proofs include:

```text
MC+ <-> MC-
A1-R + A2+ => T1-T
NegExemplification + G-sup + A1-L + R+ + REG_G => T2+
PossibleGod + T2+ + A5+ + NE-sup + G-sup + S5 => T3+
T3+ + Reflexive(R) => GW
T2+ + T3+ + G-sup + CONST + Reflexive(R) => MC+
```

Under explicit classical coherence, Lean also proves complementary positive/negative recovery for `Pos_T`, `NEnt`, Godlikeness, essence, and necessary existence.

### Gate-8 support / exact comparison

`GodlikeVariants.lean` introduces the project-internal positive comparison condition:

```text
G-exact+(x): +phi(x) iff +P(phi)
```

This name is internal to the repository and is not identified with Anderson or Fitting.

Lean proves:

```text
G-exact+ => G-sup+
G-exact+ + R+ => T2-exact+
```

Thus the exact-positive definition internalizes the positive reflection step that the support theory recovers using `A1-L + COMP_P^G + CONS_G^G`.

### Gate-8 Anderson branch

`AndersonInterfaces.lean` reconstructs the literature-grounded positive Anderson interfaces through necessary exemplification of the same individual. `AndersonBilateral.lean` adds the project's explicit negative mismatch evidence and proves classical recovery under classical coherence.

The finite oracle supplies a bilateral complete-S5 fixture with positive necessary Godlike existence and failure of positive modal collapse for a contingent `Q(a)`.

`AndersonFrames.lean` then removes unnecessary S5 frame assumptions. Lean proves:

```text
Symmetric(R)
+ Possible +G_A
+ AndersonGRealization
+ AndersonGPositive
+ A2+
+ AndersonNERealization
+ AndersonNEPositive
--------------------------------
AndersonT3+
```

No reflexivity, transitivity, or separate `R+` premise occurs in this theorem.

### Gate-8 Scott frame reduction

`ScottFrames.lean` proves, once Scott `T2+` is already available:

```text
Symmetric(R)
+ PossibleGod
+ T2+
+ A5+
+ NE-sup
+ G-sup
--------------
T3+
```

Again, reflexivity and transitivity are absent. The separate finite Anderson and Scott S4-style fixtures show that reflexivity plus transitivity do not replace symmetry in these current routes.

This is a local theorem-level minimization. It does not show that the complete primitive Scott theory needs only symmetry, because the reduced Scott theorem takes `T2+` as a premise, and it does not establish symmetry as globally unique/minimal.

### Gate-8 Fitting type boundary

`FittingTypes.lean` introduces distinct Lean types for bilateral extensions and world-indexed intensions:

```text
Extension Entity
Intension World Entity := World -> Extension Entity
```

The Fitting semantic shell types positivity over `Extension Entity`, not over `Intension World Entity`. `extensionAt` and `rigidify` make the bridge explicit.

This is intentionally infrastructure only. The next formal tasks are extension-level necessary entailment, Fitting essence, Fitting necessary existence, classical recovery, and then necessary-God / modal-collapse tests.

Build locally:

```bash
cd formal/lean
lake build
```

## CI and discipline

GitHub Actions runs both finite-model regressions and `lake build`. The Scott S4 countermodel and the imported Fitting type boundary are both green in CI.

Finite exhaustive checks are always reported with their exact bounded domain. No absence of a bounded countermodel is promoted to a general theorem.

## Next Gate-8 formal work

The next comparison is the extension-level Fitting chain. The type boundary is now fixed, so the safe order is:

1. extension-level necessary entailment;
2. positive Fitting essence;
3. extension-typed necessary existence;
4. classical recovery where appropriate;
5. necessary Godlike existence and modal-collapse countermodels/theorems;
6. direct comparison with the bilateral Anderson branch.
