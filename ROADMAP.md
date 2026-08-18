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
- **Gate 9:** `source-audit-v0.1`, first source-correspondence matrix and reproducible prior-art pass.
- **Gate 10:** `fitting-quotient-filter-v0.1`, four-valued quotient delta-filter audit.
- **Gate 11:** `paired-neighborhood-bridge-v0.1`, machine-checked Kripke representation and CD recovery.
- **Gate 12:** `v1-synthesis-v0.1`, evidence ledger and publication boundary.

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

The current milestones are:

```text
fitting-types-v0.1
fitting-bilateral-v0.2
fitting-minimality-v0.2
fitting-domain-v0.2
fitting-entailment-v0.1
fitting-actualist-quotient-v0.1
fitting-quotient-filter-v0.1
fitting-rigidity-v0.1
fitting-converse-rigidity-v0.1
fitting-delta-filter-v0.1
```

The entailment and rigidity milestones are locally validated with Lean 4.30.0 and executable finite regressions.

- [x] introduce distinct Lean types for bilateral extensions and world-indexed intensions;
- [x] type Fitting positivity over extensions rather than intensions;
- [x] define extension-level signed necessary entailment;
- [x] define bilateral extensional essence and necessary existence;
- [x] discover and machine-check the unrestricted bilateral-comprehension obstruction: `ConsGG -> no GodPlus`;
- [x] introduce a selected FDE-negation-closed admissible extension domain without globally banning gluts;
- [x] prove the admissible-domain Fitting T2 analogue without `R+`;
- [x] machine-check classical recovery for admissible entailment, Godlikeness, essence, necessary actual exemplification, and NE;
- [x] prove an admissible de-re possibility-to-necessity theorem with no frame condition and no `R+`;
- [x] isolate de-dicto lifting behind positive-only G-extension stability;
- [x] exhibit de-re/de-dicto separation and necessary-God/no-collapse finite models;
- [x] weaken full `CONS_G^G(adm)` to consistency only on the negatively classified branch for the A1-L route;
- [x] prove that restoring `A1-R` reconstructs full `CONS_G^G(adm)` from the targeted package;
- [x] show that `COMP_P^G(adm)` is route-specific via a Godlike-indiscernibility essence/NE theorem;
- [x] derive Godlike indiscernibility from positive-profile saturation of the admissible domain;
- [x] prove positive-profile saturation is equivalent to bilateral profile saturation under negation closure;
- [x] show quotient-respecting bilateral extensions are preserved by FDE negation, conjunction, disjunction, top and bottom;
- [x] exhibit a finite countermodel showing FDE algebra closure does not force profile saturation;
- [x] isolate ultrafilter-style complement decision and show that with relevant consistency or `A1-R` it reconstructs the classification route;
- [x] finite-check that even `A2+` + full domain-level entailment closure + FDE algebra closure + profile-compatible actual existence does not force profile saturation;
- [x] finite-check that actualist entailment can fail to descend through profile saturation when actual existence splits a profile class;
- [x] locally validate the new `FittingEntailmentQuotient.lean` theorem block with Lean 4.30.0;
- [x] freeze the general profile-closure operator results as machine-checked: extensivity, monotonicity, least quotient-respecting hull, idempotence, fixed-point characterization, and entailment descent under profile-compatible existence;
- [x] freeze the general obstruction `GlobalEntailmentClosedAdm + Adm(bottom) => unrestricted Adm` and its consistency/Godlikeness corollary;
- [x] construct the explicit Lean quotient of entities by positive profiles and prove bilateral extension push/pull round trips;
- [x] characterize `ProfileExistenceSaturatedAdm` exactly as factorization of actual existence through every accessible source quotient;
- [x] prove quotient-level actualist entailment equivalent to ordinary entailment on profile-respecting pullbacks;
- [x] define truth-order delta-filters, prime delta-filters, and non-adjunctive two-filters on the quotient extension algebra;
- [x] prove that every inhabited quotient carries a prime delta-filter designating `B` while leaving `N` complement-undecided;
- [x] exhaust the two-point quotient algebra and retain a non-vacuous ordinary-filter fixture in which local `COMP` fails;
- [x] derive positive reflection from `RPlusAdm`, and positive persistence from `RPlusAdm + Symmetric(R)`;
- [x] finite-check the bridge exhaustively over the two-world / one-entity classical admissible fragment and retain separate countermodels when symmetry or `RPlusAdm` is dropped;
- [x] replace symmetry by `RPlusConverseAdm`, the converse positivity transport actually consumed by the persistence proof;
- [x] finite-check that bidirectional positivity transport can hold on asymmetric frames: 32 of 112 retained bidirectional models are non-symmetric;
- [ ] determine whether `RPlusConverseAdm` can be restricted to G-triggered or quotient-selected extensions;
- [x] lift the classical extensional `delta`-filter to the admissible fixed-point algebra in the FDE truth order, with meet/join, order-reversing negation, and classical recovery on the coherent fragment;
- [x] derive both admissible A1 directions and the dual-ideal laws from the bilateral polarity equation;
- [x] separate ultrafilter maximality from filter closure, and finite-check a 12-element gap/glut algebra satisfying the filter plus relevant consistency while `COMP` fails;
- [ ] determine which filter strength strictly between properness and maximality, if any, supports the essence/NE route.

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
  quotient route: positive-profile saturation -> Godlike indiscernibility, with no COMP/A1/consistency
  FDE algebra preserves quotient factorization but does not generate it
  ultrafilter-style complement decision + consistency/A1-R reconstructs classification rather than bypassing it
  de-dicto lifting needs only positive G-extension stability
  RPlusAdm derives positive G-reflection; converse positivity transport derives positive G-persistence
  bidirectional positivity transport yields de-dicto lifting without frame symmetry
  necessary Godlikeness can coexist with MC+ failure
```

The entailment experiment additionally has executable finite evidence that entailment closure does not generate the quotient. Its general Lean closure/fixed-point theorems and the subsequent rigidity bridge are locally build-validated.

- [x] machine-check the paired-neighborhood modal clauses, exact Kripke embedding, and complement-dual classical recovery;
- [x] exhaust the two-world local paired-frame space and separate principal, non-principal CD, and non-CD behavior;
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

The major Scott/Anderson/Fitting comparative milestones are green. The Fitting branch now distinguishes positivity-filter closure, the selected admissible property domain, a profile-quotient fixed-point proposal, actualist existence compatibility, and the trade-off between primitive positive `G` stability and its derivation from admissible positivity rigidity plus symmetry.

### Gate 9 — Publication consolidation

- [x] complete and log a first reproducible prior-art search for four-valued/paraconsistent Gödel-style ontological arguments and non-classical positivity;
- [x] create a source-correspondence matrix separating direct source control, standard semantic background, and project-specific clauses;
- [ ] audit exact correspondence with the frozen higher-order Scott baseline;
- [ ] audit exact line-by-line correspondence of Anderson/Fitting interfaces with the complete published formal developments;
- [ ] sharpen the paper around the strongest verified structural comparison;
- [ ] distinguish semantic theorems, machine-checked results, finite countermodels, bounded exhaustive evidence, and open global-minimality questions explicitly.
