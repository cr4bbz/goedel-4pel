# Gate 8 — Fitting intension/extension boundary

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-types-v0.1`  
**Scope:** type-level infrastructure for the Fitting comparison  
**Verification:** Lean 4.30.0  
**Follow-up:** extended by `docs/FITTING_BILATERAL.md`

This file records the initial Gate-8 type boundary. The substantive bilateral Fitting candidate is now frozen separately in `FITTING_BILATERAL.md`.

---

## 1. Why one property type is insufficient

The Scott-support and Anderson branches use one abstract type of intensional properties. Fitting instead makes the intension/extension distinction part of the logical architecture and applies positivity to extensions.

The project therefore enforces:

```text
Extension Entity
  pos : Entity -> Prop
  neg : Entity -> Prop

Intension World Entity := World -> Extension Entity
```

with explicit evaluation:

```text
extensionAt : Intension World Entity -> World -> Extension Entity
```

and rigidification:

```text
rigidify : Extension Entity -> Intension World Entity.
```

This prevents later proofs from silently identifying an intension with one of its extensions.

---

## 2. Fitting positivity is extension-typed

The Fitting semantic shell types positivity as:

```text
pPos : World -> Extension Entity -> Prop
pNeg : World -> Extension Entity -> Prop
```

rather than over intensions. Positive exemplification of an intension at a world first evaluates its current extension.

Lean machine-checks the basic bridge facts, including:

```text
extensionAt (rigidify X) w = X
```

and congruence of current-world exemplification/positivity under identical current extensions.

---

## 3. What changed after this milestone

The initial next-step plan was to quantify Fitting Godlikeness, essence, and regularity over every inhabitant of the bilateral `Extension` type. Gate 8 subsequently discovered that this unrestricted domain is too strong for the intended recovery route.

The type contains a universal glut extension that places every entity in both support channels. Lean now proves that unrestricted relevant exemplification consistency implies the absence of any positive Fitting-Godlike individual:

```text
ConsGG -> forall w x, not GodPlus w x
RegG   -> forall w x, not GodPlus w x
```

The substantive Fitting candidate therefore uses a selected, FDE-negation-closed domain of admissible extensions rather than unrestricted bilateral comprehension. This does **not** globally prohibit glutty extensions.

The follow-up development in `FITTING_BILATERAL.md` now includes:

- extension-level signed entailment;
- bilateral extensional essence and necessary existence;
- a non-vacuous admissible-domain T2 analogue without `R+`;
- classical recovery of signed Fitting interfaces;
- a frame-free de-re possibility-to-necessity theorem;
- an explicit `STAB_G` bridge for de-dicto lifting;
- a finite de-re/de-dicto separation model;
- a complete-S5 necessary-God / no-positive-collapse model that still admits genuine `B` information.

Thus `fitting-types-v0.1` remains the architectural foundation, but it is no longer the current scientific frontier.
