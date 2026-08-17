# Gate 7 — Formal verification

## Status

**Gate:** 7 — Mechanization and finite-model verification  
**Version:** `formal-v0.1`  
**Lean:** 4.30.0  
**Executable oracle:** Python standard library only  
**CI:** finite-model regressions + `lake build`

Gate 7 separates two verification roles:

1. Lean proves general semantic implications that must not depend on a finite search bound.
2. The finite-model oracle validates explicit countermodels and performs bounded exhaustive assumption searches.

A finite search is never promoted to an unbounded theorem merely because no countermodel is found.

---

## 1. General Lean theorems

The Lean package under `formal/lean/` now contains the four-valued carrier, FDE negation, conjunction/disjunction, bilateral relational modality, bilateral actualist quantifiers, the higher-order support semantics, and the principal reconstructed theorem chain.

### Collapse-channel equivalence

At schema level, under bilateral involutive negation:

```text
MC+ <-> MC-
```

This is a general theorem over arbitrary world and formula types. The proof uses substitution by the negated formula; it is not a pointwise identity for one isolated valuation.

### Truth-only T1

Lean proves, in the classical semantic metatheory:

```text
A1-R + A2+ => T1-T
```

where

```text
T1-T : Pos_T(phi) => +Diamond exists^E x phi(x)
```

and `Pos_T` means positive support for positivity without negative support.

### Conditional T2

Lean proves the Gate-6 recovery theorem generally:

```text
NegExemplification
+ G-sup-v0.1
+ A1-L
+ R+
+ REG_G
-----------------
T2+
```

with

```text
REG_G = COMP_P^G + CONS_G^G
T2+    = +G(x) => +Ess(G,x)
```

No finite-model bound is used in this theorem.

### Positive T3 and witness supply

Lean proves:

```text
PossibleGod
+ T2+
+ A5+
+ NE-sup
+ G-sup
+ S5
--------
T3+
```

and, on reflexive frames:

```text
T3+ => GW
```

Only positive support for A5 is used in the positive T3 theorem.

### Essence-compressed modal collapse

For an external formula language with constant-property embedding, Lean proves on reflexive control frames:

```text
T2+ + T3+ + G-sup + CONST => MC+
```

Together with the schema-level collapse-channel theorem, the informative negative collapse schema follows under bilateral involutive negation.

---

## 2. Classical recovery interfaces

Gate 7 makes classical recovery explicit rather than leaving it as prose.

Assume classical coherence of exemplification:

```text
-phi(x) <-> not +phi(x)
```

and, where relevant, classical coherence of positivity:

```text
-P(phi) <-> not +P(phi).
```

Lean then proves:

```text
Pos_T(phi) <-> +P(phi)
NEnt-_E(phi,psi) <-> not NEnt+_E(phi,psi)
-G(x) <-> not +G(x)
-Ess(phi,x) <-> not +Ess(phi,x)
-NE(x) <-> not +NE(x)
```

Thus the bilateral D1/D2/D3 interfaces collapse to ordinary bivalent truth/falsity behavior when the support channels are classically coherent. Combined with the positive T1/T2/T3 theorem chain above, this supplies the Gate-7 interface-level recovery check against the frozen Scott control theory.

---

## 3. Executable countermodel regressions

The finite checker validates the two Gate-6 two-world S5 countermodels to automatic T2.

### Glut obstruction

The glut countermodel satisfies the encoded Gate-5 control stack and `COMP_P^G` but violates `CONS_G^G`, while refuting `T2+`.

### Gap obstruction

The gap countermodel satisfies the encoded Gate-5 control stack and `CONS_G^G` but violates `COMP_P^G`, while refuting `T2+`.

### T1 glut obstruction

A one-world reflexive model with no actual entities and

```text
P(A) = B
P(not A) = B
```

satisfies strong A1 and `A2+`. Positive support for `P(A)` holds, but positive possible actual exemplification of `A` fails. This machine-checks the Gate-5 reason for restricting T1 to truth-only positivity.

---

## 4. Bounded T2 minimality experiment

A broader exhaustive search varies a complete two-world / one-entity `G,Z` family while fixing:

- universal S5 accessibility;
- FDE complement exemplification;
- `P(G)=T` and `P(not G)=F` at both worlds;
- full bilateral `G-sup-v0.1`.

Positivity of `Z` and `not Z` is allowed to vary independently, so `A1-L` is tested rather than built into the generator.

Among the generated models, **873** satisfy all four recovery assumptions:

```text
A1-L
R+
COMP_P^G
CONS_G^G
```

Every one of those 873 models satisfies `T2+`.

More importantly, removing any one of the four assumptions while retaining the other three yields a `T2+` countermodel in the same bounded family.

Representative first witnesses found by the search are:

| dropped assumption | G@w0 | G@w1 | Z@w0 | Z@w1 | PZ@w0 | PnotZ@w0 | PZ@w1 | PnotZ@w1 |
|---|---|---|---|---|---|---|---|---|
| `A1-L` | T | T | T | F | F | F | F | F |
| `R+` | T | T | T | F | T | F | F | T |
| `COMP_P^G` | T | T | T | F | N | N | N | N |
| `CONS_G^G` | T | B | T | T | T | F | T | F |

This establishes **bounded individual indispensability** of the four recovery assumptions relative to the fixed semantic laws and this model family. It does not establish global model-theoretic minimality.

---

## 5. Reproducibility

From the repository root:

```bash
python3 -m unittest discover -s formal/finite -p 'test_*.py' -v
python3 formal/finite/checker.py
python3 formal/finite/gate7_search.py
```

For Lean:

```bash
cd formal/lean
lake build
```

GitHub Actions runs the regression suite and Lean build on pushes and pull requests.

---

## 6. Gate-7 conclusion

Gate 7 changes the epistemic status of several results:

- collapse-channel equivalence is machine-proved generally;
- `T1-T` is machine-proved generally;
- the sufficient `T2+` recovery theorem is machine-proved generally;
- positive T3, witness supply, and the essence-compressed collapse theorem are machine-proved generally;
- glut/gap failures are executable regression countermodels;
- the four T2 recovery assumptions are individually indispensable in the explicitly bounded search family;
- bilateral D1/D2/D3 recovery under classical coherence is machine-proved.

The next gate should therefore vary the theory rather than continue changing the control semantics: compare `G-sup` with `G-exact`, selected Anderson/Fitting-style variants, weaker modal frames, and later paired-neighborhood semantics.
