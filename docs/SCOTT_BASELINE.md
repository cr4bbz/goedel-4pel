# Scott Baseline

## Status

**Gate:** 0 — Baseline and notation  
**Role:** frozen classical control theory for the `goedel-4pel` project  
**Baseline:** Dana Scott's variant of Gödel's ontological argument, using the modern formal presentation in Benzmüller & Scott (2025).

This document fixes the classical theory against which every later four-valued lifting is compared. It is deliberately conservative: nothing in this file is yet a 4PEL axiom.

The project may later vary modal logic, quantifier policy, and the semantics of positivity, but every such variation must state explicitly how it differs from this baseline.

---

## 1. Why Scott is the control theory

Scott's variant is chosen because it has three useful properties for this project:

1. it is a standard, extensively mechanized Gödel-style baseline;
2. Scott's modified definition of essence avoids the inconsistency found in Gödel's 1970 manuscript;
3. its modal-collapse behavior is well studied and therefore provides a sharp control target for a four-valued reconstruction.

The purpose of this baseline is **not** to endorse the theological interpretation of the theory. It is a formal benchmark.

---

## 2. Logical environment

### 2.1 Worlds and individuals

Let:

- `i` be the type of possible worlds;
- `e` be the type of individuals/entities;
- `σ := i → Bool` be the type of modal propositions;
- `γ := e → σ` be the type of intensional properties of individuals.

Thus a property may have different extensions at different possible worlds.

### 2.2 Accessibility

Let

\[
R \subseteq i\times i
\]

be the accessibility relation.

The reference formalization embeds an S5 environment by constraining `R` as an equivalence relation. However, the project records modal dependencies more finely whenever possible. In particular, several central proof steps require less than full S5.

For Gate 0, **S5 is the frozen reference environment**.

Later gates may separately test K, KB, S4, and S5.

### 2.3 Modal operators

For a modal proposition \(\varphi\):

\[
(\Box\varphi)(w)
\quad\text{iff}\quad
\forall v\,(wRv\rightarrow \varphi(v)).
\]

\[
(\Diamond\varphi)(w)
\quad\text{iff}\quad
\exists v\,(wRv\land \varphi(v)).
\]

Global validity is written

\[
\lfloor\varphi\rfloor
\]

and means that \(\varphi\) holds at every world.

### 2.4 Quantification policy

The frozen Scott baseline follows the standard policy used in the modern Isabelle/HOL formalization:

- **actualist quantification** over individuals/entities;
- **possibilist quantification** over propositions and properties.

Write:

\[
\forall^E x\,\varphi(x)
\]

and

\[
\exists^E x\,\varphi(x)
\]

for actualist individual quantification, relativized to entities existing at the world of evaluation.

Property quantifiers such as

\[
\forall\varphi
\]

range possibilistically over intensional properties.

This distinction is part of the baseline and must not be silently changed in later 4PEL experiments.

---

## 3. Primitive notion

The only specifically Gödelian primitive used below is the positivity predicate

\[
P(\varphi),
\]

read:

> property \(\varphi\) is positive.

In the classical baseline, \(P(\varphi)\) is bivalent at each world.

For the later 4PEL theory this assumption will be relaxed, but **not in this document**.

---

## 4. Scott axioms and definitions

The following formulas are the frozen classical baseline.

### A1 — Positivity and property negation

\[
\boxed{
\neg P(\varphi)\leftrightarrow P(\neg\varphi)
}
\]

Here \(\neg\varphi\) denotes the pointwise complement of the property \(\varphi\).

Interpretation:

> A property is non-positive iff its complement is positive.

For the 4PEL project this axiom is a major decomposition target because its classical biconditional can conceal distinct positive- and negative-information constraints.

---

### A2 — Closure under necessary entailment

\[
\boxed{
P(\varphi)\land
\Box\forall^E y\,
(\varphi(y)\rightarrow\psi(y))
\rightarrow
P(\psi)
}
\]

Interpretation:

> If \(\varphi\) is positive and necessarily entails \(\psi\) for all actually existing individuals, then \(\psi\) is positive.

This axiom must **not** be naively translated into 4PEL before a four-valued conditional and consequence relation are fixed.

---

### D1 — Godlikeness

\[
\boxed{
G(x)
\;\equiv\;
\forall\varphi\,
(P(\varphi)\rightarrow\varphi(x))
}
\]

Interpretation:

> An entity is God-like iff it exemplifies every positive property.

Later 4PEL work must decide what counts as "positive" when \(P(\varphi)\) is true-only, false-only, both, or neither.

---

### A3 — Godlikeness is positive

\[
\boxed{
P(G)
}
\]

This is Scott's direct postulate that Godlikeness is positive.

---

### A4 — Rigidity of positivity

\[
\boxed{
P(\varphi)\rightarrow\Box P(\varphi)
}
\]

Interpretation:

> A positive property is necessarily positive.

This is the primary target for bilateral decomposition.

The first candidate split is:

\[
R^+:
\quad
+P(\varphi)\Rightarrow+\Box P(\varphi),
\]

\[
R^-:
\quad
-P(\varphi)\Rightarrow-\Box P(\varphi).
\]

No claim is made here that this is the unique or ultimately correct four-valued lifting.

---

### D2 — Essence

\[
\boxed{
\varphi\operatorname{Ess}x
\;\equiv\;
\varphi(x)
\land
\forall\psi\,
\Bigl(
\psi(x)\rightarrow
\Box\forall^E y\,
(\varphi(y)\rightarrow\psi(y))
\Bigr)
}
\]

Interpretation:

