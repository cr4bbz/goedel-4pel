# Conjectures and falsification targets

Every conjecture in this repository should have a corresponding falsification strategy.

## Established Gate-3 through Gate-6 facts

The following are no longer conjectures:

1. `A1-L` and `A1-R` are independent directional clauses.
2. Corrected `MC+` and `MC-` are equivalent under involutive FDE negation.
3. `R+` and `R-nec-` are independent without A1 and interderivable under strong A1.
4. `A1-R + A2+ => T1-T`, where `T1-T` applies to truth-only positivity.
5. Mere `+P(φ)` is insufficient for T1 in the presence of positivity gluts.
6. `A3-T + T1-T` yields positive possible God-like existence.
7. `G-sup-v0.1` discharges `D1+` and `CONST` follows from full higher-order property comprehension.
8. Natural `Ess-sup-v0.1` does **not** make T2 automatic: both a glut and a gap two-world S5 model satisfy the Gate-5 control stack plus strong A1 and `R+` while refuting `T2+`.
9. `A1-L + R+ + G-sup-v0.1 + REG_G => T2+`, with `REG_G := COMP_P^G + CONS_G^G`.
10. `NE-sup-v0.1` recovers the truth-support structure of Scott D3.
11. Only `A5+`, not truth-only `A5-T`, is required for the positive T3 branch once a God-like witness exists.
12. Possible Godlikeness + `T2+ + A5+ + NE-sup + S5` yields `T3+ : +□∃ᴱx G(x)`.
13. `T3+` discharges `GW` on the reflexive S5 control frames.
14. `T2+ + T3+ + CONST => MC+`, and hence `MC-` by Gate 4.
15. A glut `P(NE)=B` can survive the positive T3 branch.

See `docs/POSITIVITY_LIFT.md`, `docs/COLLAPSE_EXPERIMENT.md`, `docs/GODLIKENESS_AND_POSSIBILITY.md`, and `docs/ESSENCE_AND_NECESSARY_EXISTENCE.md`.

## C1 — Bilateral collapse separation — **falsified for the current semantics**

The corrected `MC+` and `MC-` schemata cannot be independent while FDE negation is involutive and the schemata range over all formulas. The conjecture remains retired.

## C2 — A1-driven rigidity coupling — **resolved**

Without A1, `R+` and `R-nec-` are independent. Under strong A1 they are interderivable.

## C3 — Glut/gap asymmetry — **strongly supported, still open globally**

Gluts and gaps now separate at three structurally different points:

```text
REF+ : glut blocks contradiction elimination; gap blocks positivity completeness
T1-T: positivity glut absorbs reductio-generated negative support
T2+ : glut and gap yield distinct finite failures of Godlikeness-as-essence
```

**Remaining falsification target.** Show that after full mechanization or under a more principled essence variant the glut/gap distinction becomes theorem-irrelevant for every remaining result.

## C4 — Non-trivial inconsistent models — **substantially supported**

Gate 6 strengthens the evidence. The positive T3 branch needs only `A5+`. Therefore a glut

```text
P(NE)=B
```

can make a positive God-like witness both `+NE` and `-NE` while the positive T3 derivation still proceeds through the `+NE` component.

This is a concrete instance of inconsistency tolerance rather than merely permission for unused gluts.

**Remaining target.** Machine-check a complete finite model of the positive T3 branch with a controlled glut and verify non-triviality of unrelated formulas.

## C5 — Classical recovery

**Conjecture.** Restricting all relevant formulas to classical values and retaining the frozen actualist/modal assumptions recovers the Scott baseline end-to-end.

**Current evidence.** Gates 1–6 each recover their corresponding classical propositional, modal, positivity, A2/T1, D1, D2, and D3 clauses locally.

**Falsification target.** Exhibit a classical-valued model satisfying the intended lifted assumptions in which the reconstructed T1/T2/T3 chain diverges from Scott.

## C6 — Reflection regularity is route-specific — **refined by Gate 6**

Gate 4 established local minimality of

```text
A1-L + D1+ + CONS_G + COMP_P => REF+
```

relative to that interface vocabulary.

Gate 6 shows that global `CONS_G` and `COMP_P` should not be treated as necessary conditions for all models satisfying T2/T3/collapse. A one-world positive T2/T3 model can contain both an unrelated positivity gap and a controlled God-like glut.

Thus their established status is:

> locally minimal for the Gate-4 reflection route, not globally necessary for modal collapse.

## C7 — Upstream decomposition thesis — **strengthened again**

The current dependency map is:

```text
A1-R -> T1-T / possible G
A1-L -> sufficient T2 recovery route
A5+  -> positive NE obligation once G exists
T2+ + T3+ -> essence-compressed collapse
```

The final collapse schemata remain coupled. The informative variation is concentrated in the pre-collapse theorem chain.

## C8 — Necessary-existence branch supplies `GW` — **resolved positively, conditionally on T2+**

Gate 6 proves:

```text
possible +G
+ T2+
+ A5+
+ NE-sup
+ S5
--------
T3+ : +□∃ᴱx G(x)
--------
GW
```

Thus the necessary-existence branch does supply the global witness interface once positive Godlikeness-as-essence is available.

The conjecture is closed.

## C9 — T2 minimality — **new principal conjecture**

**Conjecture.** The weakest principled recovery of

```text
T2+ : +G(x) => +Ess(G,x)
```

from the primitive four-valued Scott machinery requires two logically distinct controls corresponding to the glut and gap failure modes, but those controls can be weaker than global `REG_G`.

Current sufficient package:

```text
A1-L + R+ + G-sup-v0.1 + COMP_P^G + CONS_G^G => T2+
```

Current countermodels show that dropping the relevant consistency or completeness dimension permits T2 failure.

**Falsification target.** Find a strictly weaker single structural principle that blocks both countermodels and derives T2+, or show that one of the two dimensions can be eliminated entirely under the remaining axioms.

## C10 — Essence robustness

**Conjecture.** The positive Scott theorem chain can survive glutty essence/NE statuses as long as the positive components required by T2 and D3 are preserved.

**Current evidence.** `Ess-sup` and `NE-sup` are bilateral, and the positive T3 proof uses only positive essence and positive NE support.

**Falsification target.** Show that the negative components feed back through A1/A2/A4 in a way that inevitably destroys the positive theorem chain or forces triviality.
