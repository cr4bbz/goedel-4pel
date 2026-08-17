# Modal Collapse Spine

## Status

**Origin:** Gate 0B — classical dependency analysis  
**Revision:** Gate 3 correction  
**Version:** `collapse-spine-v0.2`  
**Classical target:** Scott-style modal collapse

\[
MC(\chi):\qquad \chi\rightarrow\Box\chi.
\]

This document isolates the classical proof mechanism and records the Gate-3 corrections required for a non-trivial bilateral decomposition.

---

## 1. Classical dependency spine

The modern machine-checked Scott formalizations reveal a compact local mechanism behind modal collapse. Given a God-like individual `x` and a property `Z` exemplified by `x`, the classical theory derives:

```text
G(x), Z(x)
    |
    | A1 + D1 + classical contradiction elimination
    v
P(Z)
    |
    | A4
    v
□P(Z)
    |
    | D1 at accessible worlds
    v
□∀z (G(z) -> Z(z))
```

Substituting the constant-in-individuals property

\[
Z_Q:=\lambda z.\,Q
\]

embeds an arbitrary modal proposition `Q` into this mechanism. T3 supplies God-like witnesses across accessible worlds, and the relevant frame conditions complete the derivation of

\[
Q\rightarrow\Box Q.
\]

The local mechanism therefore concentrates on A1, A4, and D1, while T3 supplies the global witness structure. A2, A3, D2, D3, and A5 enter indirectly through the proof of T3.

---

## 2. The classical reflection step

The first pressure point is

\[
\boxed{G(x),Z(x)\Rightarrow P(Z).}
\]

Classically, suppose `¬P(Z)`. A1 gives `P(¬Z)`. Godlikeness then gives `¬Z(x)`, contradicting `Z(x)`. Hence `P(Z)`.

This short reductio hides at least two classical background commitments:

1. the contradiction between `Z(x)` and `¬Z(x)` excludes the assumed branch;
2. once the non-positive branch is excluded, positivity information is complete enough to leave `P(Z)`.

These commitments become visible under FDE.

---

## 3. Gate-3 signed interface

For the local analysis only, use the support interface

\[
D1^+:\qquad +G(x)\land+P(\varphi)\Rightarrow+\varphi(x).
\]

This is not yet the final four-valued definition of Godlikeness.

The natural positive reflection target is

\[
REF^+:\qquad +G(x)\land+Z(x)\Rightarrow+P(Z).
\]

Gate 3 establishes that even **strong bilateral A1 + `D1+`** does not force `REF+`.

### Glut obstruction

A local signed counterassignment is:

\[
v(Z(x))=B,
\qquad
v(P(Z))=F,
\qquad
v(P(\neg Z))=T.
\]

Strong A1 is respected. Since `+P(¬Z)`, `D1+` requires `+¬Z(x)`, equivalently `-Z(x)`, which the glut already supplies. But `+P(Z)` still fails.

### Gap obstruction

A second local counterassignment is:

\[
v(Z(x))=T,
\qquad
v(P(Z))=v(P(\neg Z))=N.
\]

Strong A1 preserves the gap and `D1+` is silent, so `+P(Z)` again fails.

The glut and gap cases therefore obstruct the classical bridge for different reasons.

---

## 4. Correct A1 decomposition

Scott A1 is

\[
\neg P(\varphi)\leftrightarrow P(\neg\varphi).
\]

The earlier attempt to use two biconditional channel schemas as independent switches was redundant under involutive property negation. The independent directional clauses are:

\[
A1_L:\qquad -P(\varphi)\Rightarrow+P(\neg\varphi),
\]

\[
A1_R:\qquad +P(\neg\varphi)\Rightarrow-P(\varphi).
\]

Their conjunction is strong A1 and gives

\[
v(P(\neg\varphi))=\operatorname{swap}(v(P(\varphi))),
\]

so `T/F` are exchanged while `B/N` are preserved.

See `docs/POSITIVITY_LIFT.md` for independence witnesses.

---

## 5. Correct A4 rigidity channels

The direct four-valued A4 candidate is

\[
R^+:\qquad +P(\varphi)\Rightarrow+\Box P(\varphi).
\]

The previously proposed negative clause

\[
-P(\varphi)\Rightarrow-\Box P(\varphi)
\]

is **retired**. Under the fixed bilateral modal semantics,

\[
w\models^-\Box\psi
\iff
\exists v(wRv\land v\models^-\psi),
\]

so on any reflexive frame the current world itself witnesses this condition. It is therefore not a rigidity principle in S5.

The informative negative-persistence target is instead

\[
R^-_{\mathrm{nec}}:\qquad
-P(\varphi)\Rightarrow+\Box\neg P(\varphi),
\]

or equivalently

