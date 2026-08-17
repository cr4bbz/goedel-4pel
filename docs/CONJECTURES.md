# Conjectures and falsification targets

Every conjecture in this repository should have a corresponding falsification strategy.

## Established Gate-3/4 facts

The following are no longer conjectures:

1. The two **directional** A1 clauses `A1-L` and `A1-R` are independent at the four-valued level.
2. The earlier biconditional `A1+` / `A1-` split is redundant as a schema under involutive property negation.
3. On reflexive frames, `-φ => -□φ` is automatic and therefore is not an informative negative modal-collapse condition.
4. The corrected collapse schemata
   ```text
   MC+ : +φ => +□φ
   MC- : -φ => +□¬φ
   ```
   are equivalent under the current FDE negation.
5. `R+` and informative negative rigidity `R-nec-` are independent without A1.
6. Strong A1 makes `R+` and `R-nec-` interderivable.
7. Strong A1 plus the local support interface `D1+` does not force the classical reflection step `REF+ : +G,+Z => +P(Z)`.
8. At the local abstract interface, `A1-L + D1+ + CONS_G + COMP_P` is sufficient for `REF+`, and each component is individually indispensable relative to the other three.

See `docs/POSITIVITY_LIFT.md` and `docs/COLLAPSE_EXPERIMENT.md`.

## C1 — Bilateral collapse separation — **falsified for the current semantics**

**Original conjecture.** There is a natural four-valued lift of the Scott system in which the corrected persistence principles `MC+` and `MC-` are independent.

**Gate-4 result.** This cannot occur while:

- FDE negation is involutive;
- the schemata range over all formulas;
- `MC-` is the informative universal negative-persistence clause.

Because `-φ` is equivalent to `+¬φ`, `MC-` is just `MC+` instantiated at `¬φ`, and conversely.

The conjecture is therefore retired rather than rescued by changing the semantics ad hoc.

## C2 — A1-driven rigidity coupling — **resolved conditionally**

**Result.** Without A1, `R+` and `R-nec-` are independent. Under strong A1 (`A1-L + A1-R`) they are interderivable.

This identifies A1, not modal collapse itself, as a genuine channel-coupling point.

## C3 — Glut/gap asymmetry for positivity

**Conjecture.** `P(φ)=B` and `P(φ)=N` propagate differently through Godlikeness, possible exemplification, and the reconstructed theorem chain.

**Current evidence.** Gate 3/4 identifies distinct local failure modes for `REF+`: gluts tolerate the complement required by A1, while gaps block the positivity dichotomy itself.

**Falsification target.** Show that the final higher-order semantics makes the two statuses Gödel-equivalent for every relevant theorem.

## C4 — Non-trivial inconsistent models

**Conjecture.** There are models with relevant positivity or exemplification gluts in which the theory remains non-trivial and at least part of the Gödel theorem chain survives.

**Falsification target.** Show that every relevant glut either forces triviality or destroys every existence result once A2, D1, essence, and necessary existence are included.

## C5 — Classical recovery

**Conjecture.** Restricting all relevant formulas to classical values, imposing the required positivity/exemplification regularity, and retaining the appropriate modal constraints recovers the selected Scott baseline.

**Falsification target.** Exhibit a classical-valued model satisfying the intended lifted assumptions in which the theorem chain diverges from the frozen Scott baseline.

## C6 — Reflection assumptions are structurally minimal — **established at the local interface**

At the abstract Gate-4 interface,

```text
A1-L + D1+ + CONS_G + COMP_P => REF+
```

and each assumption has a counterassignment when removed while the other three remain.

**Remaining open refinement.** The full higher-order reconstruction may replace `CONS_G` or `COMP_P` by weaker, more principled conditions. Such a replacement would refine rather than contradict the local minimality result because the result is explicitly relative to the current interface vocabulary.

## C7 — Upstream decomposition thesis

**Conjecture.** In the completed four-valued Scott reconstruction, the most informative non-classical decomposition occurs upstream of modal collapse itself, principally in:

1. positivity-negation transfer;
2. positivity rigidity;
3. consistency/completeness conditions needed for the `G+Z -> P(Z)` reflection bridge;
4. the higher-order witness/property interfaces that connect local reflection to arbitrary modal propositions.

**Falsification target.** Show that after A2, A3, and the final D1 are fixed, these distinctions become semantically redundant or are forced by a substantially smaller common principle.
