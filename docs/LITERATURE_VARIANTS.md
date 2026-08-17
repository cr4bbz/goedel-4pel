# Gate 8 — Literature-grounded variant map

## Status

**Role:** source-control note before four-valued Anderson/Fitting lifts  
**Primary comparison source:** Christoph Benzmüller and David Fuenmayor, *Computer-supported Analysis of Positive Properties, Ultrafilters and Modal Collapse in Variants of Gödel's Ontological Argument*, arXiv:1910.08955 / Bulletin of the Section of Logic 49(2), 2020  
**Formal companion:** AFP, *Types, Tableaus and Gödel's God in Isabelle/HOL*

This note prevents the project-internal `G-exact+` experiment from being misidentified with published Anderson or Fitting variants.

---

## 1. Scott control definition

In the intensional Scott theory used as the project baseline:

```text
G_S(x) iff for every intensional property Y,
           P(Y) -> Y(x).
```

The relation between positivity and exemplification is one-way.

This is the classical source shape reconstructed by `G-sup-v0.1` on the positive channel.

---

## 2. Project-internal `G-exact+`

Gate 8 first introduced the deliberately internal comparison:

```text
G-exact+(x) iff for every property Y,
             +Y(x) iff +P(Y).
```

This changes one dimension only: it turns the positive Scott inclusion into equality of positive-support extensions.

It contains no modal operator inside the defining equivalence and does not change the Scott essence definition.

Therefore it is **not Anderson's definition**.

---

## 3. Anderson's variant

The primary comparative formalization reports Anderson's Godlikeness as:

```text
G_A(x) iff for every intensional property Y,
          P(Y) iff Box(Y(x)).
```

Thus Anderson does not merely add the converse of Scott's actual exemplification condition. Positivity is identified with **necessary/essential possession**.

Anderson also changes essence. In the formal presentation:

```text
E_A(Y,x) iff for every Z,
           Box(Z(x)) iff Box(forall^E z, Y(z) -> Z(z)).
```

Unlike Scott's D2, the definition is an equivalence and does not add a separate actual-exemplification conjunct for the candidate essence.

The same comparative source reports that Anderson drops Scott's A1b direction while retaining the direction stating that the negation of a positive property is not positive. The strengthened definitions of Godlikeness and essence are part of the compensation for that change.

The literature analysis also reports a countermodel to modal collapse for Anderson's variant.

### Consequence for this project

A faithful four-valued Anderson lift must vary **at least three dimensions together**:

1. the A1 package;
2. Godlikeness, using necessary exemplification;
3. essence, using the Anderson equivalence.

Replacing only `G-sup` by `G-exact+` is not an Anderson reconstruction.

---

## 4. Fitting's variant

Fitting's change is of a different kind. The comparative formalization distinguishes:

```text
intensional property type: gamma
extensional property type: delta
```

Scott and Anderson let positivity apply to intensional properties. In Fitting's variant, positivity in the Godlikeness definition ranges over **property extensions** instead.

Schematically, the source comparison moves from Scott's:

```text
forall Y_gamma, P(Y) -> Y(x)
```

to Fitting's extensional form:

```text
forall Y_delta, P(Y) -> extension_exemplifies(Y,x).
```

Essence and necessary existence are adapted to the same extensional interpretation.

The comparative analysis reports that modal collapse is not derivable in Fitting's variant and emphasizes the relation between Anderson and Fitting through restricted / rigidly intensionalized positive-property structures.

### Consequence for this project

A faithful Fitting lift cannot be represented merely by changing an axiom over the current undifferentiated `Property` type. Gate 8 first needs an explicit intensional/extensional bridge or a rigidification operator.

---

## 5. Why Anderson is the next better target

The present Lean control semantics already contains:

- intensional properties as a world-indexed semantic interface;
- bilateral modal support;
- actualist quantification;
- necessary positive entailment.

Therefore Anderson is structurally closer to the current machinery than Fitting.

However, two translation choices must be frozen before code:

### A. Necessary exemplification

A positive Anderson clause naturally suggests:

```text
NecEx+(Y,x,w) iff every accessible world positively supports Y(x).
```

But the project must decide explicitly how this interacts with actual existence of `x` at those worlds. Anderson's `Box(Y x)` and the actualist quantifier inside his essence definition play different roles.

### B. Bilateral equivalence

Both Anderson Godlikeness and Anderson essence use classical biconditionals. The project has deliberately avoided silently importing a four-valued object-language conditional.

The lift should therefore begin with named meta-level directional support clauses, not an unexplained four-valued `<->`.

---

## 6. Proposed Anderson subgate

Before proving any theorem, freeze four separate positive-channel interfaces:

```text
NecEx+_A(Y,x,w)
GA-forward : +P(Y) -> NecEx+_A(Y,x,w)
GA-backward: NecEx+_A(Y,x,w) -> +P(Y)
EA-forward / EA-backward for the two directions of Anderson essence
```

Then ask:

1. which directions are needed for Anderson-style T2;
2. whether glut/gap countermodels separate those directions;
3. whether the positive theorem chain still tolerates inconsistent support;
4. where the classical non-collapse result fails or survives under the four-valued lift.

Only after these interfaces are stable should a final bilateral `G_A` / `E_A` definition be frozen.

---

## 7. Fitting subgate after Anderson

For Fitting, introduce an explicit second property layer:

```text
IntensionalProperty
Extension
extensionAt : IntensionalProperty -> World -> Extension
```

and only then lift extensional positivity.

This prevents the project from conflating Fitting's intensional/extensional distinction with the much simpler support/exactness comparison already performed.

---

## 8. Current conclusion

The three notions now have sharply different roles:

```text
G-sup+     : positive properties are positively exemplified
G-exact+   : positive support and positive exemplification coincide
Anderson G : positivity coincides with necessary exemplification
Fitting G  : positivity applies to property extensions rather than intensions
```

`G-exact+` is therefore useful as a controlled intermediate experiment, precisely because it sits between Scott's one-way actual support definition and Anderson's modal exactness without pretending to be either published variant.
