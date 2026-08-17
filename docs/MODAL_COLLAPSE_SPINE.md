# Modal Collapse Spine

## Status

**Gate:** 0B — classical dependency analysis  
**Target:** Scott-style modal collapse  
**Schema:**

\[
MC(\chi):
\qquad
\chi\rightarrow\Box\chi
\]

for arbitrary modal propositions \(\chi\).

This document isolates the classical proof mechanism that the four-valued project will later split into positive and negative information channels.

It is intentionally a **dependency analysis**, not a new proof of the ontological argument.

---

## 1. Why isolate a proof spine?

A four-valued reconstruction is scientifically useful only if it can say **where** the classical argument changes.

It is therefore insufficient to record merely:

\[
A1,\ldots,A5,D1,D2,D3\vdash MC.
\]

The relevant question is:

> Which local inferential bridge turns an arbitrary contingent truth into a necessary truth?

The modern machine-checked Scott formalizations provide a compact answer. An interactive Isabelle proof of the possibilist Scott variant derives modal collapse using, locally:

- A1;
- A4;
- the definition of Godlikeness;
- T3, the necessary existence of a God-like entity;
- symmetry of the accessibility relation.

The actualist Scott variant also validates modal collapse; the 2025 analysis reports the corresponding proof in the standard Scott theory and closely related quantifier variants.

The structural spine below is the object that `goedel-4pel` will later bilateralize.

---

## 2. The crucial local lemma

Fix a world \(w\), an entity \(x\), and an arbitrary property \(Z\).

Assume:

\[
G(x)@w
\]

and

\[
Z(x)@w.
\]

We want to understand why the Scott theory forces:

\[
\Box\forall z\,(G(z)\rightarrow Z(z))@w.
\]

Call this principle:

\[
\boxed{
L_{\mathrm{share}}
}
\]

or **necessary sharing by God-like entities**.

### Step 2.1 — `Z` must be positive at `w`

Suppose, for contradiction, that

\[
\neg P(Z)@w.
\]

By A1:

\[
\neg P(Z)\leftrightarrow P(\neg Z),
\]

so:

\[
P(\neg Z)@w.
\]

But \(x\) is God-like at \(w\). By D1, a God-like entity possesses every positive property. Hence:

\[
\neg Z(x)@w.
\]

This contradicts the starting assumption:

\[
Z(x)@w.
\]

Therefore:

\[
\boxed{
P(Z)@w.
}
\]

This is already a major structural observation:

> **A1 plus Godlikeness turns every actually exemplified property of a God-like being into a positive property.**

This is stronger than merely saying that a God-like being has all positive properties. In the presence of A1, the implication is locally reversible for properties actually possessed by a God-like entity.

---

### Step 2.2 — Positivity becomes necessary

By A4:

\[
P(Z)\rightarrow\Box P(Z).
\]

Therefore:

\[
P(Z)@w
\quad\Rightarrow\quad
\Box P(Z)@w.
\]

Hence at every \(v\) accessible from \(w\):

\[
P(Z)@v.
\]

This is the **rigidity step**.

---

### Step 2.3 — Every accessible God-like entity has `Z`

Take arbitrary \(v\) such that:

\[
wRv.
\]

From Step 2.2:

\[
P(Z)@v.
\]

If:

\[
G(z)@v,
\]

then D1 yields:

\[
Z(z)@v.
\]

Thus:

\[
\forall z\,(G(z)\rightarrow Z(z))@v.
\]

Since \(v\) was arbitrary:

\[
\boxed{
\Box\forall z\,(G(z)\rightarrow Z(z))@w.
}
\]

This proves the local sharing lemma.

---

## 3. Why this lemma is the 4PEL pressure point

The classical chain just used is:

```text
Z(x)
  │
  │  together with G(x)
  ▼
A1 + D1
  │
  ▼
P(Z)
  │
  │  A4
  ▼
□P(Z)
  │
  │  D1 at accessible worlds
  ▼
□∀z (G(z) -> Z(z))
```

This is the first place the four-valued project should cut.

Classically, A1 supplies a sharp dichotomy:

\[
P(Z)
\quad\text{or}\quad
P(\neg Z),
\]

and the contradiction between \(Z(x)\) and \(\neg Z(x)\) eliminates the latter.

Under 4PEL, that inference may no longer behave as a single Boolean switch.

In particular:

