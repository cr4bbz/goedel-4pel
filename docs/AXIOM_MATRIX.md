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
| A2 | closure of positivity under necessary entailment | Which consequence relation is intended? Does closure preserve positive support only? | `A2+`, possible bilateral variants | open |
| A3 | Godlikeness is positive | Is `P(G)` exactly `T`, merely positively supported, or allowed to be `B`? | exact vs support-based positivity | open |
| A4 | positivity is necessary / rigid | Which information about positivity persists universally? | direct `R+`; derived target `R-nec-` | **Gate 3 settled semantically** |
| A5 | necessary existence is positive | Same issue as A3, but downstream effects may be stronger | exact vs support-based positivity | open |
| D1 | definition of Godlikeness | Which properties count when `P(φ)=B` or `N`? | `D1+` only as local interface; final definition deferred | partially analyzed |
| D2 | essence | How do universal/necessary conditions behave under gluts and gaps? | several candidates expected | deferred |
| D3 | necessary existence | What counts as exemplification of every essence? | several candidates expected | deferred |

## A1 after Gate 3

Scott's classical A1 is

```text
¬P(φ) <-> P(¬φ)
```

The earlier attempt to split this into two biconditional channel schemas was redundant under involutive property negation. The independent directional components are now:

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

## A4 after Gate 3

The direct positive-support lifting of Scott A4 is:

```text
R+ : +P(φ) => +□P(φ)
```

The previously considered clause

```text
-P(φ) => -□P(φ)
```

is rejected as an experimental rigidity switch on the fixed S5 control frames: it follows automatically from reflexivity.

The informative negative-persistence target is instead:

```text
R-nec- : -P(φ) => +□¬P(φ)
```

or equivalently:

```text
-P(φ) => -◇P(φ)
```

Gate 3 establishes semantically:

```text
A1-L + A1-R + R+  =>  R-nec-
```

Hence strong A1 couples the negative rigidity channel to the positive A4 channel.

## Corrected modal-collapse targets

For the same reason, the earlier clause

```text
MC-weak : -χ => -□χ
```

is reflexively trivial in S5 and is retired.

The meaningful bilateral pair is:

```text
MC+ : +χ => +□χ
MC- : -χ => +□¬χ
```

with `MC-` equivalently expressible as:

```text
-χ => -◇χ
```

## Local Godlikeness pressure point

The classical proof spine contains:

```text
G(x), Z(x) => P(Z)
```

Using only the local support interface

```text
D1+ : +G(x) and +P(φ) => +φ(x)
```

Gate 3 finds that even **strong A1 + D1+** does not force

```text
REF+ : +G(x) and +Z(x) => +P(Z)
```

because:

- a glut at `Z(x)` tolerates the complement forced by `P(¬Z)`;
- a gap at `P(Z)` leaves neither positivity direction available.

Recovering the classical local step requires additional consistency/completeness structure. This must be tracked explicitly in Gate 4 rather than hidden inside a classical reductio.
