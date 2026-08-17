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

These checks do not block later semantic design.

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

These checks do not block Gate 3.

## Phase B — The key experiment

- [ ] Split A1 into bilateral components.
- [ ] Split positivity rigidity into positive and negative components.
- [ ] Define `MC+` and `MC-`.
- [ ] Produce the initial 16-case `A1+/A1-/R+/R-` collapse matrix.
- [ ] Find finite countermodels for every non-implication.
- [ ] Identify minimal axiom sets forcing each collapse component.

## Phase C — Reconstruct Gödel–Scott

- [ ] Lift `P`.
- [ ] Lift `G`.
- [ ] Prove/refute possible exemplification.
- [ ] Lift `Ess`.
- [ ] Lift `NE`.
- [ ] Classify the status of `□∃x G(x)`.

## Phase D — Mechanize and publish

- [ ] Implement settled semantics in Lean.
- [ ] Add model/countermodel tests.
- [ ] Verify classical recovery.
- [ ] Compare at least one non-Scott variant.
- [ ] Re-run the collapse experiment over broader relational and paired-neighborhood frame classes.
- [ ] Write paper around the strongest structural theorem.
