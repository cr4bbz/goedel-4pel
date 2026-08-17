# Four-Valued Kernel

## Status

**Gate:** 1 — Four-valued kernel  
**Version:** `kernel-v0.1`  
**Role:** propositional semantic base for all later Gödel–Scott liftings

This document fixes the minimal four-valued propositional semantics used by `goedel-4pel` before modality, quantification, positivity, Godlikeness, essence, or necessary existence are added.

The design goal is conservative: use the standard Belnap–Dunn / FDE information structure wherever possible, and postpone genuinely project-specific choices until the Gödel–Scott axioms are lifted.

Nothing in this document defines a four-valued object-language implication.

---

## 1. Semantic values

Every formula carries two logically independent bits:

\[
v(\varphi)=(t(\varphi),f(\varphi))\in\{0,1\}^2.
\]

Interpretation:

- `t(φ)=1`: positive support for \(\varphi\);
- `f(φ)=1`: negative support for \(\varphi\).

This gives four information states:

| Symbol | Pair | Reading |
|---|---:|---|
| `T` | `(1,0)` | positive support only |
| `F` | `(0,1)` | negative support only |
| `B` | `(1,1)` | both positive and negative support |
| `N` | `(0,0)` | neither positive nor negative support |

`B` and `N` are not alternative kinds of ordinary falsity. They represent, respectively, informational conflict and informational incompleteness.

For semantic work we prefer signed satisfaction notation:

\[
+\varphi
\quad\text{iff}\quad
t(\varphi)=1,
\]

\[
-\varphi
\quad\text{iff}\quad
f(\varphi)=1.
\]

Once worlds are introduced in Gate 2, these become:

\[
w\models^+\varphi,
\qquad
w\models^-\varphi.
\]

---

## 2. Atomic valuations

For each propositional atom \(p\), positive and negative support are assigned independently.

Equivalently, a valuation contains two sets:

\[
V^+\subseteq At,
\qquad
V^-\subseteq At.
\]

with:

\[
+p \iff p\in V^+,
\]

\[
-p \iff p\in V^-.
\]

No consistency condition such as

\[
V^+\cap V^-=\varnothing
\]

is imposed, and no completeness condition such as

\[
V^+\cup V^-=At
\]

is imposed.

This independence is the source of the `B` and `N` states.

---

## 3. Negation

Negation swaps the two support channels:

\[
+\neg\varphi
\iff
-\varphi,
\]

\[
-\neg\varphi
\iff
+\varphi.
\]

Equivalently:

\[
v(\neg\varphi)
=
(f(\varphi),t(\varphi)).
\]

Truth table:

| \(\varphi\) | \(\neg\varphi\) |
|---|---|
| `T` | `F` |
| `F` | `T` |
| `B` | `B` |
| `N` | `N` |

Immediate consequences:

\[
\neg\neg\varphi\equiv\varphi,
\]

while gluts and gaps are fixed points of negation at the status level.

---

## 4. Conjunction

Positive support for a conjunction requires positive support for both conjuncts. Negative support requires negative support for at least one conjunct:

\[
+(\varphi\land\psi)
\iff
(+\varphi\land+\psi),
\]

\[
-(\varphi\land\psi)
\iff
(-\varphi\lor-\psi).
\]

Equivalently:

\[
v(\varphi\land\psi)
=
(t_\varphi\land t_\psi,
 f_\varphi\lor f_\psi).
\]

Truth table:

| `∧` | `T` | `F` | `B` | `N` |
|---|---|---|---|---|
| `T` | `T` | `F` | `B` | `N` |
| `F` | `F` | `F` | `F` | `F` |
| `B` | `B` | `F` | `B` | `F` |
| `N` | `N` | `F` | `F` | `N` |

---

## 5. Disjunction

Positive support for a disjunction requires positive support for at least one disjunct. Negative support requires negative support for both disjuncts:

\[
+(\varphi\lor\psi)
\iff
(+\varphi\lor+\psi),
\]

\[
-(\varphi\lor\psi)
\iff
(-\varphi\land-\psi).
\]

Equivalently:

\[
v(\varphi\lor\psi)
=
(t_\varphi\lor t_\psi,
 f_\varphi\land f_\psi).
\]

Truth table:

| `∨` | `T` | `F` | `B` | `N` |
|---|---|---|---|---|
| `T` | `T` | `T` | `T` | `T` |
| `F` | `T` | `F` | `B` | `N` |
| `B` | `T` | `B` | `B` | `T` |
| `N` | `T` | `N` | `T` | `N` |

---

## 6. De Morgan structure

The kernel validates the expected De Morgan equivalences at the level of both support channels:

\[
\neg(\varphi\land\psi)
\equiv
\neg\varphi\lor\neg\psi,
\]

