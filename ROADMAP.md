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

Comparative variants are in progress.

The project-internal support/exact comparison is frozen as `variants-v0.2` in `docs/GODLIKENESS_VARIANTS.md`:

```text
G-sup+    : +P(phi) -> current +phi(x)
G-exact+  : +P(phi) <-> current +phi(x)
Anderson+ : +P(phi) <-> necessary +phi(x) for the same individual
```

Established comparison results:

- `G-exact+ => G-sup+`;
- `G-exact+ + R+ => T2-exact+` in Lean;
- `G-exact+` remains compatible with genuine gluts;
- finite models separate `G-exact+` and Anderson positive Godlikeness in both directions;
- on reflexive frames Anderson positive Godlikeness implies `G-sup+`;
- the literature-grounded positive Anderson Godlikeness/essence/NE chain is reconstructed in Lean;
- positive Anderson necessary Godlike existence follows from explicit possible Godlikeness plus the Anderson positive stack on the S5 control frames.

A bilateral Anderson candidate is frozen as `anderson-bilateral-v0.1` in `docs/ANDERSON_BILATERAL.md`.

Lean proves classical recovery of its negative-support clauses for:

- fixed-individual necessary exemplification;
- Anderson Godlikeness;
- Anderson essence;
- necessary actual exemplification;
- Anderson necessary existence.

An executable two-world complete-S5 model satisfies the currently encoded bilateral Anderson candidate, including bilateral realization of Godlikeness and necessary existence, while positive necessary Godlike existence holds and positive modal collapse fails for a contingent `Q(a)`.

The Anderson negative clauses are a principled FDE reconstruction, not a claim that Anderson historically specified a unique bilateral semantics.

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
- [x] compare `G-sup-v0.1` with project-internal `G-exact+`;
- [x] compare the Godlikeness/essence bottleneck with a literature-grounded Anderson variant;
- [ ] test additional essence semantics and the Fitting intension/extension split.

## Phase D — Mechanize and publish

### Gate 7 — Mechanization and finite-model verification — **complete**

- [x] finite-model oracle and regression fixtures;
- [x] Lean S5 control theory;
- [x] general T1/T2/T3/GW/collapse theorem spine;
- [x] interface-level classical recovery;
- [x] bounded T2 assumption-minimization search.

Finite exhaustive checks are always reported with their bounded model class; absence of a finite countermodel is not promoted to a general theorem.

### Gate 8 — Comparative variants — **in progress**

- [x] machine-check `G-sup` versus project-internal `G-exact+`;
- [x] show exact positive Godlikeness compresses the T2 recovery route to `G-exact+ + R+`;
- [x] show exact positive Godlikeness remains compatible with gluts;
- [x] source-ground the distinction between `G-exact+`, Anderson, and Fitting;
- [x] formalize a literature-grounded positive Anderson interface;
- [x] reconstruct its positive essence and necessary-existence chain in Lean;
- [x] freeze a bilateral Anderson candidate with classically recovering negative evidence clauses;
- [x] exhibit a bilateral two-world Anderson candidate with necessary Godlike existence and failure of positive modal collapse;
- [ ] decide whether a bilateral negative exact-Godlikeness clause is still scientifically useful after the Anderson comparison;
- [ ] vary K / KB / S4 / S5 and identify the exact frame dependencies of the Anderson and Scott routes;
- [ ] introduce the type-level intension/extension distinction required for a faithful Fitting comparison;
- [ ] rerun selected results over broader paired-neighborhood frames.

### Gate 9 — Publication consolidation

- [ ] perform a dedicated prior-art search for four-valued/paraconsistent Gödel-style ontological arguments and non-classical positivity;
- [ ] audit exact correspondence with the frozen higher-order Scott baseline before final publication claims;
- [ ] write the paper around the strongest verified structural theorem;
- [ ] distinguish semantic theorems, machine-checked results, countermodels, and open global-minimality questions explicitly.
