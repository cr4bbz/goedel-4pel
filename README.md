# goedel-4pel

A research repository for a four-valued reconstruction and structural analysis of the Gödel–Scott ontological argument.

## Core question

> What becomes of the Gödel–Scott system when positivity, modal status, essence, and derivability are interpreted in a four-valued bilateral semantics that admits both inconsistency and incompleteness?

The project is not intended to produce a "stronger proof of God". Its aim is logical: use Gödel–Scott as a controlled test case for four-valued modal reasoning and identify which assumptions drive possible exemplification, Godlikeness-as-essence, necessary existence, and modal collapse.

## Current thesis

Under the present involutive FDE negation, the informative signed collapse schemata are coupled:

```text
MC+ : +phi => +Box phi
MC- : -phi => +Box not phi
MC+ <-> MC-
```

The main non-classical structure therefore occurs upstream.

For the Scott-support control theory, the verified dependency spine is:

```text
A1-R + A2+ + A3-T
          |
          v
      +Diamond exists^E x G(x)

NegExemplification
+ G-sup
+ A1-L
+ R+
+ REG_G
          |
          v
          T2+

A5+ + T2+ + NE-sup + G-sup
+ Symmetric(R)
          |
          v
          T3+

T3+ + Reflexive(R) => GW

T2+ + T3+ + G-sup + CONST
+ Reflexive(R)
          |
          v
          MC+ <-> MC-
```

The central Scott question remains global T2 minimality.

Gate 8 shows that the bottleneck is strongly **definition-sensitive**:

```text
Scott G-sup:
  +P(phi) -> current +phi(x)

project G-exact+:
  +P(phi) <-> current +phi(x)

Anderson G_A+:
  +P(phi) <-> necessary +phi(x) for the same individual

Fitting:
  positivity and essence range over selected rigid extensions,
  while Godlikeness remains intensional
```

The three architectures move modal/informational work to different interfaces rather than merely changing the accessibility relation.

## Gates 0–7

- **Gate 0:** frozen Scott baseline and classical collapse spine.
- **Gate 1:** `kernel-v0.1`, bilateral FDE kernel with `T/F/B/N`.
- **Gate 2:** `modal-v0.1`, bilateral relational S5 control semantics.
- **Gate 3:** `positivity-v0.1`, directional A1 split and rigidity channels.
- **Gate 4:** `collapse-v0.1`, schema-level `MC+ <-> MC-`, reflection obstructions, conditional collapse.
- **Gate 5:** `godlike-v0.1`, actualist quantification, `T1-T`, possible Godlike existence, `G-sup-v0.1`.
- **Gate 6:** `essence-ne-v0.1`, bilateral essence/NE, glut-gap T2 countermodels, sufficient Scott T2 recovery, conditional T3/collapse.
- **Gate 7:** `formal-v0.1`, Lean theorem spine, classical recovery, finite countermodels, and bounded assumption searches.

Gate 7 is complete. The broader exhaustive two-world / one-entity `G,Z` family contains **873** models satisfying the full current Scott T2 recovery package; all satisfy `T2+`. Dropping any one of `A1-L`, `R+`, `COMP_P^G`, or `CONS_G^G` yields a T2 countermodel in the same bounded family. This is bounded evidence, not a global minimality theorem.

## Gate 8 — Comparative variants

Gate 8 is in progress. The main current milestones are:

```text
anderson-bilateral-v0.2
fitting-bilateral-v0.2
fitting-minimality-v0.2
fitting-domain-v0.2
fitting-entailment-v0.1
fitting-actualist-quotient-v0.1
fitting-quotient-filter-v0.1
paired-neighborhood-bridge-v0.1
v1-synthesis-v0.1
fitting-rigidity-v0.1
fitting-converse-rigidity-v0.1
fitting-delta-filter-v0.1
paper-v0.20
```

### Anderson and Scott frame reduction

Lean reduces both current T3 routes to symmetry alone: Scott after `T2+`, and the current Anderson reconstruction. Separate reflexive-transitive but non-symmetric finite models show that S4 does not replace symmetry in either route. A separate complete-S5 Anderson model has positive necessary Godlike existence while positive modal collapse fails.

### Fitting: typed extensional domain

Fitting distinguishes:

```text
Extension Entity
Intension World Entity := World -> Extension Entity
```

and positivity is extension-typed.

The naive unrestricted bilateral extension universe is unsuitable for the intended regularity route because it contains a universal glut extension. Lean proves that the unrestricted relevant-consistency condition excludes every positive Fitting-Godlike witness. The substantive reconstruction therefore uses a selected FDE-negation-closed domain `Adm` that does not globally ban gluts.

### Two Fitting essence/NE routes

The **classification route** uses:

```text
A1-L
+ COMP_P^G(adm)
+ consistency only on the negatively classified branch
```