\[
\neg(\varphi\lor\psi)
\equiv
\neg\varphi\land\neg\psi.
\]

Together with double negation, this gives the standard De Morgan lattice structure used by FDE.

---

## 7. Information order

The four values also carry a natural information order:

\[
(t,f)\le_k(t',f')
\quad\text{iff}\quad
t\le t'\text{ and }f\le f'.
\]

Hence:

```text
        B
       / \
      T   F
       \ /
        N
```

Under this order:

- `N` contains the least information;
- `B` contains the most information;
- `T` and `F` are incomparable.

This order is recorded because later monotonicity questions may matter for positivity and modal persistence. It is **not** adopted as the definition of logical consequence in this gate.

---

## 8. Designated values and ordinary consequence

For the underlying FDE-style consequence relation, positive support is the preserved notion.

The positively designated values are:

\[
D^+=\{T,B\}.
\]

Equivalently, a formula is designated iff:

\[
+\varphi.
\]

For a set of premises \(\Gamma\):

\[
\Gamma\models_{FDE}\varphi
\]

iff every valuation that positively satisfies every member of \(\Gamma\) also positively satisfies \(\varphi\):

\[
\forall v
\Bigl[
(\forall\gamma\in\Gamma\; +_v\gamma)
\Rightarrow
+_v\varphi
\Bigr].
\]

Negative support has the corresponding status class:

\[
D^-=\{F,B\},
\]

but `D-` is **not** a second set of designated truth values for the ordinary FDE consequence relation. It records formulas carrying negative support and will be used in bilateral meta-conditions.

---

## 9. Bilateral meta-conditions

The Gödel experiment needs to ask separately whether positive or negative support propagates through an axiom or operator.

For this purpose we introduce signed meta-conditions.

Examples:

\[
+\varphi\Rightarrow+\psi
\]

means:

> in every model/state under consideration, whenever \(\varphi\) has positive support, \(\psi\) has positive support.

Likewise:

\[
-\varphi\Rightarrow-\psi.
\]

Cross-channel conditions are also meaningful:

\[
+\varphi\Rightarrow-\psi,
\qquad
-\varphi\Rightarrow+\psi.
\]

These arrows are **metalanguage constraints**, not formulas of the object language.

This distinction is essential for later statements such as:

\[
R^+:
+P(\varphi)\Rightarrow+\Box P(\varphi)
\]

and:

\[
MC^-:
-\chi\Rightarrow-\Box\chi.
\]

Gate 1 therefore fixes two layers:

1. ordinary FDE consequence by positive-support preservation;
2. signed bilateral meta-conditions for componentwise structural analysis.

---

## 10. Why implication is deliberately absent

The Gate 1 object language contains:

\[
\neg,\land,\lor
\]

but no accepted four-valued connective:

\[
\to.
\]

A material-looking candidate such as

\[
\varphi\to_m\psi
:=
\neg\varphi\lor\psi
\]

can be defined syntactically, but it is **not** adopted as the project's conditional at this stage.

Reason: the Scott axioms A2, D1, D2, and D3 contain implications in structurally important positions. Choosing a conditional before fixing what inferential behavior those occurrences must preserve would silently decide substantive parts of the research question.

Therefore later gates must distinguish:

- semantic/meta-level consequence;
- candidate object-language conditionals;
- direct bilateral liftings of classical axioms.

No notation of the form "the 4PEL implication" is permitted until this comparison has been completed.

---

## 11. Paraconsistency

Explosion fails.

Let:

\[
v(p)=B,
\qquad
v(q)=N.
\]

Then:

\[
+p
\]

and, because negation swaps channels:

\[
+\neg p.
\]

But:

\[
\not +q.
\]

Therefore:

\[
p,\neg p\not\models_{FDE}q.
\]

So contradiction does not entail arbitrary conclusions.

This property is essential for later experiments with glutty positivity assignments such as:

\[
P(\varphi)=B.
\]

---

## 12. Paracompleteness

Excluded middle is not valid in general.

Let:

\[
v(p)=N.
\]

Then:

\[
v(\neg p)=N,
\]

and therefore:

\[
v(p\lor\neg p)=N.
\]

Hence:

\[
\not\models_{FDE}p\lor\neg p.
\]

This is essential for later experiments with gappy positivity assignments such as:

\[
P(\varphi)=N.
\]

---

## 13. Classical fragment and recovery

Define a valuation as **classical** when every atom receives only:

\[
T=(1,0)
\quad\text{or}\quad
F=(0,1).
\]

### Closure lemma

If all atoms in a formula receive classical values, then every formula built from:

\[
\neg,\land,\lor
\]

also receives only `T` or `F`.

### Connective recovery

On the classical fragment, the Gate 1 tables reduce exactly to ordinary Boolean negation, conjunction, and disjunction.

### Consequence recovery

For the implication-free language:

