# Formalization

Gate 7 is complete at `formal-v0.1`. The frozen verification record is `docs/FORMAL_VERIFICATION.md`. Gate 8 is now extending that verified control theory with comparative variants.

The formal layer deliberately has two roles:

1. `finite/` is the executable finite-model oracle for countermodels and bounded assumption searches.
2. `lean/` contains general semantic theorems that must not depend on a finite bound.

## Finite-model oracle

The Gate-7 Python regression suite machine-checks the T1/T2 glut-gap countermodels, collapse-schema regression, the original 204-model T2 control search, and the broader 873-model bounded assumption search.

Gate 8 adds `formal/finite/gate8_compare.py`. The first comparative regressions establish that:

- the Gate-6 glut T2 countermodel is support-Godlike but not exact-positive-Godlike;
- the Gate-6 gap T2 countermodel is support-Godlike but not exact-positive-Godlike;
- exact positive Godlikeness can coexist with genuine `B` gluts.

Run from the repository root:

```bash
python3 -m unittest discover -s formal/finite -p 'test_*.py' -v
python3 formal/finite/checker.py
python3 formal/finite/gate7_search.py
python3 formal/finite/gate8_compare.py
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
Goedel4PEL/GoedelScott/T1.lean
Goedel4PEL/GoedelScott/T2.lean
Goedel4PEL/GoedelScott/T3Collapse.lean
Goedel4PEL/Analysis/Collapse.lean
Goedel4PEL/Analysis/Recovery.lean
```

### Gate-7 machine-proved spine

```text
MC+ <-> MC-
A1-R + A2+ => T1-T
NegExemplification + G-sup + A1-L + R+ + REG_G => T2+
PossibleGod + T2+ + A5+ + NE-sup + G-sup + S5 => T3+
T3+ => GW
T2+ + T3+ + G-sup + CONST => MC+
```

Under explicit classical coherence, Lean also proves complementary positive/negative recovery for `Pos_T`, `NEnt`, Godlikeness, essence, and necessary existence.

### Gate-8 initial comparison

`GodlikeVariants.lean` introduces the project-internal positive comparison condition:

```text
G-exact+(x): +phi(x) iff +P(phi)
```

This name is internal to the repository and is not identified with Anderson or Fitting.

Lean proves:

```text
G-exact+ => G-sup+
```

and, for the exact-positive variant:

```text
G-exact+ + R+ => T2-exact+
```

Thus the exact-positive definition internalizes the positive reflection step that the support theory recovers using `A1-L + COMP_P^G + CONS_G^G`.

Build locally:

```bash
cd formal/lean
lake build
```

## CI and discipline

GitHub Actions runs both finite-model regressions and `lake build`; the initial Gate-8 support/exact comparison is green on both jobs.

Finite exhaustive checks are always reported with their exact bounded domain. No absence of a bounded countermodel is promoted to a general theorem.

## Next Gate-8 formal work

The next comparison is literature-grounded. Anderson strengthens Godlikeness using necessary exemplification and also changes essence; Fitting instead changes the intensional/extensional treatment of positivity. Their definitions must therefore be lifted as separate variants rather than relabeling `G-exact+`.
