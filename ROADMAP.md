# Roadmap

## Phase A — Semantics before proof automation

- [x] Freeze the exact Scott baseline.
- [x] Fix notation for positive/negative satisfaction.
- [x] Fix the four information values and designated values.
- [x] Choose the consequence relation.
- [x] Define propositional connectives.
- [x] Define `□` and `◇` in positive/negative channels.
- [x] State the classical-recovery fragment.

### Gate 1 status

The propositional kernel is frozen as `kernel-v0.1` in `docs/FOUR_VALUED_KERNEL.md`.

### Gate 2 status

The modal layer is frozen as `modal-v0.1` in `docs/MODAL_LIFT.md`. The control semantics is bilateral relational S5, with paired-neighborhood generalization deferred.

### Gate 3 status

The positivity decomposition is frozen as `positivity-v0.1` in `docs/POSITIVITY_LIFT.md`.

Main results:

- independent directional A1 clauses `A1-L` and `A1-R`;
- direct rigidity `R+` and informative negative rigidity `R-nec-`;
- strong A1 couples the rigidity channels;
- gluts and gaps obstruct the classical `G+Z -> P(Z)` bridge differently.

### Gate 4 status

The collapse dependency analysis is frozen as `collapse-v0.1` in `docs/COLLAPSE_EXPERIMENT.md`.

Main results:

- corrected `MC+` and `MC-` are equivalent under involutive FDE negation;
- rigidity channels are independent without A1 and coupled by strong A1;
- a four-part regularity package recovers the local reflection route;
- `R+ + GW + CONST` then yields the interface-level collapse theorem.

### Gate 5 status

The Godlikeness / possibility reconstruction is frozen as `godlike-v0.1` in `docs/GODLIKENESS_AND_POSSIBILITY.md`.

Gate 5 establishes bilateral actualist quantification, semantic `NEnt+_E`, `A2+`, truth-only positivity, `T1-T`, `A3-T`, possible positive God-like existence, and `G-sup-v0.1`.

### Gate 6 status

The essence / necessary-existence reconstruction is frozen as `essence-ne-v0.1` in `docs/ESSENCE_AND_NECESSARY_EXISTENCE.md`.

Gate 6 establishes the bilateral essence/NE semantics, glut and gap countermodels to automatic `T2+`, the sufficient recovery package `REG_G`, conditional positive T3, discharge of `GW`, and the essence-compressed collapse theorem.

### Gate 7 status

Formal verification is frozen as `formal-v0.1` in `docs/FORMAL_VERIFICATION.md`.

Gate 7 establishes with green CI:

- Lean 4.30.0 formalization of the current bilateral S5 control theory;
- general machine proofs of schema-level `MC+ <-> MC-`, `T1-T`, conditional `T2+`, conditional `T3+`, `T3+ => GW`, and essence-compressed positive collapse;
- interface-level classical recovery of `Pos_T`, `NEnt`, Godlikeness, essence, and necessary existence;
- executable T1/T2 glut-gap countermodels;
- a broader exhaustive two-world / one-entity `G,Z` search with 873 full-antecedent models, all satisfying `T2+`;
- bounded individual indispensability of `A1-L`, `R+`, `COMP_P^G`, and `CONS_G^G` in that family.

The bounded indispensability result is not promoted to a global model-theoretic minimality theorem.

### Gate 8 status

The first comparative Godlikeness result is frozen in `docs/GODLIKENESS_VARIANTS.md` as `variants-v0.1`.

A project-internal positive exactness candidate is defined by:

```text
G-exact+(x): +phi(x) iff +P(phi), for every property phi.
```

It is deliberately not identified with Anderson or Fitting before a literature-grounded comparison.

Gate 8 already establishes:

- `G-exact+ => G-sup+`;
- both Gate-6 T2 countermodels are support-Godlike but fail exact positive Godlikeness;
- exact positive Godlikeness internalizes the positive reflection step;
- general Lean theorem:
  - `G-exact+ + R+ => T2-exact+`;
- `A1-L`, `COMP_P^G`, and `CONS_G^G` are not premises of that exact-positive T2 route;
- an executable exact-positive model retains genuine `B` gluts, so the comparison does not restore bivalence.

This shows that the T2 bottleneck is definition-sensitive: `G-sup` leaves reflection to be derived, whereas `G-exact+` builds its positive direction into Godlikeness.

## Phase B — The key experiment

- [x] split A1 into independent directional components;
- [x] isolate positivity-rigidity channels;
- [x] correct and classify modal-collapse channels;
- [x] prove collapse-channel equivalence under FDE negation;
- [x] identify local glut/gap reflection failures;
- [x] reconstruct possible God-like existence;
- [x] identify T2 as the later glut/gap bottleneck;
- [x] reconstruct T3 conditionally from positive T2;
- [x] derive the essence-compressed modal-collapse theorem.

## Phase C — Reconstruct Gödel–Scott

- [x] lift the positivity predicate and A1/A4 interfaces;
- [x] lift A2 for the Scott-control branch;
- [x] split and select the A3 control lifting;
- [x] freeze `G-sup-v0.1`;
- [x] reconstruct `T1-T` and possible God-like existence;
- [x] freeze `Ess-sup-v0.1`;
- [x] show T2 is not automatic and isolate a sufficient recovery package;
- [x] freeze `NE-sup-v0.1` and lift A5;
- [x] reconstruct `T3+` conditionally from `T2+`;
- [x] discharge `GW`;
- [x] classify the positive collapse consequence of `T2+ + T3+`;
- [ ] minimize the support-theory T2 recovery assumptions at the unbounded model-theoretic level;
- [x] begin the `G-sup-v0.1` versus `G-exact+` comparison;
- [ ] test whether alternative essence semantics preserve the same T2 obstruction.

## Phase D — Mechanize and publish

### Gate 7 — Mechanization and finite-model verification — **complete**

- [x] finite-model oracle and regression fixtures;
- [x] Lean S5 control theory;
- [x] general T1/T2/T3/GW/collapse theorem spine;
- [x] interface-level classical recovery;
- [x] bounded T2 assumption-minimization search.

Finite exhaustive checks are always reported with their bounded model class; absence of a finite countermodel is not promoted to a general theorem.

### Gate 8 — Comparative variants — **in progress**

- [x] define and machine-check the first `G-sup` versus project-internal `G-exact+` comparison;
- [x] show exact positive Godlikeness compresses the T2 recovery route to `G-exact+ + R+`;
- [x] show exact positive Godlikeness remains compatible with gluts;
- [ ] freeze a principled bilateral negative clause for exact Godlikeness, if one survives comparison;
- [ ] compare the internal candidate with Anderson/Fitting literature variants before naming any correspondence;
- [ ] compare at least one literature-grounded Anderson/Fitting-style variant;
- [ ] vary K / KB / S4 / S5;
- [ ] rerun selected results over broader paired-neighborhood frames.

### Gate 9 — Publication consolidation

- [ ] perform a dedicated prior-art search for four-valued/paraconsistent Gödel-style ontological arguments and non-classical positivity;
- [ ] audit exact correspondence with the frozen higher-order Scott baseline before final publication claims;
- [ ] write the paper around the strongest verified structural theorem;
- [ ] distinguish semantic theorems, machine-checked results, countermodels, and open global-minimality questions explicitly.