> \(\varphi\) is an essence of \(x\) iff \(x\) exemplifies \(\varphi\), and every property exemplified by \(x\) is necessarily entailed by \(\varphi\).

The conjunct \(\varphi(x)\) is important. Scott's inclusion of actual exemplification avoids the inconsistency associated with Gödel's 1970 essence definition.

---

### D3 — Necessary existence

\[
\boxed{
NE(x)
\;\equiv\;
\forall\varphi\,
\Bigl(
\varphi\operatorname{Ess}x
\rightarrow
\Box\exists^E y\,\varphi(y)
\Bigr)
}
\]

Interpretation:

> An entity has necessary existence iff every one of its essences is necessarily exemplified.

---

### A5 — Necessary existence is positive

\[
\boxed{
P(NE)
}
\]

---

## 5. Classical theorem chain

The baseline includes the following target results.

### T1 — Positive properties are possibly exemplified

\[
\boxed{
P(\varphi)
\rightarrow
\Diamond\exists^E x\,\varphi(x)
}
\]

Classically, T1 follows from A1 and A2.

---

### Corollary — Possible existence of a God-like entity

From T1 and A3:

\[
\boxed{
\Diamond\exists^E x\,G(x)
}
\]

---

### T2 — Godlikeness is an essence of any God-like entity

\[
\boxed{
G(x)\rightarrow G\operatorname{Ess}x
}
\]

In the Scott baseline this follows from A1 and A4 together with D1 and D2.

---

### T3 — Necessary existence of a God-like entity

\[
\boxed{
\Box\exists^E x\,G(x)
}
\]

This is the main existence theorem of the Scott theory.

For this project, T3 is a **control theorem**, not the main research target.

---

### MC — Modal collapse

For arbitrary modal propositions \(\chi\):

\[
\boxed{
\chi\rightarrow\Box\chi
}
\]

This says that every truth is necessary.

The 4PEL project treats MC as the primary structural phenomenon to dissect.

---

## 6. Baseline dependency map

The first coarse dependency graph is:

```text
A1 + A2
   │
   └──> T1: positive properties are possibly exemplified
               │
               + A3
               │
               └──> ◇∃ᴱx G(x)

A1 + A4 + D1 + D2
   │
   └──> T2: G(x) -> G Ess x

T2 + D3 + A5 + modal reasoning
   │
   └──> T3: □∃ᴱx G(x)

A1 + A4 + D1 + T3 + frame conditions
   │
   └──> MC: χ -> □χ
```

This is intentionally coarse. `MODAL_COLLAPSE_SPINE.md` refines the last branch step by step.

A key methodological fact is that **A2, A3, A5, D2, and D3 enter the modal-collapse proof indirectly through T3**, while the local collapse mechanism itself prominently uses A1, A4, and D1.

---

## 7. Classical-recovery requirement for 4PEL

Any proposed four-valued lifting \(S_{4V}\) must satisfy a recovery condition.

Let the classical fragment consist only of valuations:

\[
T=(1,0),
\qquad
F=(0,1),
\]

excluding:

\[
B=(1,1),
\qquad
N=(0,0).
\]

Then, under the project's consistency/completeness restrictions, the four-valued clauses should reproduce the chosen classical connectives, modal operators, quantifier behavior, and Scott theorem chain.

The desired recovery test is therefore:

\[
S_{4V}\restriction_{\{T,F\}}
\cong
S_{\mathrm{Scott}}.
\]

Failure of recovery is allowed only when explicitly intended and documented. It must never occur accidentally.

---

## 8. Deliberately unresolved before Gate 1

This baseline does **not** yet decide:

- which four-valued implication is used;
- which values are designated;
- whether consequence is truth-preserving, bilateral, order-theoretic, or mixed;
- whether `P` is treated as an ordinary four-valued predicate or given additional structure;
- how `A1` is split;
- how `A4` is split;
- how actualist quantification is four-valued;
- whether \(\Box\) and \(\Diamond\) remain dual;
- whether neighborhood semantics eventually replaces or generalizes the relational control semantics.

Those are research decisions, not baseline facts.

---

## 9. Gate 0 exit criteria

`SCOTT_BASELINE.md` is considered frozen when:

- [x] A1–A5 are fixed.
- [x] D1–D3 are fixed.
- [x] T1, possible Godlikeness, T2, T3, and MC are fixed.
- [x] individual/property quantifier policy is recorded.
- [x] intensional properties are recorded.
- [x] S5 is recorded as the reference modal environment.
- [x] the classical-recovery target is explicit.
- [ ] the baseline formulas are reproduced in the chosen proof-assistant syntax.
- [ ] a machine check confirms the frozen baseline independently inside this repository.

The final two items belong to the later mechanization stage and do not block conceptual work on Gate 1.

---

## 10. Sources and provenance

Primary reference for the frozen presentation:

- Christoph Benzmüller & Dana Scott, **"Notes on Gödel's and Scott's variants of the ontological argument"**, *Monatshefte für Mathematik* 208 (2025), 569–611. DOI: `10.1007/s00605-025-02078-x`

Machine-checked Scott formalizations used as cross-checks:

- Archive of Formal Proofs, **Notes_On_Goedels_Ontological_Argument**, including `ScottVariantHOML...` theories.
- Archive of Formal Proofs, **GoedelGod**.

For the current interpretation of the modal-collapse mechanism:

- Christoph Benzmüller, **"A Comment on Modal Collapse and Ultrafilters in Gödel's Ontological Argument"** (2026), arXiv:`2608.07578`.

### Version note

This file freezes the **Scott control theory**, not the final 4PEL system. Any later change to the baseline should be made in a dedicated commit and accompanied by an explanation of whether earlier experimental results remain comparable.
