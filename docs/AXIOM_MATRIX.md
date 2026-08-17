# Gödel–Scott axiom matrix

This file is deliberately a matrix rather than a finished translation. Each classical axiom may admit several inequivalent four-valued liftings.

## Legend

- `CL`: exact classical baseline statement.
- `4V+`: constraint on positive support.
- `4V-`: constraint on negative support.
- `4V±`: combined bilateral constraint.
- `Status`: open / candidate / rejected / proved / countermodelled.

## Matrix

| Item | Classical role | 4V question | Current candidate split | Status |
|---|---|---|---|---|
| A1 | positivity vs property negation | Which direction drives which theorem branch? | `A1-L`, `A1-R`; strong A1 = both | **Gate 3–6 mapped** |
| A2 | closure under necessary entailment | Can truth-support closure be isolated without object implication? | `A2+` using `NEnt+_E` | **Gate 5 control fixed** |
| A3 | Godlikeness is positive | Is `+P(G)` enough for possible exemplification? | weak `A3+`; control `A3-T` | **Gate 5 split fixed** |
| A4 | positivity rigidity | Which positivity information persists universally? | `R+`; derived/dual `R-nec-` | **Gate 4 fixed** |
| A5 | necessary existence is positive | Must `NE` be truth-only positive? | `A5+`; stronger `A5-T` comparison | **Gate 6: `A5+` sufficient for positive T3 branch** |
| D1 | Godlikeness | Which positive properties impose obligations? | `G-sup-v0.1` | **Gate 5 control frozen** |
| D2 | essence | How should positive/negative essence track necessary entailment? | `Ess-sup-v0.1` using `NEnt+_E/NEnt-_E` | **Gate 6 control frozen** |
| D3 | necessary existence | How should positive/negative NE track necessary exemplification of essences? | `NE-sup-v0.1` | **Gate 6 control frozen** |

## A1 division of labor

The independent directional components are:

```text
A1-L : -P(φ)  => +P(¬φ)
A1-R : +P(¬φ) => -P(φ)
```

Across the reconstruction they now have different jobs:

```text
A1-R -> T1-T / possible exemplification
A1-L -> REF+ and the sufficient T2+ recovery route
```

Strong A1 remains their conjunction and swaps `T/F` while preserving `B/N` under property negation.

## A2 / T1 after Gate 5

```text
A2+ : +P(φ) and NEnt+_E(φ,ψ) => +P(ψ)
Pos_T(φ) := +P(φ) and not(-P(φ))
A1-R + A2+ => T1-T
T1-T : Pos_T(φ) => +◇∃ᴱx φ(x)
```

Mere `+P(φ)` is insufficient in the presence of a positivity glut.

## A3 after Gate 5

```text
A3+ : +P(G)
A3-T : Pos_T(G)
```

The Scott-control branch uses `A3-T`, yielding:

```text
+◇∃ᴱx G(x)
```

via `T1-T`.

## D1 / Godlikeness after Gate 5

`G-sup-v0.1`:

```text
+G(x) iff every +P(φ) is +φ(x)
-G(x) iff some +P(φ) is -φ(x)
```

This discharges `D1+` and recovers Scott D1 on the `T/F` fragment.

## A4 after Gates 3–4

```text
R+     : +P(φ) => +□P(φ)
R-nec- : -P(φ) => +□¬P(φ)
```

Without A1 the two are independent; under strong A1 they are interderivable.

## D2 / essence after Gate 6

Define negative evidence against necessary entailment:

```text
NEnt-_E(φ,ψ,w):
  some accessible actual +φ-instance is -ψ
```

The control essence semantics is:

```text
+Ess(φ,x) iff
  +φ(x) and
  every +ψ(x) satisfies NEnt+_E(φ,ψ)

-Ess(φ,x) iff
  -φ(x) or
  some +ψ(x) satisfies NEnt-_E(φ,ψ)
```

This recovers Scott D2 on the classical fragment while allowing essence itself to be `T/F/B/N`.

### T2 is not automatic

The target is:

```text
T2+ : +G(x) => +Ess(G,x)
```

Two explicit two-world S5 models satisfy the Gate-5 control stack together with strong A1 and `R+` while refuting `T2+`:

- a glut model where a locally exemplified `Z` is both supported and opposed at one God-like witness but not positively shared at another;
- a gap model where `P(Z)=P(¬Z)=N` and local `+Z` is not necessarily shared.

Hence the natural D2 lift does not silently restore the classical T2 theorem.

### Sufficient T2 recovery route

Define relevant God-like regularity:

```text
COMP_P^G : +G(x) and +ψ(x) => (+P(ψ) or -P(ψ))
CONS_G^G : +G(x) and +ψ(x) => not(-ψ(x))
REG_G    : COMP_P^G + CONS_G^G
```

Then:

```text
A1-L + R+ + G-sup-v0.1 + REG_G => T2+
```

The glut and gap countermodels separately witness failure of the two regularity dimensions in this recovery route. `REG_G` is sufficient, not claimed globally necessary for every model satisfying T2.

## D3 / necessary existence after Gate 6

`NE-sup-v0.1`:

```text
+NE(x) iff every +Ess(φ,x) has +□∃ᴱy φ(y)
-NE(x) iff some +Ess(φ,x) has -□∃ᴱy φ(y)
```

This recovers Scott D3 on the classical fragment and permits all four information values for `NE(x)`.

## A5 after Gate 6

Distinguish:

```text
A5+ : +P(NE)
A5-T : Pos_T(NE)
```

For the positive T3 branch only `A5+` is required. Once `+G(x)` exists:

```text
+G(x) + A5+ => +NE(x)
```

by `G-sup-v0.1`.

This differs from A3: A3 needs truth-only positivity to activate `T1-T`, whereas A5 needs only positive support once a God-like witness is already available.

A glut `P(NE)=B` can therefore survive the positive T3 branch.

## T3 after Gate 6

Assume:

```text
+◇∃ᴱx G(x)   (Gate 5)
T2+
A5+
G-sup-v0.1
NE-sup-v0.1
S5
```

Then:

```text
T3+ : +□∃ᴱx G(x)
```

The proof obtains at a possible God-like world a witness with `+NE` and `+Ess(G,x)`, hence `+□∃G`; S5 validates the positive support form of `◇□θ => □θ`.

Consequently:

```text
T3+ => GW
```

on the reflexive S5 control frames.

Thus Gate 6 discharges the global-witness interface.

## Modal collapse after Gate 6

Gate 6 sharpens the dependency map dramatically:

```text
T2+ + T3+ + CONST => MC+
MC+ <-> MC-       (Gate 4)
```

Once Godlikeness is positively an essence and God-like witnesses necessarily exist, constant-property embedding turns any current `+χ` into a positively exemplified property of a God-like witness. Positive essence makes that property necessarily shared by all God-like witnesses, and T3 supplies such witnesses at every accessible world.

Therefore `REF+`, `COMP_P`, `CONS_G`, and `R+` are not independent premises of the **essence-compressed collapse theorem** once `T2+` and `T3+` are already available. They belong to one route for deriving T2 from lower-level axioms.

## Updated principal pressure point

The decisive open question is now:

```text
What are the weakest principled four-valued conditions under which T2+ follows
from the primitive Scott-style A1/A4/Godlikeness machinery?
```

The natural support-based essence semantics does not make T2 automatic, and the finite glut/gap countermodels show that this is a genuine semantic obstruction rather than a missing notation choice.
