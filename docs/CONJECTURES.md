# Conjectures and falsification targets

Every conjecture in this repository should have a corresponding falsification strategy.

## Established Gate-3 facts

The following are no longer conjectures:

1. The two **directional** A1 clauses `A1-L` and `A1-R` are independent at the four-valued level.
2. The earlier biconditional `A1+` / `A1-` split is redundant as a schema under involutive property negation.
3. On reflexive frames, `-φ => -□φ` is automatic and therefore is not an informative negative modal-collapse condition.
4. Strong A1 plus `R+` entails informative negative positivity rigidity `R-nec-`.
5. Minimal strong A1 plus the local support interface `D1+` does not force the classical reflection step `REF+ : +G,+Z => +P(Z)`.

See `docs/POSITIVITY_LIFT.md`.

## C1 — Bilateral collapse separation

**Conjecture.** There is a natural four-valued lift of the Scott system in which the corrected persistence principles

```text
MC+ : +φ => +□φ
MC- : -φ => +□¬φ
```

are independent.

**Falsification target.** Show that the accepted Gödel–Scott lift forces `MC+ ↔ MC-`, or that every natural lifting strong enough to recover Scott also couples the channels.

## C2 — A1-driven collapse coupling

**Conjecture.** The two directions of A1 play asymmetric roles in any derivation coupling `MC+` and `MC-`, analogous to the Gate-3 derivation of `R-nec-` from `A1-L + A1-R + R+`.

**Falsification target.** Show that the collapse channels remain coupled or separated independently of which A1 direction is present.

## C3 — Glut/gap asymmetry for positivity

**Conjecture.** `P(φ)=B` and `P(φ)=N` propagate differently through Godlikeness, possible exemplification, and the collapse spine.

**Current evidence.** Gate 3 already identifies distinct local failure modes for `REF+`: gluts tolerate the complement required by A1, while gaps block the positivity dichotomy itself.

**Falsification target.** Show that the final higher-order semantics makes the two statuses Gödel-equivalent for every relevant theorem.

## C4 — Non-trivial inconsistent models

**Conjecture.** There are models with relevant positivity or exemplification gluts in which the theory remains non-trivial and at least part of the Gödel theorem chain survives.

**Falsification target.** Show that every relevant glut either forces triviality or destroys every existence result once A2, D1, essence, and necessary existence are included.

## C5 — Classical recovery

**Conjecture.** Restricting all relevant formulas to classical values, imposing positivity completeness/consistency, and retaining the appropriate modal constraints recovers the selected Scott baseline.

**Falsification target.** Exhibit a classical-valued model satisfying the intended lifted assumptions in which the theorem chain diverges from the frozen Scott baseline.

## C6 — Reflection assumptions are structurally minimal

**Conjecture.** Some form of both (i) consistency of God-like exemplification and (ii) completeness of positivity information is required to recover the classical local reflection step from the minimal A1/D1 support interface.

**Falsification target.** Derive `REF+` in the intended semantics while dropping one of these dimensions, or find a more principled weaker condition that suffices.
