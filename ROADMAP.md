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

The decisive unresolved semantic question after Gate 6 is the weakest principled recovery of `T2+` from the primitive four-valued Scott machinery.

### Gate 7 status

Formal verification is frozen as `formal-v0.1` in `docs/FORMAL_VERIFICATION.md`.

Gate 7 establishes with green CI:

- a standard-library-only finite-model oracle and regression suite;
- Lean 4.30.0 formalizations of the four-valued carrier, FDE negation, conjunction/disjunction, bilateral relational modality, and bilateral actualist quantification;
- general Lean semantics for `NEnt±_E`, `G-sup-v0.1`, `Ess-sup-v0.1`, and the positive `NE-sup` interface;
- a general machine proof of schema-level `MC+ <-> MC-`;
- a general machine proof of `A1-R + A2+ => T1-T`;
- an executable one-world glut countermodel to unrestricted `+P => +◇∃ᴱ`;
- general machine proof of
  - `NegExemplification + G-sup + A1-L + R+ + REG_G => T2+`;
- executable glut and gap T2 countermodels;
- general machine proofs of conditional `T3+`, `T3+ => GW`, and the essence-compressed positive collapse theorem;
- interface-level classical recovery for `Pos_T`, `NEnt`, Godlikeness, essence, and necessary existence;
- a broader exhaustive two-world / one-entity `G,Z` search with 873 full-antecedent models, all satisfying `T2+`;
- bounded individual indispensability: dropping any one of `A1-L`, `R+`, `COMP_P^G`, or `CONS_G^G` yields a T2 countermodel in that same family.

The bounded indispensability result is not promoted to a global model-theoretic minimality theorem.

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
- [ ] minimize the T2 recovery assumptions beyond `REG_G` at the unbounded model-theoretic level;
- [ ] compare `G-sup-v0.1` with `G-exact`;
- [ ] test whether alternative essence semantics preserve the same T2 obstruction.

## Phase D — Mechanize and publish

### Gate 7 — Mechanization and finite-model verification — **complete**

- [x] create a standard-library-only finite-model oracle under `formal/finite/`;
- [x] machine-check both Gate-6 T2 countermodels against the encoded Gate-5 control stack;
- [x] verify the glut/gap split of `CONS_G^G` and `COMP_P^G`;
- [x] exhaustively verify schema-level `MC+ <-> MC-` on the negation-closed two-world test family;
- [x] initialize and CI-build the Lean 4.30.0 package;
- [x] formalize the four-valued kernel connectives needed by the current control theory;
- [x] formalize relational bilateral modality and actualist quantification;
- [x] formalize `NEnt±_E`, `G-sup-v0.1`, and `Ess-sup-v0.1`;
- [x] prove the conditional T2 recovery theorem generally in Lean;
- [x] machine-check `T1-T` and the unrestricted-`+P` glut countermodel;
- [x] formalize conditional T3, GW, and essence-compressed modal collapse;
- [x] verify interface-level classical recovery of the reconstructed D1/D2/D3 branch;
- [x] add bounded assumption-minimization search around the T2 recovery package.

Finite exhaustive checks are always reported with their bounded model class; absence of a finite countermodel is not promoted to a general theorem.

### Gate 8 — Comparative variants — **next**

- [ ] compare `G-sup` with `G-exact`;
- [ ] compare at least one Anderson/Fitting-style variant;
- [ ] vary K / KB / S4 / S5 after the S5 control theory is mechanized;
- [ ] rerun selected results over broader paired-neighborhood frames.

### Gate 9 — Publication consolidation

- [ ] perform a dedicated prior-art search for four-valued/paraconsistent Gödel-style ontological arguments and non-classical positivity;
- [ ] audit exact correspondence with the frozen higher-order Scott baseline before final publication claims;
- [ ] write the paper around the strongest verified structural theorem;
- [ ] distinguish semantic theorems, machine-checked results, countermodels, and open global-minimality questions explicitly.
