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

Gate 5 establishes:

- bilateral actualist quantifier clauses;
- semantic `NEnt+_E` rather than an object-language conditional;
- `A2+` and truth-only positivity `Pos_T`;
- `A1-R + A2+ => T1-T`;
- a glut countermodel showing mere `+P` does not suffice for T1;
- `A3-T + T1-T => +◇∃ᴱx G(x)`;
- `G-sup-v0.1`, which discharges `D1+`;
- all four values remain possible for Godlikeness;
- full property comprehension discharges `CONST`;
- `GW` remains open after Gate 5.

### Gate 6 status

The essence / necessary-existence reconstruction is frozen as `essence-ne-v0.1` in `docs/ESSENCE_AND_NECESSARY_EXISTENCE.md`.

Gate 6 establishes:

- signed counter-support `NEnt-_E` for necessary entailment;
- bilateral `Ess-sup-v0.1` with classical recovery;
- the positive T2 target
  - `T2+ : +G(x) => +Ess(G,x)`;
- **T2 is not automatic** under the Gate-5 control stack:
  - a two-world S5 glut model satisfies strong A1, `A2+`, `A3-T`, `R+`, and `G-sup-v0.1` while refuting `T2+`;
  - a second two-world S5 gap model does the same;
- relevant God-like regularity
  - `COMP_P^G`
  - `CONS_G^G`
  - `REG_G := COMP_P^G + CONS_G^G`;
- a sufficient T2 recovery theorem:
  - `A1-L + R+ + G-sup-v0.1 + REG_G => T2+`;
- bilateral `NE-sup-v0.1` with classical recovery;
- A5 splits into weak `A5+` and stronger `A5-T`;
- **only `A5+` is required** for the positive T3 branch once a God-like witness exists;
- from Gate-5 possible Godlikeness plus `T2+ + A5+ + NE-sup + S5`:
  - `T3+ : +□∃ᴱx G(x)`;
- `T3+` discharges `GW` on reflexive S5 frames;
- an essence-compressed collapse theorem:
  - `T2+ + T3+ + CONST => MC+`
  - hence `MC-` by Gate 4;
- `P(NE)=B` can coexist with the positive T3 branch, giving a concrete inconsistency-tolerance result;
- global `CONS_G` / `COMP_P` are not necessary conditions for every model satisfying the positive T2/T3/collapse chain; they are sufficient ingredients of one lower-level recovery route.

The decisive unresolved semantic question is now the weakest principled recovery of `T2+` from the primitive four-valued Scott machinery.

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
- [ ] minimize the T2 recovery assumptions beyond `REG_G`;
- [ ] compare `G-sup-v0.1` with `G-exact`;
- [ ] test whether alternative essence semantics preserve the same T2 obstruction.

## Phase D — Mechanize and publish

### Gate 7 — Mechanization and finite-model verification

- [ ] implement the settled four-valued kernel, modal clauses, quantifiers, `G-sup`, `Ess-sup`, and `NE-sup` in Lean and/or a small executable model checker;
- [ ] machine-check Gate-3/4 A1 and rigidity results;
- [ ] machine-check T1-T and its glut countermodel;
- [ ] machine-check both Gate-6 T2 countermodels;
- [ ] machine-check the conditional T2, T3, GW, and modal-collapse theorems;
- [ ] verify classical recovery end-to-end.

### Gate 8 — Comparative variants

- [ ] compare `G-sup` with `G-exact`;
- [ ] compare at least one Anderson/Fitting-style variant;
- [ ] vary K / KB / S4 / S5 after the S5 control theory is mechanized;
- [ ] rerun selected results over broader paired-neighborhood frames.

### Gate 9 — Publication consolidation

- [ ] perform a dedicated prior-art search for four-valued/paraconsistent Gödel-style ontological arguments and non-classical positivity;
- [ ] write the paper around the strongest verified structural theorem;
- [ ] distinguish semantic theorems, machine-checked results, countermodels, and open minimality questions explicitly.
