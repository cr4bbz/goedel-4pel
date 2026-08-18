# Gate 8 — Fitting positivity rigidity and the de-dicto bridge

## Status

**Gate:** 8 — Comparative variants

**Version:** `fitting-rigidity-v0.1`

**Verification:** Lean 4.30.0 + exhaustive two-world finite regression

**Scope:** derive the positive `G`-stability interface used by the minimized Fitting de-dicto theorem

The earlier Fitting minimization result isolated exactly two positive uses of
Godlikeness-extension stability:

```text
Refl_G+:
  target +G -> source +G

Pers_G+:
  source +G -> target +G

STAB_G+ := Pers_G+ + Refl_G+
```

That result showed that full bilateral extension stability is stronger than
the positive theorem needs. It left open whether either positive direction
could be derived from more structural assumptions.

This milestone gives one precise answer.

---

## 1. Fitting-typed admissible rigidity

Define positive rigidity only on the selected extension domain:

```text
RPlusAdm:
  Adm(X)
  + pPos(w,X)
  + w R z
  -> pPos(z,X)
```

This is intentionally not identified with the Scott theory's generic `RPlus`.
Fitting positivity is typed over rigid extensions, and admissible-domain
Godlikeness quantifies only over the selected `Adm` domain.

---

## 2. Reflection is frame-free

Lean proves:

```text
GRealizationAdm + RPlusAdm
-> GPosReflectsAlongRAdm
```

Suppose `w R z` and `x` is positively Godlike at `z`. Every admissible
extension positive at `w` remains positive at `z` by `RPlusAdm`. Target
Godlikeness therefore puts `x` in every such extension, which is exactly
positive Godlikeness at `w`.

No reflexivity, symmetry, or transitivity premise is used.

---

## 3. Persistence uses symmetry

Lean also proves:

```text
GRealizationAdm
+ RPlusAdm
+ Symmetric(R)
-> GPosPersistsAlongRAdm
```

For `w R z`, positive Godlikeness at `w` must consume the extensions positive
at `z`. Symmetry supplies the reverse edge `z R w`, and `RPlusAdm` transports
those positive extensions back to `w`.

Combining both directions gives:

```text
GRealizationAdm
+ RPlusAdm
+ Symmetric(R)
-> STAB_G+
```

Thus the minimized de-dicto theorem has a derived-rigidity form:

```text
minimized admissible Fitting stack
+ RPlusAdm
+ Symmetric(R)
+ possible de-dicto Godlikeness
-> necessary de-dicto Godlikeness
```

The direct theorem with primitive `STAB_G+` remains frame-free. Symmetry
re-enters only when persistence is derived from forward positivity rigidity.

---

## 4. Finite verification and separation

`formal/finite/gate8_fitting_rigidity_bridge.py` exhausts all 256 combinations
of:

```text
two worlds
one entity
all accessibility relations
all positive-support assignments
the negation-closed classical admissible domain {T,F}
```

The distinguished `G` extension is constructed to realize admissible-domain
Godlikeness in every candidate.

The exhaustive counts are:

```text
256 total candidates
152 satisfy RPlusAdm
80 satisfy RPlusAdm + symmetry
```

Every `RPlusAdm` candidate satisfies `Refl_G+`. Every symmetric `RPlusAdm`
candidate additionally satisfies `Pers_G+`.

Two explicit fixtures separate the assumptions:

1. `RPlusAdm` without symmetry can satisfy reflection while persistence fails.
2. Symmetry without `RPlusAdm` need not satisfy either reflection or persistence.

These fixtures establish bounded separation only; they are not global
minimality theorems.

---

## 5. Comparative interpretation

The result exposes an assumption trade-off:

```text
primitive STAB_G+:
  frame-free de-dicto lifting

derived STAB_G+:
  admissible positivity rigidity + symmetry
```

This sharpens the cross-variant comparison. Scott and Anderson use symmetry in
their current necessary-existence return steps. Fitting's de-re theorem remains
frame-free, while the de-dicto route can either assume positive `G` stability
directly or reconstruct it through an admissible positivity-rigidity channel,
in which case symmetry returns.

The theorem is project-specific. It does not claim that Fitting historically
postulated `RPlusAdm`, nor that symmetry is globally necessary for every
possible derivation of `Pers_G+`.

---

## 6. Next questions

1. Can `Pers_G+` be derived without full frame symmetry from a weaker local
   converse-edge condition?
2. Can the rigidity premise be restricted further to only the positively
   supported extensions needed to characterize Godlikeness?
3. Does the profile quotient make either direction of `G` stability automatic?
4. How does the bridge change under paired-neighborhood semantics?
5. Can finite search isolate bounded necessity of the two premises relative to
   a richer non-classical admissible domain containing genuine gluts and gaps?