The **quotient route** bypasses positivity completeness. Positive-profile equivalence identifies entities that all positively supported admissible extensions treat alike. If every selected extension respects those classes, Lean derives Godlike indiscernibility and the extensional essence/NE route with no A1, `COMP`, or exemplification-consistency premise.

Negation closure upgrades positive profile saturation to bilateral factorization. Quotient-respecting bilateral extensions are preserved by FDE negation, conjunction, disjunction, top and bottom. A finite countermodel shows that ordinary FDE algebra closure alone does **not** generate profile saturation.

### Entailment and the quotient

The newest experiment is frozen in `docs/FITTING_ENTAILMENT_QUOTIENT.md` as `fitting-entailment-v0.1`.

The source-grounded distinction is crucial: Fitting's classical `delta`-filter closes the **family of positive extensions** under the relevant set-theoretic/filter operations. It does not say that the ambient property domain must contain every entailment consequence. Our `A2PlusAdm` already represents positivity monotonicity under extensional entailment.

A stronger domain-level condition was nevertheless tested:

```text
GlobalEntailmentClosedAdm:
  Adm(X)
  + global EntailPlus(X,Y)
  -> Adm(Y)
```

The new general Lean module implements the theorem that, once FDE bottom is admissible, this condition forces every bilateral extension into `Adm`, because bottom positively entails every extension vacuously. With relevant exemplification consistency, that recreates the earlier unrestricted-comprehension obstruction.

The finite oracle provides an independent negative result over **all 16 bilateral extensions on two entities**: even `A2+`, full domain-level entailment closure, full FDE-algebra closure, and profile-compatible actual existence do not force positive-profile saturation.

The positive replacement is a canonical closure operator:

```text
profileSaturateAt(w,Y)
```

which closes both positive and negative support under the positive-profile equivalence classes at `w`. The Lean module implements extensivity, monotonicity, idempotence up to bilateral extensional equivalence, the least quotient-respecting hull property, and the exact fixed-point characterization of profile-saturated admissible domains.

Because Fitting entailment is actualist, the quotient also interacts with existence. The implemented condition

```text
ProfileExistenceSaturatedAdm:
  w R z + x ~=_w y
  -> (Exists(z,x) <-> Exists(z,y))
```

is sufficient for positive entailment to descend through profile saturation. A finite two-world countermodel shows that descent can fail when actual existence splits a profile class.

The finite regressions and the root-imported Lean theorem block have now been validated locally with Lean 4.30.0. The closure/fixed-point, entailment-descent, and unrestricted-domain obstruction results are therefore promoted to the same machine-checked status as the earlier Gate-8 Lean results.

### Explicit actualist quotient

The follow-up milestone `fitting-actualist-quotient-v0.1` constructs the actual quotient type

```text
ProfileQuotient M w := Entity / PositiveProfileEqAdm(M,w)
```

in Lean. Bilateral extensions can be pushed to and pulled back from quotient classes, with both round trips proved up to bilateral extensional equivalence. The earlier existence condition receives an exact semantic characterization:

```text
ProfileExistenceSaturatedAdm M
  <-> actual existence factors through every accessible source quotient.
```

On this quotient-respecting fragment, quotient-level actualist entailment is equivalent in both directions to ordinary entailment between pullbacks. The finite regression checks all 16 saturated extensions and all 256 ordered entailment pairs while retaining genuine `B` and `N` values; split existence prevents quotient factorization and reproduces the earlier descent failure.

### Four-valued quotient filters

Gate 10 defines proper truth-order delta-filters, prime delta-filters, and non-adjunctive two-filters on bilateral quotient extensions. Lean proves that point evaluation is a prime delta-filter which designates the glut extension `B` but leaves the gap extension `N` and its negation undesignated. Thus primeness no longer entails classical complement decision.

The exhaustive two-point quotient algebra contains 15 ordinary delta-filters, 4 prime delta-filters, 112 proper two-filters, and 10 prime two-filters. All four prime ordinary filters are non-deciding. A separate ordinary-filter fixture has two non-vacuous Godlike points while a possessed `(T,N)` extension is neither positive nor negative in the filter sense, so local `COMP` fails in that bounded model.

### Paired-neighborhood bridge

Gate 11 now machine-checks the paired-neighborhood semantics that Gate 2 had retained as a controlled generalization. Lean proves bilateral modal duality, the exact relational representation of all four signed modal clauses, complement duality of relationally induced pairs, and classical modal recovery for arbitrary complement-dual paired frames.

The complete local two-world space contains 256 pairs of universal/hit families: 16 are complement-dual, 4 are principal relational, and 12 are genuinely non-principal while still preserving classical modal bivalence. All 1024 bounded relational box/diamond comparisons agree exactly. Without complement duality, classically valued inputs realize all four outputs `T`, `F`, `B`, and `N`.

The publication boundary and evidence ledger are frozen in `docs/V1_SYNTHESIS.md`. The next neighborhood task is theorem-specific transport of selected Scott, Anderson, and Fitting results rather than another change to the modal kernel.

