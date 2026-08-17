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

The kernel deliberately does **not** adopt an object-language four-valued implication. Signed `+/-` propagation principles remain metalanguage constraints.

### Gate 2 status

The modal layer is frozen as `modal-v0.1` in `docs/MODAL_LIFT.md`.

The control semantics is bilateral relational Kripke semantics, with Scott S5 frames fixed through the first reconstruction experiments. Paired-neighborhood generalization remains a later experimental axis.

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
- local reflection is recovered from `A1-L + D1+ + CONS_G + COMP_P`;
- each member of that package is locally indispensable;
- adding `R+ + GW + CONST` yields the interface-level collapse theorem.

### Gate 5 status

The Godlikeness / possibility reconstruction is frozen as `godlike-v0.1` in `docs/GODLIKENESS_AND_POSSIBILITY.md`.

Gate 5 establishes:

- bilateral actualist quantifier clauses while keeping existence itself classical at the metalanguage level;
- semantic necessary positive entailment `NEnt+_E` instead of an object-language conditional;
- `A2+ : +P(φ) and NEnt+_E(φ,ψ) => +P(ψ)`;
- truth-only positivity
  - `Pos_T(φ) := +P(φ) and not(-P(φ))`;
- a four-valued T1 theorem
  - `A1-R + A2+ => T1-T`
  - `T1-T : Pos_T(φ) => +◇∃ᴱx φ(x)`;
- mere `+P(φ)` does not suffice for T1, witnessed by a one-world empty-actual-domain model with glutty positivity;
- A3 splits into
  - weak `A3+ : +P(G)`
  - Scott-control `A3-T : Pos_T(G)`;
- `A3-T + T1-T` yields `+◇∃ᴱx G(x)` without globally banning positivity gluts;
- support-based Godlikeness `G-sup-v0.1` is frozen:
  - `+G(x)` iff every `+P(φ)` is `+φ(x)`;
  - `-G(x)` iff some `+P(φ)` is `-φ(x)`;
- `G-sup-v0.1` recovers classical D1 and discharges the Gate-4 `D1+` interface;
- all four values `T/F/B/N` remain possible for Godlikeness;
- full intensional property comprehension/lambda abstraction discharges `CONST`;
- `GW` is **not** discharged: Gate 5 proves only possible God-like existence, not a witness at every world;
- `COMP_P` is not implied by strong A1 because `N/N` positivity gaps remain possible;
- `CONS_G` is not implied by support-based Godlikeness.

Remaining implementation checks are deferred to mechanization:

- [ ] machine-check the T1-T proof and glut countermodel;
- [ ] machine-check classical recovery of the actualist quantifier and `G-sup` clauses;
- [ ] compare `G-sup-v0.1` with the later `G-exact` variant.

These checks do not block Gate 6.

## Phase B — The key experiment

- [x] split A1 into independent directional components;
- [x] isolate direct and informative negative positivity-rigidity channels;
- [x] correct the bilateral `MC+` / `MC-` targets;
- [x] prove the corrected collapse schemata equivalent under FDE negation;
- [x] separate the rigidity channels without A1 by finite S5 countermodels;
- [x] prove strong A1 recouples the rigidity channels;
- [x] identify and locally minimize the `REF+` assumption package;
- [x] state the conditional interface-level collapse theorem.

## Phase C — Reconstruct Gödel–Scott

- [x] lift the positivity predicate and A1/A4 interfaces;
- [x] lift A2 for the Scott-control branch;
- [x] split and select the A3 control lifting;
- [x] freeze `G-sup-v0.1` as the control Godlikeness definition;
- [x] reconstruct truth-only positive-property exemplification (`T1-T`);
- [x] reconstruct possible God-like existence from `A3-T`;
- [x] justify `CONST` from higher-order comprehension;
- [ ] derive or refute the global witness interface `GW` via the essence / necessary-existence branch;
- [ ] lift `Ess`;
- [ ] lift `NE` and A5;
- [ ] classify the status of `□∃ᴱx G(x)`;
- [ ] determine whether any natural later axiom supplies principled substitutes for `CONS_G` or `COMP_P`.

## Phase D — Mechanize and publish

- [ ] Implement settled semantics in Lean.
- [ ] Add model/countermodel tests.
- [ ] Verify classical recovery.
- [ ] Compare at least one non-Scott variant.
- [ ] Re-run the rigidity/collapse analysis over broader relational and paired-neighborhood frame classes.
- [ ] Write paper around the strongest structural theorem.
