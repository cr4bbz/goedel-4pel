# Gate 8 — Bilateral Fitting extensional semantics

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-ext-v0.1`  
**Scope:** extension-level entailment, positive essence, necessary existence, and de-re possibility-to-necessity  
**Verification:** Lean 4.30.0

This milestone extends the type boundary frozen in `docs/FITTING_TYPES.md`. It remains a project-specific bilateral reconstruction around the literature-grounded Fitting architecture; it is not yet a complete line-for-line translation of the Isabelle/HOL development.

---

## 1. Source-level distinction

The Fitting formalization distinguishes intensional properties from their extensions. Positivity is applied to an extensional property, and the source entailment relation is between rigid extensions:

```text
X V Y := Box forall^E z. X(z) -> Y(z)
```

Fitting essence is likewise extension-level:

```text
E(Y,x) := Y(x) and forall Z. Z(x) -> Y V Z.
```

Necessary existence quantifies over those extensional essences.

The source development also distinguishes de-re and de-dicto readings of possible and necessary Godlike existence. This project preserves that distinction explicitly rather than identifying the two by notation.

---

## 2. Bilateral extension negation

For a bilateral extension `X`:

```text
X.pos : Entity -> Prop
X.neg : Entity -> Prop
```

FDE negation is defined by swapping the channels:

```text
negate(X).pos = X.neg
negate(X).neg = X.pos.
```

Lean proves involutivity.

---

## 3. Extension-level necessary entailment

Positive Fitting entailment is:

\[
Entail_F^+(X,Y,w)
\]

iff every accessible actual positive member of the rigid extension `X` is a positive member of the rigid extension `Y`:

```text
for every z with wRz,
for every actual x at z,
X.pos(x) -> Y.pos(x).
```

Negative evidence is explicit counter-support:

```text
some accessible actual x satisfies X.pos(x) and Y.neg(x).
```

As elsewhere in the project, negative support is not defined as mere metalanguage failure of the positive clause.

---

## 4. Fitting A1/A2 interfaces

The positivity predicate is typed over extensions. The current bilateral interfaces are:

```text
A1-L_F : -P(X)     -> +P(negate X)
A1-R_F : +P(negate X) -> -P(X)
```

and

```text
A2+_F : +P(X) and Entail_F+(X,Y) -> +P(Y).
```

No four-valued object-language implication is introduced.

---

## 5. Bilateral extensional essence and necessary existence

Positive Fitting essence is:

\[
Ess_F^+(X,x,w)
\]

iff

1. `X.pos(x)`, and
2. every rigid extension `Y` with `Y.pos(x)` is positively necessarily entailed by `X`.

Negative essence support is generated either by negative membership in `X` or by an explicit positive `Y`-membership witnessing negative entailment evidence.

Positive necessary existence is:

```text
NE_F+(x,w):
  every positive Fitting essence X of x
  has an actual positive X-member at every accessible world.
```

The negative clause records an essence together with an accessible world at which every actual entity negatively belongs to that extension.

---

## 6. Four-valued Fitting essence theorem

The current extension-level Godlikeness interface is:

```text
God_F+(x,w):
  for every rigid extension X,
  +P(X)@w -> X.pos(x).
```

The distinguished intensional `G` realizes this condition through its extension at each world.

For relevant positively possessed extensions define:

```text
COMP_P^G(ext):
  God_F+(x,w) and Y.pos(x)
  -> +P(Y) or -P(Y)

CONS_G^G(ext):
  God_F+(x,w) and Y.pos(x)
  -> not Y.neg(x)