- \(P(Z)\) may be both supported and opposed;
- \(P(Z)\) may be neither supported nor opposed;
- \(P(\neg Z)\) may coexist with \(P(Z)\);
- the contradiction \(Z(x),\neg Z(x)\) need not trivialize the theory.

Therefore the classical step

\[
G(x),Z(x)\Rightarrow P(Z)
\]

is a prime candidate for decomposition into distinct bilateral lemmas.

---

## 4. From an arbitrary proposition to a property

Now fix an arbitrary modal proposition \(Q\).

Define the constant-in-individuals property:

\[
Z_Q
:=
\lambda z.\,Q.
\]

At any world:

\[
Z_Q(x)
\]

has exactly the same truth condition as \(Q\).

Therefore the local sharing lemma gives:

\[
G(x)\land Q
\Rightarrow
\Box\forall z\,(G(z)\rightarrow Q).
\]

Since \(Q\) is independent of \(z\), this says:

> If a God-like entity exists at the current world and \(Q\) is currently true, then necessarily every God-like entity is found only at worlds where \(Q\) is true.

Call this:

\[
\boxed{
L_Q
}
\]

with schematic form:

\[
\exists x\,G(x)
\rightarrow
\Bigl(
Q\rightarrow
\Box\forall z\,(G(z)\rightarrow Q)
\Bigr).
\]

This is the bridge from a completely arbitrary proposition into the positivity/Godlikeness machinery.

---

## 5. T3 supplies God-like witnesses across accessible worlds

Scott's main theorem is:

\[
T3:
\qquad
\Box\exists^E x\,G(x).
\]

For modal collapse, T3 is not used merely as a theological conclusion. It functions as a **witness distributor**.

At a world \(w\), T3 ensures God-like witnesses at worlds accessible from \(w\).

The frame condition then links those witnesses back to the world from which the arbitrary proposition \(Q\) is being evaluated.

In the compact Isabelle proof of the possibilist Scott variant, symmetry of the accessibility relation is an explicit dependency of the final collapse step.

---

## 6. World-by-world reconstruction

Let \(w\) be arbitrary and assume:

\[
Q@w.
\]

To prove modal collapse at \(w\), we must show:

\[
\Box Q@w.
\]

So choose arbitrary \(v\) with:

\[
wRv.
\]

We need to prove:

\[
Q@v.
\]

### Step 6.1 — Obtain a God-like witness at `w`

By symmetry:

\[
wRv
\quad\Rightarrow\quad
vRw.
\]

T3 is globally valid, so at \(v\):

\[
\Box\exists^E x\,G(x).
\]

Because \(vRw\):

\[
\exists^E x\,G(x)@w.
\]

Thus the antecedent needed for \(L_Q\) is available at \(w\).

---

### Step 6.2 — Necessarily, Godlikeness implies `Q`

At \(w\) we have:

\[
Q@w
\]

and:

\[
\exists^E x\,G(x)@w.
\]

By \(L_Q\):

\[
\Box\forall z\,(G(z)\rightarrow Q)@w.
\]

Therefore at the chosen accessible world \(v\):

\[
\forall z\,(G(z)\rightarrow Q)@v.
\]

---

### Step 6.3 — Obtain a God-like witness at `v`

From T3 at \(w\) and \(wRv\):

\[
\exists^E z\,G(z)@v.
\]

Choose such a \(z\). Then:

\[
G(z)@v.
\]

Together with Step 6.2:

\[
Q@v.
\]

Since \(v\) was arbitrary:

\[
\Box Q@w.
\]

Hence:

\[
Q@w\rightarrow\Box Q@w.
\]

Since \(w\) and \(Q\) were arbitrary:

\[
\boxed{
Q\rightarrow\Box Q.
}
\]

That is modal collapse.

---

## 7. The proof spine in one diagram

```text
                         ┌─────────────┐
                         │  G(x) @ w   │
                         └──────┬──────┘
                                │
                         ┌──────▼──────┐
                         │   Z(x) @ w  │
                         └──────┬──────┘
                                │
                   A1 + D1      │
                                ▼
                         ┌─────────────┐
                         │   P(Z) @ w  │
                         └──────┬──────┘
                                │ A4
                                ▼
                         ┌─────────────┐
                         │ □P(Z) @ w   │
                         └──────┬──────┘
                                │ D1
                                ▼
              ┌─────────────────────────────────┐
              │ □∀z (G(z) -> Z(z)) @ w         │
              └────────────────┬────────────────┘
                               │
                               │ Z := λz.Q
                               ▼
              ┌─────────────────────────────────┐
              │ Q -> □∀z(G(z) -> Q) @ w        │
              └────────────────┬────────────────┘
                               │
                 T3 + frame symmetry
                               │
                               ▼
                         ┌─────────────┐
                         │   □Q @ w    │
                         └─────────────┘
```

