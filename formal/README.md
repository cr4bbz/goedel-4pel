# Formalization

Gate 7 is complete at `formal-v0.1`. Gate 8 extends that verified control theory with comparative variants, frame minimization, a substantive bilateral Fitting branch, theorem-level assumption reduction, admissible-domain structure, and the new entailment/quotient experiment.

The formal layer deliberately has two roles:

1. `finite/` is the executable finite-model oracle for countermodels and bounded assumption searches.
2. `lean/` contains general semantic theorems that must not depend on a finite bound.

## Finite-model oracle

Gate 7 regression-checks the T1/T2 glut-gap countermodels, collapse-schema equivalence, the original 204-model T2 control search, and the broader 873-model bounded Scott assumption search.

Gate 8 adds, among others:

- `gate8_anderson.py` for the bilateral Anderson necessary-God / no-positive-collapse fixture;
- `gate8_frames.py` and `gate8_scott_frames.py` for non-symmetric S4 countermodels;
- `gate8_fitting.py` for the admissible Fitting de-re/de-dicto separation;
- `gate8_fitting_no_collapse.py` for complete-S5 necessary Godlikeness without positive collapse;
- `gate8_fitting_minimality.py` for targeted-consistency and positive-only-stability strictness;
- `gate8_fitting_comp.py` for the first `COMP`-free indiscernibility route;
- `gate8_fitting_profile_saturation.py` for the nontrivial two-Godlike profile-quotient fixture;
- `gate8_fitting_algebra.py` for the counterexample showing FDE algebra closure does not force profile saturation;
- `gate8_fitting_entailment.py` for the new entailment-closure and actual-existence quotient experiments.

The latest finite entailment fixture uses the complete bilateral extension universe on two entities, hence exactly `4^2 = 16` extensions. It verifies that the simultaneous package

```text
A2+
full domain-level entailment closure
full FDE algebra closure
profile-compatible actual existence
```

does not force positive-profile saturation. A second two-world fixture shows that positive entailment can fail to descend through profile saturation when actual existence splits one positive-profile class.

Run from the repository root:

```bash
python3 -m unittest discover -s formal/finite -p 'test_*.py' -v
python3 formal/finite/gate8_fitting_entailment.py
```

## Lean layer

The package is pinned to Lean 4.30.0 and uses declarative `lakefile.toml` configuration.

Current Fitting comparative modules include:

```text
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
Goedel4PEL/GoedelScott/FittingAdmissibleAlgebra.lean
Goedel4PEL/GoedelScott/FittingEntailmentQuotient.lean
```

### Gate-7 control spine

The verified Scott control results include:

```text
MC+ <-> MC-
A1-R + A2+ => T1-T
NegExemplification + G-sup + A1-L + R+ + REG_G => T2+
T3+ + Reflexive(R) => GW
T2+ + T3+ + G-sup + CONST + Reflexive(R) => MC+
```

Gate 8 additionally verifies symmetry-only T3 routes for Scott-after-T2 and Anderson, with separate non-symmetric S4 finite countermodels.

### Fitting: established Gate-8 formal spine

The established Fitting branch distinguishes intensional properties from rigid bilateral extensions and uses a selected FDE-negation-closed admissible extension domain after the unrestricted-comprehension obstruction was identified.

Verified prior to the newest entailment milestone are:

- admissible-domain extensional essence recovery with no `R+`;
- bilateral classical recovery for entailment, Godlikeness, essence, box-existence and NE;
- frame-free de-re possibility-to-necessity;
- positive-only de-dicto stability;
- A1-sensitive reduction of relevant exemplification consistency;
- the `COMP`-independent Godlike-indiscernibility route;
- derivation of that route from positive-profile saturation;
- equivalence of positive and bilateral profile saturation under negation closure;
- preservation of quotient factorization by FDE negation, conjunction, disjunction, top and bottom;
- ultrafilter-style complement decision returning to the classification route under relevant consistency or `A1-R`.

### Fitting entailment quotient: newest implementation

`FittingEntailmentQuotient.lean` introduces a deliberate distinction between **positivity-filter closure** and **ambient-domain entailment closure**.

The latter candidate is:

```text
GlobalEntailmentClosedAdm:
  Adm(X)
  + (forall w, EntailPlus(w,X,Y))
  -> Adm(Y)
```

The new module implements the general obstruction:

```text
GlobalEntailmentClosedAdm
+ Adm(FDE bottom)
=> forall Y, Adm(Y)
```

because FDE bottom has no positive instances and therefore positively entails every extension vacuously. The module also implements the corollary that adding `ConsGGAdm` then excludes every positive Fitting-Godlike witness, recreating the earlier unrestricted-comprehension obstruction.

The positive replacement is the canonical bilateral closure operator:

```text
Extension.profileSaturateAt M w Y
```

which closes both positive and negative support under the positive-profile equivalence classes at `w`.

The module implements general theorems for:

```text
extensivity
monotonicity
quotient-respecting output
least quotient-respecting hull above the input
idempotence up to bilateral extensional equivalence
PositiveProfileSaturatedAdm <-> every admissible extension is a fixed point
```

Actualist entailment requires one additional interface:

```text
ProfileExistenceSaturatedAdm:
  w R z
  + PositiveProfileEqAdm(w,x,y)
  -> (Exists(z,x) <-> Exists(z,y))
```

and the module implements:

```text
ProfileExistenceSaturatedAdm
+ EntailPlus(w,X,Y)
=> EntailPlus(w, Sat_w(X), Sat_w(Y))
```

The finite counterexample described above shows that entailment descent can fail when actual existence splits the profile class.

### Verification status of the newest module

The finite regressions have been separately executed and the new Lean module is committed and root-imported. At this exact repository snapshot, the new `FittingEntailmentQuotient.lean` theorem block still awaits one **local Lean 4.30.0 `lake build` confirmation** before these newest general statements are promoted to the same machine-checked status as the earlier Gate-8 Lean spine.

Build locally:

```bash
cd formal/lean
lake build
```

## CI and discipline

GitHub Actions runs both finite regressions and `lake build`, but the connector does not currently expose the newest push-triggered check run reliably. Accordingly, the repository status files distinguish the already verified Gate-8 theorem spine from the newest entailment-quotient implementation pending local build confirmation.

Finite searches and fixtures are always reported with exact bounds. General claims are promoted to machine-checked status only after Lean accepts them.

### No `assert` in the finite layer

Checks in `finite/` use `require(condition)` from `checker.py`, never a bare `assert`. Python strips `assert` statements under `-O`, so an assertion-based oracle reports success while verifying nothing:

```bash
python -O formal/finite/checker.py   # must still verify, not just print OK
```

`require` raises `CheckFailed`, which `-O` cannot remove. Pass a second argument when a failure needs a model signature; otherwise the traceback already identifies the failing condition. New fixtures should follow the same convention.

## Next Gate-8 formal work

After the local build confirmation, the main frontier is:

1. determine whether `ProfileExistenceSaturatedAdm` follows from a principled actualist-domain condition or should be encoded through an explicit quotient type;
2. formulate a genuinely four-valued `delta`-filter/ultrafilter on the profile-closure fixed-point algebra and test whether it can avoid reconstructing `COMP`;
3. determine whether positive persistence or positive reflection follows from other principled Fitting assumptions;
4. rerun selected Scott/Anderson/Fitting results over paired-neighborhood semantics;
5. complete the source-level publication audit.