```

and let `REG_G(ext)` be their conjunction.

Lean proves generally:

```text
GRealization
+ A1-L_F
+ REG_G(ext)
-----------------------------
God_F+(x,w)
-> Ess_F+(extensionAt(G,w), x, w)
```

### Structural contrast with Scott

There is **no `R+` premise**.

This is not an accidental proof shortening. Scott's support-based essence theorem must transport positive support for an intensional property from the current world to accessible worlds. Fitting entailment instead freezes the current extensions `X` and `Y` as rigid extensional objects. Once local reflection recovers `+P(Y)@w`, any positive member of the frozen current `G` extension is Godlike at the same world `w` and therefore belongs positively to `Y`; no positivity transport to the accessible evaluation world is required.

This theorem is machine-checked in:

```text
formal/lean/Goedel4PEL/GoedelScott/FittingSemantics.lean
```

The regularity package is a project four-valued recovery device. It must not be attributed to Fitting's classical theory, where classical complement reasoning supplies stronger information automatically.

---

## 7. Fitting necessary existence and A5

Let an intensional property `NE` realize the positive Fitting necessary-existence condition at every world:

```text
extensionAt(NE,w).pos(x) iff NE_F+(x,w).
```

Positive A5 is typed extensionally:

```text
A5+_F : +P(extensionAt(NE,w)) @ w.
```

Therefore every positive Fitting-Godlike individual positively belongs to the current extension of `NE` and, by realization, satisfies positive necessary existence.

---

## 8. De-re possibility and necessity

The source formalization distinguishes two readings. The project follows that distinction.

### De-re possible current God extension

At world `w`:

```text
PossibleCurrentGodExtension(w):
  some accessible world z has an actual entity x
  that belongs positively to extensionAt(G,w).
```

The extension is frozen at `w`; it is not re-evaluated at `z`.

### De-re necessary current God extension

```text
NecessaryCurrentGodExtension(w):
  every accessible world z has an actual positive member
  of extensionAt(G,w).
```

Lean proves:

```text
GRealization
+ A1-L_F
+ REG_G(ext)
+ NERealization
+ A5+_F
+ PossibleCurrentGodExtension(w)
--------------------------------
NecessaryCurrentGodExtension(w)
```

No reflexivity, symmetry, transitivity, seriality, or positivity-rigidity premise occurs.

### Proof spine

1. De-re possibility supplies an entity belonging to the frozen current `G` extension.
2. `GRealization` turns that membership into possibilist positive Fitting Godlikeness at the current world.
3. A5 makes the individual a positive member of the current `NE` extension.
4. `NERealization` gives positive Fitting necessary existence.
5. The extension-level essence theorem makes the current `G` extension an essence of the individual.
6. Necessary existence therefore supplies an actual member of that same frozen `G` extension at every accessible world.

The theorem is machine-checked in:

```text
formal/lean/Goedel4PEL/GoedelScott/FittingNecessaryExistence.lean
```

This is the project's bilateral positive counterpart of the K-level de-re possibility-to-necessity route reported in the source formalization.

---

## 9. What remains open

The following are intentionally not collapsed into the result above:

1. **de-dicto necessary Godlikeness**, where `G` is re-evaluated at each accessible world;
2. the exact four-valued analogue of Fitting positivity stability / A4;
3. classical recovery theorems for all new bilateral Fitting negative clauses;
4. an executable four-valued Fitting modal-collapse countermodel;
5. exact correspondence with the Isabelle/HOL definitions and the multiple de-re/de-dicto formulations used there.

The source formalization itself emphasizes that the de-re and de-dicto formulations are not interchangeable and provides countermodels for some tempting equivalences. This project therefore keeps the channels separate from the outset.

---

## 10. Comparative interpretation

The three main branches now expose three different ways of supplying the information needed by essence and necessary existence:

```text
Scott-support:
  intensional positive possession
  + later reflection / rigidity resources

Anderson:
  positivity iff necessary possession of the same individual
  + modified essence

Fitting:
  positivity of rigid extensions
  + extension-level entailment / essence
```

The current Lean results sharpen the comparison:

```text
Scott T2 recovery uses R+ in the verified support route.
G-exact+ T2 uses R+ but internalizes local reflection.
Fitting extensional essence uses neither R+ nor a modal frame condition.
Fitting de-re possibility -> necessity likewise uses no frame condition.
```

This does not make the systems globally ordered by strength. It identifies where each architecture stores the information that later proofs consume.
