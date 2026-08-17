# Research program

## 1. Main question

The project studies whether the inferential architecture of the Gödel–Scott ontological argument changes in a principled and informative way under a four-valued bilateral modal semantics.

The intended values are represented informationally:

```text
T = (1,0)   positive support only
F = (0,1)   negative support only
B = (1,1)   both positive and negative support
N = (0,0)   neither positive nor negative support
```

The central methodological idea is to avoid treating `B` and `N` as two varieties of ordinary falsity. They encode different structural failures: inconsistency and incompleteness.

## 2. Why Gödel–Scott is a useful test theory

Gödel–Scott is unusually suitable because:

1. it has a compact axiom set;
2. its theorem chain is well studied;
3. modal collapse is a known structural phenomenon;
4. the primitive positivity predicate is philosophically and formally sensitive;
5. essence and necessary existence introduce higher-order modal structure;
6. existing mechanizations provide a classical comparison target.

## 3. Strongest candidate contribution

The first paper-worthy target is not the final existence theorem. It is the relationship between bilateral positivity rigidity and bilateral modal collapse.

Let `+φ` mean that `φ` has positive support and `-φ` that it has negative support. Candidate collapse principles are:

```text
MC+ : +φ  => +□φ
MC- : -φ  => -□φ
```

Candidate rigidity principles for positivity include:

```text
R+ : +P(φ) => +□P(φ)
R- : -P(φ) => -□P(φ)
```

The core experiment asks which combinations of `R+`, `R-`, and the remaining Gödel–Scott assumptions force `MC+`, `MC-`, both, or neither.

## 4. Required results before any novelty claim

A strong result should include at least:

- a precise semantics;
- a sound proof system or a carefully delimited semantic study;
- classical recovery under suitable restrictions;
- theorem proofs for positive claims;
- explicit countermodels for non-implications;
- an axiom-minimality or dependency analysis;
- comparison with the standard Scott theory;
- a dedicated prior-art search focused on four-valued/paraconsistent ontological arguments and non-classical positivity predicates.

## 5. Possible result shapes

### Result type A — Decomposition theorem
Classical modal collapse is equivalent, under classical recovery assumptions, to the conjunction of two independent bilateral collapse principles.

### Result type B — Separation theorem
There are models satisfying the four-valued Gödel–Scott lift in which `MC+` holds but `MC-` fails, and conversely.

### Result type C — Rigidity theorem
Only one bilateral component of positivity rigidity is necessary for a corresponding collapse component.

### Result type D — Robustness theorem
The existence chain survives specific gluts or gaps in positivity assignments without explosion or triviality.

### Result type E — Failure theorem
A natural-looking four-valued lift of a Gödel–Scott axiom is too strong and recreates classical collapse or triviality. This would still be valuable because it identifies the wrong lifting principle.

## 6. Design discipline

Every non-classical axiom must be given an explicit name and version. Do not write "the four-valued version of A4" until the translation has been fixed. There may be several inequivalent A4 candidates.

Countermodels are first-class research objects. A failed theorem with a minimal explanatory countermodel is a positive result.
