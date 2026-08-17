# Conjectures and falsification targets

Every conjecture in this repository should have a corresponding falsification strategy.

## Established Gate-3 through Gate-7 facts

The following are no longer conjectures:

1. `A1-L` and `A1-R` are independent directional clauses.
2. Corrected `MC+` and `MC-` are equivalent under involutive FDE negation.
3. `R+` and `R-nec-` are independent without A1 and interderivable under strong A1.
4. `A1-R + A2+ => T1-T`, where `T1-T` applies to truth-only positivity; this implication is machine-checked in Lean.
5. Mere `+P(φ)` is insufficient for T1 in the presence of positivity gluts; the obstruction is an executable regression countermodel.
6. `A3-T + T1-T` yields positive possible God-like existence at the semantic control level.
7. `G-sup-v0.1` discharges `D1+` and `CONST` follows from full higher-order property comprehension.
8. Natural `Ess-sup-v0.1` does **not** make T2 automatic: both a glut and a gap two-world S5 model satisfy the Gate-5 control stack plus strong A1 and `R+` while refuting `T2+`.
9. `NegExemplification + G-sup-v0.1 + A1-L + R+ + REG_G => T2+`, with `REG_G := COMP_P^G + CONS_G^G`; this implication is machine-checked generally in Lean.
10. The two named T2 failures are executable regressions.
11. Only `A5+`, not truth-only `A5-T`, is required for the positive T3 branch once a God-like witness exists.
12. Possible Godlikeness + `T2+ + A5+ + NE-sup + G-sup + S5` yields positive `T3+`; this implication is machine-checked in Lean.
13. `T3+` discharges `GW` on reflexive control frames; machine-checked in Lean.
14. `T2+ + T3+ + G-sup + CONST => MC+` on reflexive control frames; machine-checked in Lean, with `MC-` following from the collapse-channel theorem.
15. A glut `P(NE)=B` can survive the positive T3 branch at the semantic level.
16. Under explicit classical coherence, the bilateral `NEnt`, Godlikeness, essence, and necessary-existence interfaces reduce to complementary positive/negative channels; machine-checked in Lean.
17. In the complete generated Gate-7 two-world / one-entity `G,Z` family, 873 models satisfy `A1-L + R+ + COMP_P^G + CONS_G^G` together with the fixed bilateral semantic laws, and all satisfy `T2+`.
18. Within that same bounded family, dropping any one of `A1-L`, `R+`, `COMP_P^G`, or `CONS_G^G` individually yields a T2 countermodel.

See `docs/FORMAL_VERIFICATION.md` for exact verification scope and bounds.

## C1 — Bilateral collapse separation — **falsified for the current semantics**

The corrected `MC+` and `MC-` schemata cannot be independent while FDE negation is involutive and the schemata range over all formulas. The conjecture remains retired.

## C2 — A1-driven rigidity coupling — **resolved**

Without A1, `R+` and `R-nec-` are independent. Under strong A1 they are interderivable.

## C3 — Glut/gap asymmetry — **strongly supported, still open globally**

Gluts and gaps separate at three structurally different points:

```text
REF+ : glut blocks contradiction elimination; gap blocks positivity completeness
T1-T: positivity glut absorbs reductio-generated negative support
T2+ : glut and gap yield distinct finite failures of Godlikeness-as-essence
```

Gate 7 preserves these distinctions as executable regressions rather than prose examples.

**Remaining falsification target.** Show that under a more principled alternative Godlikeness/essence variant the glut/gap distinction becomes theorem-irrelevant for every remaining result.

## C4 — Non-trivial inconsistent models — **substantially supported**

The positive T3 branch needs only `A5+`. Therefore a glut `P(NE)=B` can make a positive God-like witness both `+NE` and `-NE` while the positive T3 derivation still proceeds through the positive component.

**Remaining target.** Machine-check a complete finite model of the positive T3 branch with a controlled glut and verify non-triviality of unrelated formulas.

## C5 — Classical recovery — **resolved at the bilateral interface level; full HOL audit open**

Lean now proves, under explicit classical coherence:

```text
Pos_T(phi) <-> +P(phi)
NEnt-_E(phi,psi) <-> not NEnt+_E(phi,psi)
-G(x) <-> not +G(x)
-Ess(phi,x) <-> not +Ess(phi,x)
-NE(x) <-> not +NE(x)
```

Together with the machine-checked positive theorem chain, this establishes recovery of the reconstructed bilateral interfaces.

**Remaining publication target.** Audit exact higher-order correspondence with the frozen Scott/AFP development, including quantifier/comprehension conventions, before stating end-to-end identity with the full HOL formalization.

## C6 — Reflection regularity is route-specific — **resolved as a route claim**

Gate 4 established local minimality of

```text
A1-L + D1+ + CONS_G + COMP_P => REF+
```

relative to that interface vocabulary. Gate 6 showed those global conditions are not necessary for every T2/T3/collapse model. Gate 7 does not change that conclusion.

## C7 — Upstream decomposition thesis — **machine-supported**

The current dependency map is:

```text
A1-R -> T1-T / possible G
A1-L + R+ + REG_G -> sufficient T2 recovery
A5+ + T2+ -> positive T3 branch
T2+ + T3+ -> essence-compressed collapse
```

The central implications are now represented by Lean theorems. The final collapse schemata remain coupled; the informative variation is concentrated upstream.

## C8 — Necessary-existence branch supplies `GW` — **resolved positively, conditionally on T2+**

The conditional T3 and `T3+ => GW` implications are now machine-checked in Lean.

## C9 — T2 global minimality — **principal open conjecture**

Current sufficient package:

```text
NegExemplification
+ G-sup-v0.1
+ A1-L
+ R+
+ COMP_P^G
+ CONS_G^G
=> T2+
```

Gate 7 establishes two different statuses:

- **general sufficiency:** machine-proved in Lean;
- **bounded individual indispensability:** in the complete generated two-world / one-entity `G,Z` family, removing any one of `A1-L`, `R+`, `COMP_P^G`, or `CONS_G^G` yields a T2 countermodel.

This still does **not** establish global necessity or global minimality.

**Falsification target.** Find a strictly weaker structural principle, or a different natural Godlikeness/essence definition, that derives T2 while eliminating one or more of the current recovery assumptions.

## C10 — Essence robustness

**Conjecture.** The positive Scott theorem chain can survive glutty essence/NE statuses as long as the positive components required by T2 and D3 are preserved.

**Current evidence.** `Ess-sup` and `NE-sup` are bilateral, and the machine-checked positive T3 proof uses only positive essence and positive NE support.

**Falsification target.** Show that negative components feed back through the remaining axioms in a way that inevitably destroys the positive theorem chain or forces triviality.

## C11 — Exact positive Godlikeness compresses T2 recovery — **Gate-8 target**

Define a project-internal comparison candidate, provisionally:

```text
G-exact+(x) : for every property phi,
              +phi(x) iff +P(phi)
```

This is not yet identified with any Anderson/Fitting literature variant.

**Conjecture.** If the distinguished Godlikeness property realizes this exact positive condition at every world, then positive rigidity alone suffices for the positive T2 branch; the `A1-L`, `COMP_P^G`, and `CONS_G^G` recovery assumptions become unnecessary for that route.

**Falsification target.** Produce a model satisfying exact positive Godlikeness and `R+` while refuting the corresponding positive T2 theorem, or show that the proposed exactness condition is formally or philosophically ill-motivated and should be rejected before comparison.
