# Research program

## 1. Main question

The project studies whether the inferential architecture of the Gödel–Scott ontological argument changes in a principled and informative way under a four-valued bilateral modal semantics.

The intended values are represented informationally:

```text
T = (1,0)   positive support only
F = (0,1)   negative support only
B = (1,1)   both positive and negative support
N = (0,0)   neither positive nor negative support
```

The central methodological idea is to avoid treating `B` and `N` as two varieties of ordinary falsity. They encode different structural failures: inconsistency and incompleteness.

## 2. Why Gödel–Scott is a useful test theory

Gödel–Scott is unusually suitable because:

1. it has a compact axiom set;
2. its theorem chain is well studied;
3. modal collapse is a known structural phenomenon;
4. the primitive positivity predicate is philosophically and formally sensitive;
5. essence and necessary existence introduce higher-order modal structure;
6. existing mechanizations provide a classical comparison target.

## 3. Strongest candidate contribution

The first paper-worthy target is not the final existence theorem. It is the relationship among:

- the two directional information flows hidden in Scott's A1;
- positive rigidity from A4;
- derived negative rigidity;
- the positive and negative persistence components of modal collapse.

Let `+φ` mean that `φ` has positive support and `-φ` that it has negative support.

After Gate 3, the informative collapse pair is:

```text
MC+ : +φ => +□φ
MC- : -φ => +□¬φ
```

Using modal duality, the negative clause is equivalently:

```text
MC- : -φ => -◇φ
```

The earlier candidate `-φ => -□φ` is retired because it follows automatically on reflexive frames and therefore cannot diagnose Gödelian modal collapse in the fixed S5 control setting.

Scott A1 is decomposed directionally:

```text
A1-L : -P(φ)  => +P(¬φ)
A1-R : +P(¬φ) => -P(φ)
```

Strong A1 is the conjunction of these directions. It swaps `T/F` and preserves `B/N` under property negation.

The direct A4 lifting is:

```text
R+ : +P(φ) => +□P(φ)
```

Informative negative persistence is:

```text
R-nec- : -P(φ) => +□¬P(φ)
```

and Gate 3 establishes semantically:

```text
A1-L + A1-R + R+ => R-nec-
```

Thus strong A1 is already a channel-coupling principle.

## 4. The local reflection obstruction

The classical modal-collapse spine uses a local move of the form:

```text
G(x), Z(x) => P(Z)
```

At the minimal bilateral interface, even strong A1 together with

```text
D1+ : +G(x) and +P(φ) => +φ(x)
```

does not force

```text
REF+ : +G(x) and +Z(x) => +P(Z)
```

Two distinct obstruction patterns already exist:

- **glut obstruction:** the complement forced by A1 can coexist with `Z(x)` without explosion;
- **gap obstruction:** `P(Z)` and `P(¬Z)` may both lack positive support, so the classical positivity dichotomy is unavailable.

A meta-level recovery of `REF+` requires additional structure, including consistency of the relevant God-like exemplification and completeness of the relevant positivity information.

This means Gate 4 must track consistency/completeness explicitly rather than treating the classical reductio as semantically free.

## 5. Required results before any novelty claim

A strong result should include at least:

- a precise semantics;
- a sound proof system or a carefully delimited semantic study;
- classical recovery under suitable restrictions;
- theorem proofs for positive claims;
- explicit countermodels for non-implications;
- an axiom-minimality or dependency analysis;
- comparison with the standard Scott theory;
- a dedicated prior-art search focused on four-valued/paraconsistent ontological arguments and non-classical positivity predicates.

## 6. Possible result shapes

### Result type A — Decomposition theorem
Classical modal collapse decomposes into distinct universal positive and universal negative persistence conditions under the chosen bilateral semantics.

### Result type B — Separation theorem
There are models satisfying a natural four-valued Gödel–Scott lift in which corrected `MC+` holds but corrected `MC-` fails, or conversely.

### Result type C — Channel-coupling theorem
A natural combination of A1 and A4 forces one persistence channel from the other. Gate 3 already provides a first instance at the level of positivity rigidity.

### Result type D — Reflection-obstruction theorem
The classical `G + Z -> P(Z)` step fails under the minimal paraconsistent/paracomplete lift, with distinct glut and gap countermodels.

### Result type E — Robustness theorem
The existence chain survives specific gluts or gaps in positivity assignments without explosion or triviality.

### Result type F — Failure theorem
A natural-looking four-valued lifting is too strong and recreates classical collapse or otherwise destroys the intended separation. Such a result remains valuable because it identifies the wrong lifting principle.

## 7. Design discipline

Every non-classical axiom must be given an explicit name and version. Do not write "the four-valued version of A4" until the translation has been fixed.

Do not use `-□φ` as a synonym for "φ is necessarily negatively supported". Under the fixed bilateral modal semantics:

```text
-□φ
```

means only that **some** accessible world negatively supports `φ`, whereas universal negative persistence is represented by:

```text
+□¬φ
```

or equivalently:

```text
-◇φ
```

Countermodels are first-class research objects. A failed theorem with a minimal explanatory countermodel is a positive result.
