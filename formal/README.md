# Formalization

Gate 7 is complete at `formal-v0.1`. The frozen verification record is `docs/FORMAL_VERIFICATION.md`.

The formal layer deliberately has two roles:

1. `finite/` is the executable finite-model oracle for countermodels and bounded assumption searches.
2. `lean/` contains general semantic theorems that must not depend on a finite bound.

## Finite-model oracle

The Python regression suite machine-checks:

- the Gate-6 glut and gap countermodels to `T2+`;
- the split of `CONS_G^G` versus `COMP_P^G`;
- a one-world glut countermodel to unrestricted `+P => +◇∃ᴱ`;
- schema-level `MC+ <-> MC-` on the negation-closed two-world test family;
- the original 204-model `REG_G => T2+` control search;
- a broader bounded T2 assumption search.

The broader search retains **873** models satisfying `A1-L`, `R+`, `COMP_P^G`, and `CONS_G^G` together with fixed complement semantics and full bilateral `G-sup-v0.1`. Every retained model satisfies `T2+`. Dropping any one of those four assumptions individually yields a T2 countermodel in the same bounded family.

Run from the repository root:

```bash
python3 -m unittest discover -s formal/finite -p 'test_*.py' -v
python3 formal/finite/checker.py
python3 formal/finite/gate7_search.py
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
Goedel4PEL/GoedelScott/T1.lean
Goedel4PEL/GoedelScott/T2.lean
Goedel4PEL/GoedelScott/T3Collapse.lean
Goedel4PEL/Analysis/Collapse.lean
Goedel4PEL/Analysis/Recovery.lean
```

Lean machine-proves:

```text
MC+ <-> MC-
A1-R + A2+ => T1-T
NegExemplification + G-sup + A1-L + R+ + REG_G => T2+
PossibleGod + T2+ + A5+ + NE-sup + G-sup + S5 => T3+
T3+ => GW
T2+ + T3+ + G-sup + CONST => MC+
```

The last two use the stated reflexive/S5 control-frame assumptions.

Under explicit classical coherence, Lean also proves:

```text
Pos_T(phi) <-> +P(phi)
NEnt-_E(phi,psi) <-> not NEnt+_E(phi,psi)
-G(x) <-> not +G(x)
-Ess(phi,x) <-> not +Ess(phi,x)
-NE(x) <-> not +NE(x)
```

Build locally:

```bash
cd formal/lean
lake build
```

## CI and discipline

GitHub Actions runs both finite-model regressions and `lake build`; the frozen Gate-7 state is green.

Finite exhaustive checks are always reported with their exact bounded domain. No absence of a bounded countermodel is promoted to a general theorem.

Gate 8 now varies the theory: `G-sup` versus `G-exact`, selected Anderson/Fitting-style variants, weaker modal frames, and later paired-neighborhood semantics.
