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

The kernel deliberately does **not** adopt an object-language four-valued implication. Signed `+/-` propagation principles remain metalanguage constraints until the later Gödel–Scott axiom-lifting stage determines which conditional behavior is actually required.

Remaining implementation checks for Gate 1 are deferred to the mechanization workflow:

- [ ] machine-readable evaluator reproduces all four-valued tables;
- [ ] paraconsistency/paracompleteness countermodels are machine checked;
- [ ] classical propositional recovery is machine checked.

### Gate 2 status

The modal layer is frozen as `modal-v0.1` in `docs/MODAL_LIFT.md`.

For the first positivity/collapse experiments the project uses a bilateral relational Kripke semantics:

```text
+□φ : every accessible world positively supports φ
-□φ : some accessible world negatively supports φ
+◇φ : some accessible world positively supports φ
-◇φ : every accessible world negatively supports φ
```

Gate 2 establishes semantically:

- bilateral `□/◇` duality;
- classical Kripke recovery on the `T/F` fragment;
- preservation of the full `T/F/B/N` modal range;
- an exact representation of relational frames as paired `U/H` neighborhood frames;
- a complement-duality condition for classical recovery in arbitrary paired-neighborhood models.

**Control-variable decision:** Gates 3–4 keep the Scott S5 relational frame fixed. Non-principal / non-complement-dual neighborhood behavior is deferred until the bilateral positivity mechanism has been isolated.

Remaining implementation checks are deferred to mechanization:

- [ ] modal clauses are machine checked;
- [ ] regression models for `T/F/B/N` modal outputs are machine checked;
- [ ] relational-to-neighborhood representation is machine checked.

### Gate 3 status

The positivity decomposition is frozen as `positivity-v0.1` in `docs/POSITIVITY_LIFT.md`.

Gate 3 establishes semantically:

- `P(φ)` is itself four-valued;
- Scott A1 splits into two **directional** and independent clauses:
  - `A1-L : -P(φ) => +P(¬φ)`
  - `A1-R : +P(¬φ) => -P(φ)`
- strong A1 (`A1-L + A1-R`) swaps `T/F` and preserves `B/N` under property negation;
- the direct A4 lifting is `R+ : +P(φ) => +□P(φ)`;
- the old `-P => -□P` candidate is reflexively trivial on S5 and is retired;
- informative negative rigidity is `R-nec- : -P(φ) => +□¬P(φ)`;
- the old `MC- : -χ => -□χ` candidate is likewise reflexively trivial and is retired;
- the corrected negative collapse target is `MC- : -χ => +□¬χ`, equivalently `-χ => -◇χ`;
- even strong A1 plus the minimal `D1+` support interface does not recover the classical local reflection step `+G,+Z => +P(Z)`;
- glut and gap counterassignments fail that reflection step for different reasons.

### Gate 4 status

The collapse dependency analysis is frozen as `collapse-v0.1` in `docs/COLLAPSE_EXPERIMENT.md`.

Gate 4 establishes semantically:

- the informative collapse schemata are not independent under the fixed FDE negation:
  - `MC+ : +χ => +□χ`
  - `MC- : -χ => +□¬χ`
  - and `MC+ <-> MC-` follows by substitution with `¬χ` and involutive negation;
- the original bilateral-collapse separation conjecture is therefore falsified for the current semantics;
- `R+` and `R-nec-` are independent without A1, witnessed by two-world S5 countermodels;
- strong A1 makes `R+` and `R-nec-` interderivable, so the genuine rigidity decomposition is upstream and A1-dependent;
- the local reflection step
  - `REF+ : +G(x), +Z(x) => +P(Z)`
  is recovered from the four-part package
  - `A1-L + D1+ + CONS_G + COMP_P`;
- each member of that four-part local package is individually indispensable relative to the other three by explicit counterassignments;
- adding `R+`, global God-like witness supply `GW`, and constant-property embedding `CONST` yields a conditional interface-level derivation of `MC+`, and hence also `MC-`;
- this is not yet a theorem of the full four-valued Gödel–Scott theory because `D1+`, `GW`, and `CONST` remain interfaces to be justified by the reconstruction gates.

Remaining checks are deferred to later gates:

- [ ] machine-check the two-world rigidity countermodels;
- [ ] machine-check `MC+ <-> MC-` and the A1 rigidity-coupling theorem;
- [ ] replace `D1+`, `GW`, and `CONST` by justified components of the full higher-order semantics;
- [ ] test whether weaker principled substitutes for `CONS_G` or `COMP_P` suffice in the reconstructed theory.

These checks do not block Gate 5.

## Phase B — The key experiment

- [x] split A1 into independent directional components;
- [x] isolate direct and informative negative positivity-rigidity channels;
- [x] correct the bilateral `MC+` / `MC-` targets;
- [x] prove the corrected collapse schemata equivalent under FDE negation;
- [x] separate the rigidity channels without A1 by finite S5 countermodels;
- [x] prove strong A1 recouples the rigidity channels;
- [x] identify and locally minimize the `REF+` assumption package;
- [x] state the conditional interface-level collapse theorem;

## Phase C — Reconstruct Gödel–Scott

- [x] lift the positivity predicate and A1/A4 interfaces;
- [ ] lift A2 and A3;
- [ ] freeze the final four-valued definition of `G`;
- [ ] prove/refute possible exemplification;
- [ ] justify or replace `GW` and `CONST` inside the higher-order semantics;
- [ ] lift `Ess`;
- [ ] lift `NE`;
- [ ] classify the status of `□∃x G(x)`.

## Phase D — Mechanize and publish

- [ ] Implement settled semantics in Lean.
- [ ] Add model/countermodel tests.
- [ ] Verify classical recovery.
- [ ] Compare at least one non-Scott variant.
- [ ] Re-run the rigidity/collapse analysis over broader relational and paired-neighborhood frame classes.
- [ ] Write paper around the strongest structural theorem.
