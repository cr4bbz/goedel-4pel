# Gödel–Scott axiom matrix

This file is deliberately a matrix rather than a finished translation. Each classical axiom may admit several inequivalent four-valued liftings.

## Legend

- `CL`: exact classical baseline statement, to be frozen in Gate 0.
- `4V-naive`: direct syntactic replacement using the selected four-valued connectives.
- `4V+`: constraint on positive support.
- `4V-`: constraint on negative support.
- `4V±`: combined bilateral constraint.
- `Status`: open / candidate / rejected / proved / countermodelled.

## Matrix

| Item | Classical role | 4V question | Candidate split | Status |
|---|---|---|---|---|
| A1 | relation between positivity and negation | Does positivity of `¬φ` track non-positivity, negative support for positivity, or something stronger? | positive and negative clauses must be separated | open |
| A2 | closure of positivity under entailment/necessary entailment | Which consequence relation is intended? Does closure preserve positive support only? | `A2+`, possible `A2-` analogue | open |
| A3 | Godlikeness is positive | Is `P(G)` exactly `T`, merely positively supported, or allowed to be `B`? | exact vs designated positivity | open |
| A4 | positivity is necessary / rigid | Which component of positivity persists modally? | `R+`, `R-`, `R±` | **priority** |
| A5 | necessary existence is positive | Same issue as A3, but downstream effects may be stronger | exact vs designated positivity | open |
| D1 | definition of Godlikeness | Which properties count when `P(φ)=B` or `N`? | support-based vs exact-positive Godlikeness | open |
| D2 | essence | How do universal/necessary conditions behave under gluts and gaps? | several candidates expected | deferred |
| D3 | necessary existence | What counts as exemplification of every essence? | several candidates expected | deferred |

## Priority experiment: A4

Do not begin by assuming a single four-valued A4.

Test at least:

```text
R+ : +P(φ) => +□P(φ)
R- : -P(φ) => -□P(φ)
R± : R+ and R-
```

Then evaluate independently:

```text
MC+ : +φ => +□φ
MC- : -φ => -□φ
```

The first decisive table should therefore have the form:

| Assumptions | MC+ | MC- | Countermodel / proof |
|---|---:|---:|---|
| R+ only | ? | ? | |
| R- only | ? | ? | |
| R+ + R- | ? | ? | |
| neither | ? | ? | |

All other Scott assumptions used in the experiment must be listed explicitly in each row.