\[
\Gamma\models_{FDE}\varphi
\]

restricted to classical valuations agrees with ordinary classical truth preservation.

Thus the propositional kernel satisfies the first required recovery condition:

\[
S_{4V}^{prop}\restriction_{\{T,F\}}
\cong
S_{CL}^{\neg,\land,\lor}.
\]

Full recovery of Scott's higher-order modal theory is a later-gate theorem.

---

## 14. Gate 1 invariants

Every later extension must preserve the following unless an explicit versioned deviation is introduced.

### K1 — Independent atomic support

Positive and negative atomic support are independent.

### K2 — Involutive negation

\[
+\neg\varphi\iff-\varphi,
\qquad
-\neg\varphi\iff+\varphi.
\]

### K3 — FDE conjunction

\[
+(\varphi\land\psi)\iff(+\varphi\land+\psi),
\]

\[
-(\varphi\land\psi)\iff(-\varphi\lor-\psi).
\]

### K4 — FDE disjunction

\[
+(\varphi\lor\psi)\iff(+\varphi\lor+\psi),
\]

\[
-(\varphi\lor\psi)\iff(-\varphi\land-\psi).
\]

### K5 — Positive-support consequence

Ordinary consequence preserves `+` satisfaction.

### K6 — No primitive conditional yet

No specific four-valued implication is part of `kernel-v0.1`.

### K7 — Classical recovery

The `T/F` fragment recovers classical `¬`, `∧`, `∨` semantics and consequence.

---

## 15. Immediate consequences for the Gödel project

Gate 1 already sharpens several later questions.

### A1 can no longer be treated as a single Boolean equivalence

Since:

\[
+\neg\alpha\iff-\alpha,
\]

a statement about `P(¬φ)` can couple positive support for one positivity claim to negative support for another.

Candidate A1 liftings therefore need to be expressed componentwise and compared rather than inferred from a single unspecified biconditional.

### A4 naturally admits channel-specific persistence

Once modality is defined, the project can independently test:

\[
R^+:
+P(\varphi)\Rightarrow+\Box P(\varphi),
\]

\[
R^-:
-P(\varphi)\Rightarrow-\Box P(\varphi).
\]

### Gluts and gaps are now formally distinct experimental inputs

\[
P(\varphi)=B
\]

means both support channels are active, while:

\[
P(\varphi)=N
\]

means neither is active.

Any later theorem that treats these states identically must derive that identification from additional axioms; the kernel itself does not collapse them.

---

## 16. Deliberately unresolved after Gate 1

Gate 1 does **not** decide:

- modal clauses for `□` and `◇`;
- relational versus neighborhood semantics;
- object-language implication;
- quantifier clauses;
- existence predicates for actualist quantification;
- semantics of the positivity predicate `P` beyond ordinary four-valued status;
- any lifting of A1–A5 or D1–D3;
- any form of Godlikeness, essence, or necessary existence;
- whether modal duality survives unchanged.

These omissions are intentional experimental controls.

---

## 17. Gate 1 exit criteria

Gate 1 is complete at the semantic-design level when:

- [x] signed satisfaction notation is fixed;
- [x] the four values are fixed;
- [x] positive designated values are fixed;
- [x] negative-support status is fixed;
- [x] ordinary semantic consequence is fixed;
- [x] bilateral meta-conditions are distinguished from object-language implication;
- [x] negation is fixed;
- [x] conjunction is fixed;
- [x] disjunction is fixed;
- [x] truth tables are recorded;
- [x] paraconsistency has an explicit countermodel;
- [x] paracompleteness has an explicit countermodel;
- [x] the classical propositional recovery fragment is stated;
- [ ] a machine-readable model evaluator reproduces the tables;
- [ ] the recovery and countermodel claims are mechanized.

The final two items belong to the later mechanization workflow and do not block Gate 2 semantic design.

---

## 18. Literature anchors

The kernel follows the standard Belnap–Dunn / First-Degree Entailment four-valued architecture rather than introducing a new propositional logic.

Key anchors:

- Nuel D. Belnap, **"A Useful Four-Valued Logic"**, in *Modern Uses of Multiple-Valued Logic* (1977).
- J. Michael Dunn's four-valued semantics for First-Degree Entailment and subsequent Belnap–Dunn literature.
- Henrique Antunes & Abílio Rodrigues, **"On Universally Free First-Order Extensions of Belnap-Dunn's Four-Valued Logic and Nelson's Paraconsistent Logic N4"**, arXiv:`2412.19767`.
- Yaroslav Petrukhin, **"Essence and Accident Modalities Meet Belnapian Truth Values"**, *Studia Logica* (2026), DOI: `10.1007/s11225-026-10250-z`.

The later modal gate should compare its clauses explicitly with established Belnap–Dunn modal semantics before choosing the project's final modal lift.
