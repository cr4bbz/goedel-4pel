# Gate 8 — Fitting converse positivity rigidity

## Status

**Gate:** 8 — Comparative variants

**Version:** `fitting-converse-rigidity-v0.1`

**Verification:** Lean 4.30.0 + exhaustive two-world finite regression

**Scope:** replace global frame symmetry in the derivation of positive Godlikeness persistence

## 1. The proof-theoretic observation

The earlier bridge derived positive Godlikeness persistence from
`RPlusAdm + Symmetric(R)`. For an edge `w R z`, the proof used symmetry only
to obtain `z R w`, then applied forward positivity rigidity on that reverse
edge.

The reverse edge itself is stronger than the proof needs. The consumed fact is
only the resulting transport of target positivity back to the source:

```text
RPlusConverseAdm:
  Adm(X)
  + w R z
  + pPos(z,X)
  -> pPos(w,X)
```

This condition constrains positivity along existing edges. It does not require
any converse accessibility edge.

## 2. Lean results

Lean proves the implication from the old package:

```text
RPlusAdm + Symmetric(R)
-> RPlusConverseAdm
```

It then proves the sharper persistence theorem:

```text
GRealizationAdm + RPlusConverseAdm
-> GPosPersistsAlongRAdm
```

The proof transports each admissible extension positive at the target back to
the source, where source Godlikeness supplies positive membership. No
reflexivity, symmetry, transitivity, or seriality assumption occurs.

Together with the earlier reflection result:

```text
GRealizationAdm + RPlusAdm + RPlusConverseAdm
-> GPosStableAlongRAdm
```

Consequently the minimized de-dicto possibility-to-necessity theorem has a
frame-free structural form using bidirectional positivity transport rather
than frame symmetry.

## 3. Exhaustive finite evidence

`formal/finite/gate8_fitting_converse_rigidity.py` checks all 256 combinations
of two-world accessibility and positivity assignments over the classical
negation-closed admissible domain `{T,F}`.

The exact counts are:

```text
256 total candidates
152 satisfy RPlusConverseAdm
112 satisfy RPlusAdm + RPlusConverseAdm
80 of those 112 are symmetric
32 of those 112 are asymmetric
```

Every converse-rigidity candidate satisfies positive G-persistence. Every
bidirectional-rigidity candidate satisfies both persistence and reflection.

An explicit asymmetric fixture has one edge `w0 R w1`, no reverse edge, and
non-vacuous positivity that is constant along the edge. It satisfies both
positivity transports and complete positive G-stability. Thus global symmetry
is not necessary even in this bounded fragment.

A second fixture satisfies converse transport without forward transport. It
retains persistence while reflection fails, separating the two directions.

These are bounded separation results, not a claim that converse positivity
rigidity is globally minimal.

## 4. Revised assumption picture

```text
old derived route:
  RPlusAdm + Symmetric(R)
  -> reflection + persistence

new derived route:
  RPlusAdm + RPlusConverseAdm
  -> reflection + persistence
```

The old package implies the new one, but the finite asymmetric fixtures show
that the converse implication fails in the tested family. This identifies the
real de-dicto bridge as bidirectional transport of positive admissible
extensions rather than bidirectionality of the accessibility relation.

## 5. Next questions

1. Can `RPlusConverseAdm` be restricted to extensions actually positive at a
   world with a positive G-witness?
2. Can profile saturation or the proposed quotient semantics derive either
   positivity-transport direction automatically?
3. Does a genuinely four-valued admissible domain with gluts and gaps preserve
   the same strict separation from symmetry?
4. What is the corresponding condition for paired-neighborhood semantics?
