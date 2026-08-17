# Conjectures and falsification targets

Every conjecture in this repository should have a corresponding falsification strategy.

## Established Gate-3/4/5 facts

The following are no longer conjectures:

1. The directional A1 clauses `A1-L` and `A1-R` are independent.
2. The earlier biconditional A1 split is redundant under involutive property negation.
3. On reflexive frames, `-φ => -□φ` is automatic and not an informative collapse condition.
4. The corrected collapse schemata
   ```text
   MC+ : +φ => +□φ
   MC- : -φ => +□¬φ
   ```
   are equivalent under the current FDE negation.
5. `R+` and `R-nec-` are independent without A1 and interderivable under strong A1.
6. `A1-L + D1+ + CONS_G + COMP_P` is locally sufficient and minimal for `REF+` relative to the Gate-4 interface vocabulary.
7. Gate 5 reconstructs truth-only positive-property exemplification:
   ```text
   A1-R + A2+ => T1-T
   T1-T : Pos_T(φ) => +◇∃ᴱx φ(x)
   ```
8. Mere `+P(φ)` is insufficient for T1 in the presence of positivity gluts.
9. `A3-T + T1-T` yields positive support for possible God-like existence.
10. `G-sup-v0.1` discharges `D1+` and recovers Scott D1 on the classical fragment.
11. Higher-order lambda abstraction/comprehension discharges `CONST`.
12. Gate 5 does not discharge `GW`, `COMP_P`, or `CONS_G`.

See `docs/POSITIVITY_LIFT.md`, `docs/COLLAPSE_EXPERIMENT.md`, and `docs/GODLIKENESS_AND_POSSIBILITY.md`.

## C1 — Bilateral collapse separation — **falsified for the current semantics**

The corrected `MC+` and `MC-` schemata cannot be independent while FDE negation is involutive and the schemata range over all formulas. The conjecture is retired rather than rescued by changing the semantics ad hoc.

## C2 — A1-driven rigidity coupling — **resolved conditionally**

Without A1, `R+` and `R-nec-` are independent. Under strong A1 they are interderivable. A1 is therefore a genuine channel-coupling point.

## C3 — Glut/gap asymmetry for positivity — **strengthened by Gate 5**

**Conjecture.** `P(φ)=B` and `P(φ)=N` continue to propagate differently through the completed theorem chain.

**Current evidence.** Gluts and gaps already differ twice:

- at `REF+`, gluts defeat contradiction elimination while gaps defeat positivity completeness;
- at T1, a positivity glut can absorb the negative support produced by the classical reductio, so mere `+P(φ)` does not force possible exemplification, whereas truth-only positivity does.

**Falsification target.** Show that the essence / necessary-existence branch later makes the two statuses equivalent for every Gödel-relevant conclusion.

## C4 — Non-trivial inconsistent models — **partially supported**

**Conjecture.** Relevant positivity or exemplification gluts can coexist with non-trivial portions of the Gödel–Scott chain.

**Gate-5 evidence.** The semantics does not globally forbid positivity gluts. Instead, `T1-T` restricts the classical exemplification theorem to truth-only positive properties, leaving glut-positive properties available for robustness analysis.

**Falsification target.** Show that A5, essence, or necessary existence forces every relevant positivity glut either to disappear or to trivialize the later theory.

## C5 — Classical recovery

**Conjecture.** Restricting all relevant formulas to classical values and retaining the frozen actualist/modal assumptions recovers the Scott baseline.

**Current evidence.** Gates 1–5 individually recover their classical propositional, modal, A1/A4, A2/T1, and D1 fragments.

**Falsification target.** Exhibit a classical-valued model satisfying the intended lifted assumptions in which the reconstructed theorem chain diverges from Scott.

## C6 — Reflection assumptions are structurally minimal — **established at the local interface**

At the Gate-4 interface:

```text
A1-L + D1+ + CONS_G + COMP_P => REF+
```

and each assumption has a counterassignment when removed.

**Gate-5 refinement.** `D1+` is now derived from `G-sup-v0.1`, but neither `CONS_G` nor `COMP_P` follows from that definition. Their status therefore remains genuinely open rather than being an artifact of the temporary D1 interface.

## C7 — Upstream decomposition thesis — **strengthened**

**Conjecture.** The informative four-valued decomposition of Scott occurs upstream of modal collapse itself.

Gate 5 adds a new asymmetric division of labor:

```text
A1-R -> T1-T / possible exemplification
A1-L -> REF+ / local positivity reflection
```

This gives the two A1 directions distinct proof-theoretic roles even though strong A1 later couples rigidity.

**Falsification target.** Show that the essence / necessary-existence reconstruction collapses these distinctions into a substantially smaller common principle.

## C8 — Necessary-existence branch supplies `GW`

**Conjecture.** A natural truth-support lifting of Scott's D2, D3, and A5 yields an analogue of T3 strong enough to discharge the Gate-4 global witness interface:

```text
GW : every world has some +G witness
```

**Falsification target.** Produce a model satisfying the natural Gate-6 lift in which possible God-like existence survives but no globally necessary positive God-like witness supply follows.

This is the principal target for Gate 6.