The project should preserve this graph and annotate later which arrows survive under each four-valued lifting.

---

## 8. Direct versus indirect dependencies

The collapse theorem ultimately belongs to the whole Scott theory, but the proof spine separates **direct** and **indirect** dependencies.

### Direct local dependencies

The local conversion

\[
G(x),Z(x)\Rightarrow\Box\forall z(G(z)\rightarrow Z(z))
\]

uses:

- A1;
- A4;
- D1.

These are the most important axioms for the first 4PEL experiment.

### Global witness dependency

The final arbitrary-proposition collapse additionally uses:

- T3;
- a suitable frame condition, with symmetry explicit in the machine-checked proof used as our structural guide.

### Indirect dependencies through T3

T3 itself is downstream of the rest of the Scott theory, including the machinery involving:

- A2;
- A3;
- D2;
- D3;
- A5;
- prior existence and essence results.

Therefore it would be misleading to claim:

\[
A1+A4+D1\vdash MC.
\]

The scientifically useful claim is narrower:

> **Given the necessary-existence theorem T3, the local mechanism converting arbitrary truth into necessity is concentrated in A1, A4, D1, and the modal frame conditions.**

This distinction must be kept explicit throughout the 4PEL analysis.

---

## 9. First bilateral decomposition targets

The classical spine suggests at least four independent switches.

### A1 decomposition

Candidate clauses:

\[
A1^+:
\quad
+P(\neg\varphi)
\iff
-P(\varphi),
\]

\[
A1^-:
\quad
-P(\neg\varphi)
\iff
+P(\varphi).
\]

These are provisional names only. Alternative directional or weaker liftings must also be considered.

### A4 decomposition

\[
R^+:
\quad
+P(\varphi)
\Rightarrow
+\Box P(\varphi),
\]

\[
R^-:
\quad
-P(\varphi)
\Rightarrow
-\Box P(\varphi).
\]

### Collapse decomposition

\[
MC^+:
\quad
+\chi
\Rightarrow
+\Box\chi,
\]

\[
MC^-:
\quad
-\chi
\Rightarrow
-\Box\chi.
\]

The first factorial experiment is therefore:

\[
(A1^+,A1^-,R^+,R^-)
\longmapsto
(MC^+,MC^-).
\]

With four binary switches there are:

\[
2^4=16
\]

basic configurations before additional choices about conditional, quantification, or modal semantics are varied.

---

## 10. Research questions generated by the spine

### Q1 — Does `G + Z` still force positive support for `P(Z)`?

Classically:

\[
G(x),Z(x)\Rightarrow P(Z).
\]

Four-valuedly we may instead obtain only:

\[
G^+(x),Z^+(x)\Rightarrow +P(Z),
\]

or the implication may fail when \(P(Z)\) is glutty or gappy.

This should be tested before any full reconstruction of T3.

### Q2 — Can positive rigidity alone generate `MC+`?

Test:

\[
R^+
\stackrel{?}{\Longrightarrow}
MC^+
\]

under fixed remaining assumptions.

### Q3 — Is negative rigidity relevant to positive collapse?

Test cross-channel implications:

\[
R^-
\stackrel{?}{\Longrightarrow}
MC^+,
\]

and:

\[
R^+
\stackrel{?}{\Longrightarrow}
MC^-.
\]

### Q4 — Does A1 couple the channels so strongly that separation disappears?

A strong bilateral A1 may reconstruct enough classical complementarity to force:

\[
MC^+\iff MC^-.
\]

A weaker A1 may permit their separation.

This is a central hypothesis to test.

### Q5 — What happens when `P(Z)=B`?

If:

\[
P(Z)=B,
\]

then both \(Z\) and its complement may interact with Godlikeness.

Because the background logic is paraconsistent, this need not trivialize the system.

The precise survival or failure of \(L_{\mathrm{share}}\) is therefore a high-value countermodel target.

