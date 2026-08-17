# Roadmap

## Phase A — Semantics before proof automation

- [x] Freeze the exact Scott baseline.
- [x] Fix notation for positive/negative satisfaction.
- [x] Fix the four information values and designated values.
- [x] Choose the consequence relation.
- [x] Define propositional connectives.
- [x] Define `□` and `◇` in positive/negative channels.
- [x] State the classical-recovery fragment.

### Gates 1–7

- **Gate 1:** `kernel-v0.1`, bilateral FDE kernel.
- **Gate 2:** `modal-v0.1`, bilateral relational S5 control semantics; paired neighborhoods deferred.
- **Gate 3:** `positivity-v0.1`, directional A1 split and rigidity channels.
- **Gate 4:** `collapse-v0.1`, schema-level `MC+ <-> MC-`, reflection obstructions, conditional collapse interfaces.
- **Gate 5:** `godlike-v0.1`, actualist quantification, `T1-T`, possible Godlike existence, `G-sup-v0.1`.
- **Gate 6:** `essence-ne-v0.1`, bilateral essence/NE, glut-gap T2 countermodels, sufficient `REG_G` recovery, conditional T3/collapse.
- **Gate 7:** `formal-v0.1`, Lean 4.30.0 theorem spine, classical recovery, executable countermodels, bounded T2 assumption search.

Gate 7 is complete. The broader two-world / one-entity `G,Z` search retains 873 models satisfying the full Scott T2 recovery package; all satisfy `T2+`. Dropping any one of `A1-L`, `R+`, `COMP_P^G`, or `CONS_G^G` yields a countermodel in that bounded family. This is not promoted to global minimality.

---

## Gate 8 — Comparative variants — **in progress**

### Support versus exact Godlikeness

- [x] machine-check `G-sup` versus project-internal `G-exact+`;
- [x] prove `G-exact+ => G-sup+`;
- [x] prove `G-exact+ + R+ => T2-exact+`;
- [x] show exact positive Godlikeness remains compatible with genuine gluts.

### Anderson branch

- [x] source-ground the distinction between `G-exact+`, Anderson, and Fitting;
- [x] formalize literature-grounded positive Anderson Godlikeness/essence/NE interfaces;
- [x] freeze `anderson-bilateral-v0.2` with explicit negative evidence clauses;
- [x] machine-check classical recovery of the Anderson bilateral interfaces;
- [x] exhibit a complete-S5 necessary-God / no-positive-collapse model;
- [x] reduce the Anderson T3 route to symmetry alone;
- [x] exhibit a reflexive-transitive but non-symmetric S4 countermodel to Anderson T3.

### Scott frame reduction

- [x] reduce the Scott-support T3 theorem, after `T2+`, to symmetry alone;
- [x] exhibit a reflexive-transitive but non-symmetric S4 countermodel to Scott T3;
- [ ] determine whether symmetry has a still weaker relational replacement in either Scott or Anderson route.

### Fitting branch

The initial type boundary is `fitting-types-v0.1`; the substantive candidate is frozen in `docs/FITTING_BILATERAL.md` as `fitting-bilateral-v0.2`; theorem-level assumption reduction is frozen in `docs/FITTING_MINIMALITY.md` as `fitting-minimality-v0.2`.

- [x] introduce distinct Lean types for bilateral extensions and world-indexed intensions;
- [x] type Fitting positivity over extensions rather than intensions;
- [x] define extension-level signed necessary entailment;
- [x] define bilateral extensional essence and necessary existence;
- [x] discover and machine-check the unrestricted bilateral-comprehension obstruction:
  `ConsGG -> no GodPlus`, hence the naive unrestricted `REG_G` route is unsuitable as a non-vacuous recovery theorem;
