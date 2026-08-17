# Gate 8 — Fitting intension/extension boundary

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-types-v0.1`  
**Scope:** type-level infrastructure for a faithful Fitting comparison  
**Verification:** Lean 4.30.0

This milestone does **not** yet formalize the complete Fitting variant. It freezes the semantic distinction that must exist before such a formalization can be scientifically meaningful.

---

## 1. Why the existing `Property` type is insufficient

The Scott-support and Anderson branches currently use one abstract type of intensional properties. That is appropriate for those control theories, but it would erase the central move in Fitting's revision.

The mechanized literature distinguishes:

```text
Extension (delta):       a world-independent property extension over entities
Intension (gamma):       a world-indexed property, yielding an extension at each world
```

Fitting applies the positivity predicate to property **extensions**, whereas Scott and Anderson apply it to intensional properties.

Accordingly, simply renaming the existing project `Property` type would not represent Fitting's theory. The distinction must be enforced by the type checker.

---

## 2. Bilateral project types

The first Lean layer defines a bilateral extension by two independent support predicates:

```text
Extension Entity
  pos : Entity -> Prop
  neg : Entity -> Prop
```

An intension is then:

```text
Intension World Entity := World -> Extension Entity
```

with explicit evaluation

```text
extensionAt : Intension World Entity -> World -> Extension Entity.
```

The operation

```text
rigidify : Extension Entity -> Intension World Entity
```

turns one extension into a constant intension.

This directly mirrors the conceptual distinction between a property's varying intension and an extension rigidly held fixed across worlds, while retaining the project's bilateral positive/negative information channels.

---

## 3. Fitting semantic shell

The new semantic structure deliberately types positivity as

```text
pPos : World -> Extension Entity -> Prop
pNeg : World -> Extension Entity -> Prop
```

rather than

```text
World -> Intension World Entity -> Prop.
```

This is the central Gate-8 safety property: a later Fitting proof cannot accidentally feed an intension directly into the positivity predicate.

The distinguished Godlikeness property remains intensional because whether an individual is Godlike is evaluated at worlds. Its positive extension-level interface is initially:

```text
Fitting.GodPlus M w x :=
  for every extension X,
  if X is positively supported at w,
  then x is positively in X.
```

The distinguished intension `G` realizes that condition through its extension at the current world.

No negative Fitting Godlikeness clause is frozen yet.

---

## 4. Machine-checked boundary facts

Lean proves:

```text
extensionAt (rigidify X) w = X
```

and records that both exemplification and Fitting-style positivity at a world depend only on the extension selected at that world. If two intensions have literally the same extension at `w`, replacing one by the other cannot change those current-world judgments.

These facts are elementary by design. Their role is architectural: they prevent the later theory from collapsing intensions and extensions by notation or implicit coercion.

The implementation is:

```text
formal/lean/Goedel4PEL/GoedelScott/FittingTypes.lean
```

---

## 5. Relation to the source formalization

The source analysis of Scott, Anderson, and Fitting distinguishes extensional properties from intensional properties explicitly and emphasizes that Fitting moves positivity to the extensional side. It also treats this distinction as central to explaining why the Anderson and Fitting variants can avoid modal collapse while remaining closely related.

The present module copies that **typing discipline**, not the source theory wholesale. In particular, it does not yet freeze:

- Fitting's complete Godlikeness definition;
- the extension-level entailment relation used in Fitting essence;
- Fitting necessary existence;
- the de dicto/de re distinctions available in the source IHOML treatment;
- the bilateral negative clauses;
- a modal-collapse countermodel for the four-valued Fitting candidate.

Those are subsequent Gate-8 tasks.

---

## 6. Next construction

The next safe order is:

1. define extension-level necessary entailment;
2. reconstruct the positive Fitting essence interface over extensions;
3. reconstruct necessary existence with the same extension typing;
4. prove classical recovery where appropriate;
5. only then test necessary Godlike existence and modal collapse;
6. compare the result against Anderson's bilateral candidate.

Until those steps are complete, `fitting-types-v0.1` is infrastructure rather than a finished Fitting variant.
