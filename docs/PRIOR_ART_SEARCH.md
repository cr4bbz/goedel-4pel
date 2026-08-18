# Gate 9 — Prior-art search log

**Milestone:** `prior-art-audit-v0.1`

**Search date:** 2026-08-18
**Status:** first reproducible pass; no novelty claim authorized

## Search question

The audit asks whether prior work already combines the following elements:

1. Gödel–Scott/Anderson/Fitting positivity and essence;
2. Belnap–Dunn/FDE four-valued support;
3. actualist quantified modal semantics;
4. a quotient of entities by positive-property profiles;
5. filter structure on the resulting quotient/fixed-point algebra.

## Search surfaces and queries

Publisher pages, the Archive of Formal Proofs, arXiv, and general scholarly web indexes were queried with exact and conjunctive strings including:

```text
"four-valued" "Gödel" ontological argument
"Belnap" "ontological argument" Gödel
FDE "ontological argument" modal
paraconsistent "Gödel's ontological" proof
Fitting Types Tableaus Gödel God Isabelle HOL
Belnap four-valued logic De Morgan lattices filters
De Morgan lattice n-filter four-valued logic
actualist quantification varying domains Kripke semantics
```

The exact four-valued/Gödel queries did not locate a direct predecessor in this pass. That is a negative search observation, not evidence of absence.

## Located source clusters

### Gödel–Scott, Anderson, and Fitting

- Fitting (2002) is the primary source for the intensional/extensional architecture and the dependence of collapse behavior on that distinction.
- Anderson (1990) is the primary historical source for the emended Godlikeness/essence route.
- The current AFP development by Fuenmayor and Benzmüller supplies executable source control for actualist quantification, the extension-of operator, Fitting's de-re/de-dicto distinction, Anderson's alternative, and modal-collapse countermodels.
- Benzmüller and Fuenmayor (2020) is the direct comparative source for positive properties, ultrafilters, and modal collapse across variants.

### Four-valued algebra

- Dunn (1976) and Belnap (1977) ground the bilateral four-value kernel.
- Font (1997) relates Belnap's logic to De Morgan lattices and filter-style algebraic semantics.
- Přenosil (2023) studies upsets and `n`-filters on De Morgan lattices, including complete, consistent, and classical variants. This is the strongest located algebraic lead for Gate 10, but it does not by itself identify the repository's positivity filter with those consequence filters.

### Actualist/varying-domain semantics

- The AFP control formalizes actualist quantification by existence relativization.
- Johannesson (2018) analyzes the semantic choice introduced when terms denote objects outside a world's varying domain and develops partial alternatives. It is relevant context for gaps induced by non-existence, not a source for the repository's quotient theorem.

## Claim audit

| Candidate claim | Gate-9 status |
|---|---|
| The FDE kernel is standard | Supported |
| Fitting distinguishes intensional properties from world-relative extensions | Supported |
| Anderson changes both Godlikeness and essence | Supported |
| Fitting/Anderson avoid the classical modal collapse in the mechanized controls | Supported |
| Actualist quantification can be modeled by an existence predicate | Supported |
| The selected bilateral `Adm` repair is Fitting's historical proposal | Rejected; project-specific |
| The profile entity quotient is standard Fitting semantics | Rejected; project-specific extension |
| No one has studied a four-valued Gödel–Scott reconstruction before | Not established |
| The quotient factorization theorem is globally novel | Not established |
| De Morgan `n`-filters automatically provide the desired positivity filter | Not established; Gate 10 question |

## Publication rule

The manuscript may make correspondence claims only where the source matrix marks them as direct or standard. It may report the Lean and finite results as project results. It must not use “first,” “novel,” “previously unknown,” or equivalent language until a broader database-level review and expert source check have been completed.

## Next search pass

- inspect citations to Font (1997) and Přenosil (2023) for bilateral prime/filter constructions closest to positivity support;
- search theorem databases and dissertations for quotienting individuals by indiscernibility across positive properties;
- compare the complete AFP definitions line by line with the Lean interfaces, including actualist guards and de-re/de-dicto scope;
- add forward/backward citation chasing from non-classical modal ontological arguments, including work not indexed under “Gödel.”