### Q6 — What happens when `P(Z)=N`?

A gap may block the classical A1 step entirely.

This could produce a different failure mode from inconsistency, supporting the project's gap/glut asymmetry hypothesis.

---

## 11. Experimental table to build next

The first table should keep T3 fixed as a control theorem and vary only the local collapse mechanism.

| A1+ | A1- | R+ | R- | MC+ | MC- | Smallest countermodel / proof |
|---:|---:|---:|---:|---:|---:|---|
| 0 | 0 | 0 | 0 | ? | ? | |
| 0 | 0 | 0 | 1 | ? | ? | |
| 0 | 0 | 1 | 0 | ? | ? | |
| 0 | 0 | 1 | 1 | ? | ? | |
| 0 | 1 | 0 | 0 | ? | ? | |
| 0 | 1 | 0 | 1 | ? | ? | |
| 0 | 1 | 1 | 0 | ? | ? | |
| 0 | 1 | 1 | 1 | ? | ? | |
| 1 | 0 | 0 | 0 | ? | ? | |
| 1 | 0 | 0 | 1 | ? | ? | |
| 1 | 0 | 1 | 0 | ? | ? | |
| 1 | 0 | 1 | 1 | ? | ? | |
| 1 | 1 | 0 | 0 | ? | ? | |
| 1 | 1 | 0 | 1 | ? | ? | |
| 1 | 1 | 1 | 0 | ? | ? | |
| 1 | 1 | 1 | 1 | ? | ? | |

This table is **not yet meaningful** until Gate 1 fixes the bilateral semantics and Gate 2 fixes the modal lift. It is included now to define the experimental target.

---

## 12. Modal-frame control

The 2025 Scott analysis reports:

- modal collapse in the standard Scott setting;
- countermodels to T3 and MC in base logic K;
- the standard embedding uses S5 as the reference environment;
- individual steps often require less than full S5.

The 4PEL experiment should therefore avoid varying everything at once.

Recommended order:

1. hold the S5 reference frame fixed;
2. study bilateral A1/A4 effects;
3. once the four-valued mechanism is understood, repeat the experiment over K / KB / S4 / S5.

This separates:

\[
\text{truth-value effects}
\]

from:

\[
\text{frame-condition effects}.
\]

---

## 13. Relation to the 2026 rigidity result

Recent machine-checked work argues that the ultrafilter structure of positive properties does not by itself force modal collapse. Collapse-free models can retain relevant filter/ultrafilter structure, while the rigidity of positivity is identified as a primary driver of the collapse phenomenon.

That makes the present decomposition especially well motivated.

The 4PEL question is more fine-grained:

> If classical positivity rigidity is itself decomposed into positive and negative information persistence, which component is responsible for which component of modal collapse?

This is the central structural question of the repository.

---

## 14. Gate 0B exit criteria

This proof-spine document is considered complete when:

- [x] the local `G + Z -> P(Z)` mechanism is explicit;
- [x] A1's role is isolated;
- [x] A4's rigidity role is isolated;
- [x] D1's role is isolated;
- [x] T3 is separated as a global witness theorem;
- [x] frame symmetry is recorded as an explicit dependency of the machine-checked guide proof;
- [x] arbitrary propositions are connected via the constant property `λz.Q`;
- [x] the first bilateral experiment is stated;
- [ ] the exact actualist Scott proof is independently re-mechanized in this repository;
- [ ] each dependency is machine-minimized in the project's own formalization.

---

## 15. Sources and provenance

Primary Scott baseline:

- Christoph Benzmüller & Dana Scott, **"Notes on Gödel's and Scott's variants of the ontological argument"**, *Monatshefte für Mathematik* 208 (2025), 569–611. DOI: `10.1007/s00605-025-02078-x`

Machine-checked proof-spine guide:

- Archive of Formal Proofs, **Notes_On_Goedels_Ontological_Argument**, `ScottVariantHOMLposs`, lemma `MC`.

Current rigidity context:

- Christoph Benzmüller, **"A Comment on Modal Collapse and Ultrafilters in Gödel's Ontological Argument"** (2026), arXiv:`2608.07578`.

### Caution

The AFP proof quoted conceptually above is used as a **structural dependency guide**. The repository's frozen baseline uses actualist individual quantification. Before publication, the exact actualist version of every dependency claim must be independently mechanized and minimized inside `goedel-4pel`.