\[
-P(\varphi)\Rightarrow-\Diamond P(\varphi).
\]

Gate 3 establishes:

\[
\boxed{A1_L+A1_R+R^+\models R^-_{\mathrm{nec}}.}
\]

Thus strong A1 couples the rigidity channels.

---

## 6. Correct bilateral modal-collapse targets

The positive component remains

\[
\boxed{MC^+:\qquad +\chi\Rightarrow+\Box\chi.}
\]

The earlier candidate

\[
-\chi\Rightarrow-\Box\chi
\]

is likewise reflexively trivial and is retired.

The informative negative component is universal persistence of negative support:

\[
\boxed{MC^-:\qquad -\chi\Rightarrow+\Box\neg\chi.}
\]

By Gate-2 modal duality:

\[
MC^-\quad\Longleftrightarrow\quad
-\chi\Rightarrow-\Diamond\chi.
\]

This is the correct classical counterpart: applying ordinary modal collapse to `¬χ` gives

\[
\neg\chi\rightarrow\Box\neg\chi.
\]

Hence the Gate-4 separation question is genuinely:

\[
MC^+\stackrel{?}{\Longleftrightarrow}MC^-.
\]

---

## 7. Recovering the classical local reflection bridge

At the metalanguage level, a sufficient recovery package for `REF+` is:

### A1 direction

\[
A1_L:\quad -P(Z)\Rightarrow+P(\neg Z).
\]

### God-like support interface

\[
D1^+:\quad +G(x)\land+P(\neg Z)\Rightarrow+\neg Z(x).
\]

### Consistency of the relevant exemplification

\[
+G(x)\land+Z(x)\Rightarrow\neg(-Z(x)),
\]

where the outer negation is metalanguage denial of negative satisfaction.

### Completeness of positivity information

\[
+P(Z)\ \text{or}\ -P(Z).
\]

Then assuming `-P(Z)` produces `-Z(x)`, contradicting the consistency condition. Positivity completeness therefore leaves `+P(Z)`.

So the classical bridge factorizes as:

```text
A1-L
+ D1+
+ consistency of relevant exemplification
+ completeness of relevant positivity information
------------------------------------------------
REF+ : +G(x), +Z(x) => +P(Z)
```

This factorization is a central input to Gate 4.

---

## 8. Revised Gate-4 experiment

The original 16-case table over

```text
A1+ / A1- / R+ / R-
```

is retired.

It mixed:

- two non-independent biconditional A1 schemas;
- a reflexively trivial negative rigidity clause.

Gate 4 instead begins from the informative dimensions:

```text
A1-L
A1-R
R+
```

and adds explicit structural variables only where the proof spine requires them, especially:

```text
positivity completeness
God-like exemplification consistency
```

The outputs are:

```text
MC+ : +χ => +□χ
MC- : -χ => +□¬χ
```

The first task is not to enumerate every Boolean combination blindly, but to derive the **minimal assumption lattice** around the reflection and rigidity bridges and then produce proofs or smallest countermodels for each non-implication.

---

## 9. Research questions after Gate 3

1. Which of `A1-L` and `A1-R` are needed for the positive collapse channel?
2. Does strong A1 necessarily couple corrected `MC+` and `MC-`, as it already couples positive and negative positivity rigidity?
3. Can `REF+` be recovered under weaker conditions than full positivity completeness plus exemplification consistency?
4. Do glut and gap failures remain distinct after A2, A3, and the final D1 are introduced?
5. Which assumptions are genuinely Gödelian and which are merely classical-background assumptions exposed by four-valued semantics?

---

## 10. Modal-frame control

Gate 4 keeps the Scott S5 relational control semantics fixed. Only after the positivity/collapse dependency lattice is understood will the experiment be repeated over weaker relational frames and non-principal paired-neighborhood models.

This prevents frame effects from being confused with four-valued positivity effects.

---

## 11. Sources and provenance

Primary Scott baseline:

- Christoph Benzmüller & Dana Scott, **"Notes on Gödel's and Scott's variants of the ontological argument"**, *Monatshefte für Mathematik* 208 (2025), 569–611. DOI: `10.1007/s00605-025-02078-x`

Machine-checked proof-spine guide:

- Archive of Formal Proofs, **Notes_On_Goedels_Ontological_Argument**, `ScottVariantHOMLposs`, lemma `MC`.

Current rigidity context:

- Christoph Benzmüller, **"A Comment on Modal Collapse and Ultrafilters in Gödel's Ontological Argument"** (2026), arXiv:`2608.07578`.

### Caution

The classical proof spine is used as a structural dependency guide. The local signed counterassignments are not yet full higher-order Gödel–Scott models. Before publication, all promoted dependency claims must be independently mechanized and the final actualist higher-order theory must be checked inside `goedel-4pel`.
