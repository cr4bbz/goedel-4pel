# Roadmap

## Phase A — Semantics before proof automation

- [x] Freeze the exact Scott baseline.
- [x] Fix notation for positive/negative satisfaction.
- [x] Fix the four information values and designated values.
- [x] Choose the consequence relation.
- [x] Define propositional connectives.
- [ ] Define `□` and `◇` in positive/negative channels.
- [x] State the classical-recovery fragment.

### Gate 1 status

The propositional kernel is frozen as `kernel-v0.1` in `docs/FOUR_VALUED_KERNEL.md`.

The kernel deliberately does **not** adopt an object-language four-valued implication. Signed `+/-` propagation principles remain metalanguage constraints until the later Gödel–Scott axiom-lifting stage determines which conditional behavior is actually required.

Remaining implementation checks for Gate 1 are deferred to the mechanization workflow:

- [ ] machine-readable evaluator reproduces all four-valued tables;
- [ ] paraconsistency/paracompleteness countermodels are machine checked;
- [ ] classical propositional recovery is machine checked.

These checks do not block Gate 2 semantic design.

## Phase B — The key experiment

- [ ] Split positivity rigidity into positive and negative components.
- [ ] Define `MC+` and `MC-`.
- [ ] Produce the 2×2 rigidity/collapse matrix.
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
- [ ] Write paper around the strongest structural theorem.
