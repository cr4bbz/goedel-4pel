# Gate C — Source audit and provenance boundary

**Gate:** C — source-level publication audit  
**Status:** in progress  
**Audit date:** 2026-08-19  
**Branch:** `codex/publication-hardening-v0.1`

This document records which parts of the repository are grounded in an
external source, which parts are cross-checks against a formal development,
and which parts are project-specific four-valued constructions. It is an
audit boundary, not a novelty certificate.

## Audit vocabulary

- **Source-grounded:** the historical definition or interface has a named
  primary source and an identified location.
- **Formal cross-check:** a machine-checked external development is used to
  compare the architecture or theorem dependency.
- **Project adaptation:** the repository deliberately changes the source
  semantics or adds a four-valued construction; the change is not attributed
  to the historical source.
- **Open:** the exact line-by-line or declaration-by-declaration comparison is
  not complete.

A source-grounded interface is not automatically a proof that the repository
implements the source formula verbatim. Exact implementation correspondence is
tracked separately below.

## Source registry

| ID | Source | Canonical location | Relevant location | Role in this repository |
| --- | --- | --- | --- | --- |
| S1 | Benzmüller & Scott, “Notes on Gödel’s and Scott’s variants of the ontological argument” (2025) | [Springer DOI](https://doi.org/10.1007/s00605-025-02078-x) | Sections 2, 5; especially the Scott presentation and Figures 12–15 | Frozen classical Scott control and quantifier/frame comparison |
| S2 | Benzmüller & Scott, Isabelle/HOL dataset (2025) | [AFP entry](https://www.isa-afp.org/entries/Notes_On_Goedels_Ontological_Argument.html) | Scott-related theories in the AFP session | External formal cross-check for the higher-order Scott baseline |
| S3 | Benzmüller & Fuenmayor, “Computer-supported Analysis…” (2020) | [DOI](https://doi.org/10.18778/0138-0680.2020.08) · [arXiv](https://arxiv.org/abs/1910.08955) | Abstract and the Scott/Anderson/Fitting comparison | Historical comparison of intensions/extensions, ultrafilters, and modal collapse |
| S4 | Fuenmayor & Benzmüller, “Types, Tableaus and Gödel’s God in Isabelle/HOL” (2017) | [AFP entry](https://isa-afp.org/entries/Types_Tableaus_and_Goedels_God.html) | Sessions `FittingProof` and `AndersonProof` | Formal cross-check for the Anderson/Fitting architecture |
| S5 | Fitting, *Types, Tableaus, and Gödel’s God* (2002) | [Springer DOI](https://doi.org/10.1007/978-94-010-0411-4) | “Gödel’s Argument, Formally”, pp. 145–172 | Primary source for the Fitting book-level architecture |
| S6 | Anderson, “Some Emendations of Gödel’s Ontological Proof” (1990) | [DOI](https://doi.org/10.5840/faithphil19907325) | pp. 291–303 | Primary source for the Anderson variant |
| S7 | Benzmüller, “A Comment on Modal Collapse and Ultrafilters…” (2026) | [arXiv](https://arxiv.org/abs/2608.07578) | Current comment and bibliography | Recent literature control for filter/maximality claims |
| S8 | Petrukhin, “Essence and Accident Modalities Meet Belnapian Truth Values” (2026) | [Springer DOI](https://doi.org/10.1007/s11225-026-10250-z) | Entire paper; semantic-neighborhood context | Adjacent four-valued modal literature, not a source for the project’s Fitting constructions |

## Architecture audit

| Area | Repository artifacts | Source anchor | Current relation | Status |
| --- | --- | --- | --- | --- |
| Scott worlds, actualist individuals, possibilist properties | `docs/SCOTT_BASELINE.md`, `paper/sections/02_scott_baseline.tex` | S1 Sections 2 and 5; S2 | The repository records the same high-level quantifier policy and treats S5 as the frozen reference environment. | **Source-grounded; exact declaration audit open** |
| Scott A1–A5 and D1–D3 | `paper/sections/02_scott_baseline.tex`, `GoedelScott/*` | S1 Scott presentation, Figure 12 | The formulas are transcribed as the project’s classical control theory. The four-valued split is a later adaptation. | **Source-grounded; line-by-line formula comparison open** |
| Scott T1/T2/T3/modal collapse dependency | `docs/SCOTT_BASELINE.md`, `GoedelScott/T1.lean`, `T2.lean`, `T3Collapse.lean` | S1 Section 5 and Figure 12; S2 | The repository proves a deliberately decomposed dependency spine rather than claiming that its theorem names are the AFP theorem names. | **Formal cross-check intended; exact proof-term correspondence open** |
| Anderson positive interface | `paper/sections/07_goedel_reconstruction.tex`, `paper/sections/10_related_work.tex`, `GoedelScott/Anderson*` | S3 comparison; S4 `AndersonProof`; S6 | The positive architecture is literature-grounded. The bilateral negative clauses are explicitly reconstructed by this project. | **Source-grounded positive part; project adaptation for FDE negatives** |
| Fitting intension/extension distinction | `paper/sections/09_fitting_reconstruction.tex`, `FittingTypes.lean` | S3 abstract; S4 `FittingProof`; S5 pp. 145–172 | The type distinction and de-re/de-dicto separation follow the source architecture. | **Source-grounded; exact interface mapping open** |
| Selected admissible FDE extension domain | `FittingAdmissible*.lean`, `paper/sections/09_fitting_reconstruction.tex` | No historical source claims this four-valued restriction | The domain repair is forced by the project’s unrestricted-glut obstruction and is not attributed to Fitting. | **Project adaptation; source attribution boundary explicit** |
| Positive-profile quotient and closure | `FittingAdmissibleStructure.lean`, `FittingEntailmentQuotient.lean`, `FittingActualistQuotient.lean` | S3/S4 motivate intension-extension typing; no source located for this exact quotient | The quotient, fixed-point closure, and actual-existence factorization are new project constructions. | **Project result; predecessor search non-conclusive** |
| Four-valued delta-filters | `FittingQuotientDeltaFilter.lean`, `FittingDeltaFilter.lean` | S3/S7 for classical filter and ultrafilter boundary; S8 for adjacent Belnapian context | The repository lifts the filter question into an FDE fixed-point algebra. It does not claim the lift is historical Fitting. | **Project adaptation; exact literature comparison open** |
| Paired-neighborhood bridge | `FourValued/PairedNeighborhood.lean`, `gate11_paired_neighborhoods.py` | S8 and the repository’s cited modal four-valued literature | The local bridge is machine-checked, but the higher-order Scott/Anderson/Fitting stacks have not been transported through it. | **Project result; higher-order transport open** |

## Findings

### 1. The Scott baseline is conceptually well anchored

The repository’s choice of actualist individual quantification, possibilist
property quantification, intensional properties, and an S5 reference
environment is consistent with the modern formal presentation in S1. The
external paper also studies K, mixed quantifier policies, and non-S5
experiments; therefore the repository is correct to treat S5 as a frozen
control environment rather than as a universal consequence of the source.

### 2. The FDE additions are not historical attributions

The selected admissible domain, profile saturation, quotient construction,
and four-valued filter analysis are project-specific. The manuscript already
states this boundary in the related-work section; this audit makes it
explicit at the architecture level.

### 3. “Exact correspondence” remains a real open task

The current repository contains a strong internal correspondence gate, but it
does not yet compare Lean declarations against the AFP source theories
declaration-by-declaration. In particular, theorem names, premise packaging,
notation, and the treatment of actualist guards still require a focused
crosswalk.

### 4. Negative novelty results remain provisional

The source registry documents the primary comparison set, but no finite search
of references can establish that no predecessor exists. The repository should
continue to use “no direct predecessor located in the audited set” rather than
“novel” without qualification.

## Gate C acceptance criteria

Gate C is complete only when:

- every imported historical definition in the paper has a source ID and a
  source location;
- the Scott baseline has a formula-level crosswalk to S1/S2;
- Anderson and Fitting interfaces distinguish source-grounded clauses from
  project-specific FDE adaptations;
- the source registry and bibliography contain canonical URLs;
- the paper and README use the same source-status vocabulary;
- remaining open correspondence items are listed explicitly rather than
  implied to be complete.

## Remaining work after this checkpoint

1. Add source IDs to the formal-correspondence appendix and the central
   manuscript claims.
2. Produce the Scott formula crosswalk against S1 Figure 12 and the S2 AFP
   theory names.
3. Produce focused Anderson and Fitting crosswalks against S4 sessions and the
   cited primary sources.
4. Re-run the publication correspondence checker and Paper CI after those
   references are added.