- [x] introduce a selected FDE-negation-closed admissible extension domain without globally banning gluts;
- [x] prove the admissible-domain Fitting T2 analogue without `R+`;
- [x] machine-check classical recovery for admissible entailment, Godlikeness, essence, necessary actual exemplification, and NE;
- [x] prove an admissible de-re possibility-to-necessity theorem with no frame condition and no `R+`;
- [x] isolate de-dicto lifting behind explicit G-extension stability;
- [x] prove de-dicto possibility-to-necessity from the admissible Fitting stack with no S4/S5 frame assumption;
- [x] exhibit a three-world admissible model separating de re from de dicto when extension stability fails;
- [x] exhibit a complete-S5 admissible model with positive necessary Godlike existence, genuine `B` information, and failure of positive modal collapse;
- [x] weaken full `CONS_G^G(adm)` to consistency only on the negatively classified branch for the A1-L recovery theorem;
- [x] prove that restoring `A1-R` reconstructs full `CONS_G^G(adm)` from that targeted package;
- [x] split G-extension stability into positive persistence and positive reflection and prove that positive-only stability suffices for the positive de-dicto theorem;
- [x] exhibit a complete-S5 fixture satisfying both A1 directions and the old full `REG_G^adm` while positive G stability holds and bilateral G stability fails;
- [x] show that `COMP_P^G(adm)` is specific to the classification route by proving an alternative Godlike-indiscernibility essence/NE theorem with no A1, `COMP`, or consistency premise;
- [x] exhibit a finite model satisfying both A1 directions and full relevant consistency in which a relevant extension has positivity value `N`, `COMP_P^G(adm)` fails, but the indiscernibility route still yields essence and necessary existence;
- [ ] determine whether admissible-property Godlike indiscernibility follows from a more independently motivated property-domain condition;
- [ ] determine principled closure conditions on the admissible extensional domain beyond negation closure;
- [ ] determine whether positive persistence or positive reflection can be derived from other Fitting assumptions rather than assumed together.

### Cross-variant comparison

Current verified structural picture:

```text
Scott support:
  reflection recovery + R+ + REG_G -> T2+
  symmetry is sufficient for the later T3 return step

Anderson:
  necessary exemplification is internal to Godlikeness
  symmetry is sufficient for the current T3 route
  necessary Godlikeness can coexist with MC+ failure

Fitting admissible:
  positivity/essence range over selected rigid extensions
  no R+ in the extensional essence recovery theorem
  de-re possibility -> necessity is frame-free
  classification route: A1-L + COMP + negative-branch consistency
  alternative route: admissible-property indiscernibility, with no COMP/A1/consistency
  A1-R restores the stronger consistency condition only inside the classification route
  de-dicto lifting needs only positive G-extension stability
  necessary Godlikeness can coexist with MC+ failure
```

- [ ] rerun selected Scott/Anderson/Fitting results over broader paired-neighborhood semantics;
- [ ] decide whether a bilateral negative exact-Godlikeness clause remains scientifically useful after the literature comparisons.

---

## Phase B — The key experiment

- [x] split A1 into independent directional components;
- [x] isolate positivity-rigidity channels;
- [x] correct and classify modal-collapse channels;
- [x] prove collapse-channel equivalence under FDE negation;
- [x] identify local glut/gap reflection failures;
- [x] reconstruct possible Godlike existence;
- [x] identify T2 as the Scott-support bottleneck;
- [x] reconstruct T3 conditionally from positive T2;
- [x] derive the essence-compressed modal-collapse theorem;
- [x] show comparative variants move or remove parts of the Scott bottleneck rather than merely strengthening the frame.

## Phase C — Reconstruct and compare

- [x] complete the current Scott-support reconstruction through conditional collapse;
- [ ] minimize the Scott-support T2 recovery assumptions globally;
- [x] compare `G-sup-v0.1` with project-internal `G-exact+`;
- [x] reconstruct a literature-grounded bilateral Anderson candidate;
- [x] reconstruct a non-vacuous admissible bilateral Fitting candidate;
- [x] compare Scott, Anderson, and Fitting at Godlikeness/essence/NE/frame interfaces;
- [ ] generalize the comparison beyond relational Kripke control semantics.

## Phase D — Mechanize and publish

### Gate 7 — Mechanization and finite-model verification — **complete**

- [x] finite-model oracle and regression fixtures;
- [x] Lean control theory;
- [x] general T1/T2/T3/GW/collapse theorem spine;
- [x] interface-level classical recovery;
- [x] bounded Scott T2 assumption-minimization search.

### Gate 8 — Comparative variants — **in progress**

The major Scott/Anderson/Fitting comparative milestones are green. The Fitting branch now has two machine-checked recovery architectures: a positivity-classification route with A1-sensitive local consistency, and a `COMP`-independent extensional indiscernibility route. Remaining Gate-8 work is primarily principled justification/minimization of the alternative assumptions, admissible-domain closure, and paired-neighborhood generalization.

### Gate 9 — Publication consolidation

- [ ] perform a dedicated prior-art search for four-valued/paraconsistent Gödel-style ontological arguments and non-classical positivity;
- [ ] audit exact correspondence with the frozen higher-order Scott baseline;
- [ ] audit exact correspondence of Anderson/Fitting interfaces with the published formal developments;
- [ ] sharpen the paper around the strongest verified structural comparison;
- [ ] distinguish semantic theorems, machine-checked results, finite countermodels, bounded exhaustive evidence, and open global-minimality questions explicitly.