### Fitting: derived rigidity bridge

The newest milestone is frozen in `docs/FITTING_RIGIDITY_BRIDGE.md` as `fitting-rigidity-v0.1`. Lean proves the Fitting-typed bridge

```text
G realization + RPlusAdm
  -> Refl_G+

G realization + RPlusAdm + Symmetric(R)
  -> Pers_G+

therefore:
G realization + RPlusAdm + Symmetric(R)
  -> STAB_G+
```

Thus the direct de-dicto theorem remains frame-free when positive `G` stability is assumed primitively, while symmetry re-enters if that stability is derived from forward admissible positivity rigidity. An exhaustive two-world / one-entity regression checks all 256 configurations over the negation-closed classical admissible domain `{T,F}`; all 152 `RPlusAdm` cases satisfy reflection, and all 80 symmetric `RPlusAdm` cases also satisfy persistence. Separate fixtures show that `RPlusAdm` without symmetry need not force persistence and symmetry without `RPlusAdm` need not force either direction.

The follow-up `fitting-converse-rigidity-v0.1` isolates what that persistence proof actually needs. `RPlusConverseAdm` transports target positivity back to the source along an existing edge without requiring a reverse edge. Lean proves that it directly yields `Pers_G+`, while `RPlusAdm + RPlusConverseAdm` yields the full `STAB_G+` interface and the minimized de-dicto theorem with no frame premise. In the same 256-case fragment, 112 candidates satisfy both transports and 32 of those are non-symmetric, giving a bounded strict separation from global symmetry.

### Ultrafilter comparison

A literature-facing complement-decision fragment shows a different architecture: with relevant consistency or `A1-R`, complement decision reconstructs positive reflection / `COMP`, reconnecting to the classification route rather than explaining the classification-free quotient route.

### Necessary Godlikeness without modal collapse

A complete-S5 admissible Fitting finite model has positive necessary actual Godlikeness while a contingent intension satisfies:

```text
+Q(a) @ w0
not +Box Q(a) @ w0
```

and its selected extension domain still contains genuine `B` information.

## Verification

From the repository root:

```bash
python3 -m unittest discover -s formal/finite -p "test_*.py" -v
python3 formal/finite/gate8_fitting_entailment.py
python3 formal/finite/gate8_fitting_rigidity_bridge.py
python3 formal/finite/gate8_fitting_converse_rigidity.py
python3 formal/finite/gate8_fitting_actualist_quotient.py
python3 formal/finite/gate10_quotient_delta_filters.py
python3 formal/finite/gate11_paired_neighborhoods.py
```

Lean:

```bash
cd formal/lean
lake build
```

The Lean package is pinned to Lean 4.30.0.

## Research gates

- **Gates 0–7:** complete for the original control theory.
- **Gate 8:** comparative branch complete through the explicit actualist quotient.
- **Gate 9:** first publication consolidation, prior-art audit, and source-correspondence matrix complete; exact line-by-line audit remains open.
- **Gate 10:** the first quotient delta-filter layer is machine-checked and finitely audited. Current frontier: determine which additional filter strength supports the Fitting essence/NE route without restoring complement decision.
- **Gate 11:** the paired-neighborhood modal bridge and strict two-world hierarchy are machine-checked and finitely audited.
- **Gate 12:** the v1 evidence ledger and publication boundary are frozen; selected higher-order neighborhood transports remain open.

Gate 9 now has a first reproducible source pass in `docs/PRIOR_ART_SEARCH.md` and an attribution boundary in `docs/SOURCE_CORRESPONDENCE_MATRIX.md`. These establish source control for the FDE kernel, actualist existence relativization, Anderson's positive interfaces, and Fitting's intension/extension architecture. They deliberately retain the selected bilateral domain, profile quotient, and factorization theorems as project-specific results without a global novelty claim. Exact line-by-line HOL correspondence remains open.

## Paper

The living manuscript is in `paper/`.

Current version:

```text
paper-v0.20
```

The current compiled manuscript is available at [`paper/main.pdf`](paper/main.pdf).

Build from `paper/` with:

```bash
latexmk -pdf main.tex
```

## Non-goals

- theological evaluation of the conclusion;
- changing semantics merely to rescue failed conjectures;
- treating four-valued implication choices as interchangeable;
- silently identifying intensions and extensions;
- globally banning gluts to make the Fitting branch work;
- identifying project-specific bilateral or quotient clauses with unique historical readings;
- claiming global minimality from theorem-local weakenings, alternative recovery routes, or bounded finite fixtures;
- claiming novelty before the dedicated Gate-9 audit.

## Status

**Phase:** Gates 7–12 established through the first source, filter, paired-neighborhood, and synthesis checkpoints; manuscript baseline `paper-v0.20`; newest verified research milestone `fitting-delta-filter-v0.1`.
