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
| A1 | relation between positivity and property negation | Which direction couples negative support for `P(φ)` to positive support for `P(¬φ)`? | `A1-L`, `A1-R`; strong A1 = both | **Gate 3 settled semantically** |
| A2 | closure of positivity under necessary entailment | Which consequence relation is intended? Does closure preserve positive support only? | `A2+`, possible bilateral variants | **Gate 5 target** |
| A3 | Godlikeness is positive | Is `P(G)` exactly `T`, merely positively supported, or allowed to be `B`? | exact vs support-based positivity | **Gate 5 target** |
| A4 | positivity is necessary / rigid | Which information about positivity persists universally? | direct `R+`; informative `R-nec-` | **Gate 4 dependency map settled** |
| A5 | necessary existence is positive | Same issue as A3, but downstream effects may be stronger | exact vs support-based positivity | open |
| D1 | definition of Godlikeness | Which properties count when `P(φ)=B` or `N`? | `D1+` only as local interface; final definition deferred | **Gate 5 target** |
| D2 | essence | How do universal/necessary conditions behave under gluts and gaps? | several candidates expected | deferred |
| D3 | necessary existence | What counts as exemplification of every essence? | several candidates expected | deferred |

## A1 after Gate 3

Scott's classical A1 is

```text
¬P(φ) <-> P(¬φ)
```

The earlier attempt to split this into two biconditional channel schemas was redundant under involutive property negation. The independent directional components are:

```text
A1-L : -P(φ)  => +P(¬φ)
A1-R : +P(¬φ) => -P(φ)
```

Because each is a schema over all properties, substitution `φ := ¬φ` automatically supplies the mirrored instance.

Strong bilateral A1 is `A1-L + A1-R`, equivalently:

```text
v(P(¬φ)) = swap(v(P(φ)))
```

so:

```text
T <-> F
B <-> B
N <-> N
```

The two directions are independent by finite four-valued assignments; see `docs/POSITIVITY_LIFT.md`.

## A4 after Gates 3–4

The direct positive-support lifting of Scott A4 is:

```text
R+ : +P(φ) => +□P(φ)
```

The previously considered clause

```text
-P(φ) => -□P(φ)
```

is rejected as an experimental rigidity switch on the fixed S5 control frames because it follows automatically from reflexivity.

The informative negative-persistence target is:

```text
R-nec- : -P(φ) => +□¬P(φ)
```

or equivalently:

```text
-P(φ) => -◇P(φ)
```

Gate 4 establishes:

```text
without A1:       R+ and R-nec- are independent
strong A1:        R+ <-> R-nec-
```

The independence is witnessed by two-world S5 countermodels. Thus positivity rigidity genuinely decomposes only before A1 couples the channels.

## Modal-collapse targets after Gate 4

The retired weak clause is:

```text
MC-weak : -χ => -□χ
```

because it is reflexively trivial.

The informative pair is:

```text
MC+ : +χ => +□χ
MC- : -χ => +□¬χ
```

But these are **not independent under the current FDE negation**:

```text
MC+ <-> MC-
```

because `-χ` is equivalent to `+¬χ`, the schemata range over all formulas, and negation is involutive.

Therefore Gate 4 retires the original bilateral-collapse separation conjecture for the current semantics. The project does not alter the semantics merely to preserve that conjecture.

## Local Godlikeness pressure point

The classical proof spine contains:

```text
G(x), Z(x) => P(Z)
```

Using only the local support interface

```text
D1+ : +G(x) and +P(φ) => +φ(x)
```

even **strong A1 + D1+** does not force

```text
REF+ : +G(x) and +Z(x) => +P(Z)
```

because:

- a glut at `Z(x)` tolerates the complement forced by `P(¬Z)`;
- a gap at `P(Z)` leaves neither positivity direction available.

Gate 4 recovers `REF+` from the explicit local package

```text
A1-L + D1+ + CONS_G + COMP_P
```

where:

```text
CONS_G : relevant God-like exemplification is non-glutty
COMP_P : relevant positivity information is complete (+P or -P)
```

Each of these four assumptions is individually indispensable relative to the other three at the abstract interface.

## Conditional collapse package

Two higher-order interfaces remain explicit placeholders:

```text
GW    : every world has a positively supported God-like witness
CONST : every modal proposition χ can be embedded as the constant property λx.χ
```

Then Gate 4 derives at the interface level:

```text
A1-L
+ D1+
+ CONS_G
+ COMP_P
+ R+
+ GW
+ CONST
----------------
MC+
```

and hence `MC-` by the collapse-equivalence theorem.

This is not yet a theorem of the full four-valued Gödel–Scott theory. Gate 5 must determine whether the final lifting of A2, A3, and D1 justifies the required witness and property interfaces or instead changes the dependency picture.
