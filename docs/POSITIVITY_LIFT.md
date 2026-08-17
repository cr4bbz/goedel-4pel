# Bilateral Positivity Lift

## Status

**Gate:** 3 — Positivity decomposition  
**Version:** `positivity-v0.1`  
**Control semantics:** `kernel-v0.1` + `R-MODAL-v0.1` on the Scott S5 frame class  
**Role:** isolate the four-valued content of Scott's A1 and A4 before lifting the rest of the Gödel–Scott theory

This gate keeps the modal semantics fixed and varies only the treatment of positivity. That separation is essential: a failure or survival result should be attributable to the bilateral positivity structure rather than to a simultaneous weakening of the modal frame.

No object-language four-valued conditional is introduced here.

---

## 1. Four-valued positivity statements

For an intensional property `φ` at a world `w`, the statement

\[
P(\varphi)
\]

is itself four-valued. Write

\[
w\models^+ P(\varphi)
\]

for positive support that `φ` is positive and

\[
w\models^- P(\varphi)
\]

for negative support that `φ` is positive.

Equivalently:

\[
v_w(P(\varphi))\in\{T,F,B,N\}.
\]

The four values retain their ordinary informational reading:

| Value | Reading for `P(φ)` |
|---|---|
| `T` | supported as positive only |
| `F` | opposed as positive only |
| `B` | both supported and opposed as positive |
| `N` | neither supported nor opposed as positive |

A glut and a gap in positivity are therefore distinct states, not two versions of `not positive`.

---

# Part I — Scott A1

## 2. Classical A1

Scott's classical axiom is

\[
\mathrm{A1}:\qquad
\neg P(\varphi)\leftrightarrow P(\neg\varphi).
\]

A first temptation is to introduce two biconditional channel clauses such as

\[
+P(\neg\varphi)\Leftrightarrow-P(\varphi)
\]

and

\[
-P(\neg\varphi)\Leftrightarrow+P(\varphi).
\]

These are **not independent switches** when A1 is a schema over all properties and property negation is involutive. Substituting `¬φ` for `φ` in either biconditional yields the other.

Therefore Gate 3 decomposes A1 by **direction**, not by two biconditionals.

---

## 3. Independent directional components of A1

### A1-L — non-positivity support produces positivity of the complement

\[
\boxed{
A1_L:\qquad
-P(\varphi)\Rightarrow +P(\neg\varphi)
}
\]

Because the schema ranges over every property, substitution `φ := ¬φ` also gives

\[
-P(\neg\varphi)\Rightarrow +P(\varphi).
\]

### A1-R — positivity of the complement produces non-positivity support

\[
\boxed{
A1_R:\qquad
+P(\neg\varphi)\Rightarrow -P(\varphi)
}
\]

By the same substitution principle:

\[
+P(\varphi)\Rightarrow -P(\neg\varphi).
\]

### Strong bilateral A1

Define

\[
A1_{\leftrightarrow}:=A1_L+A1_R.
\]

Then

\[
+P(\neg\varphi)\Leftrightarrow-P(\varphi),
\]

and, by substitution,

\[
-P(\neg\varphi)\Leftrightarrow+P(\varphi).
\]

Equivalently,

\[
\boxed{
v(P(\neg\varphi))=\operatorname{swap}(v(P(\varphi)))
}
\]

where

\[
\operatorname{swap}(t,f)=(f,t).
\]

Hence strong A1 induces

\[
T\leftrightarrow F,
\qquad
B\leftrightarrow B,
\qquad
N\leftrightarrow N.
\]

This is already structurally important: strong A1 exchanges truth-only and falsity-only positivity information but preserves both gluts and gaps under property negation.

---

## 4. Independence of the two A1 directions

The directional clauses are genuinely independent.

### A1-L without A1-R

Take a property pair with

\[
v(P(\varphi))=T,
\qquad
v(P(\neg\varphi))=N.
\]

`A1_L` is satisfied vacuously for both members of the pair because neither positivity statement has negative support. But `A1_R` fails after substituting `¬φ` for `φ`:

\[
+P(\varphi)
\]

holds while

\[
-P(\neg\varphi)
\]

does not.

### A1-R without A1-L

Take

\[
v(P(\varphi))=F,
\qquad
v(P(\neg\varphi))=N.
\]

`A1_R` is vacuously satisfied for both members of the pair, while `A1_L` fails because

\[
-P(\varphi)
\]

holds but

\[
+P(\neg\varphi)
\]

does not.

Therefore neither direction entails the other at the four-valued level.

---

# Part II — Scott A4 and the correct rigidity channels

## 5. Classical A4

Scott's rigidity axiom is

\[
\mathrm{A4}:\qquad
P(\varphi)\rightarrow\Box P(\varphi).
\]

The direct positive-support lifting is

\[
\boxed{
R^+:\qquad
+P(\varphi)\Rightarrow+\Box P(\varphi)
}
\]

and is adopted as the Gate-3 candidate corresponding directly to the truth-preserving content of A4.

---

## 6. Why the old negative rigidity candidate is retired

Earlier project notes used

\[
-P(\varphi)\Rightarrow-\Box P(\varphi)
\]

as a possible `R-`.

Under `R-MODAL-v0.1`,

\[
w\models^-\Box\psi
\iff
\exists v\,(wRv\land v\models^-\psi).
\]

On every reflexive frame, and therefore on the fixed S5 control frames,

\[
-\psi@w\Rightarrow-\Box\psi@w
\]

holds automatically because `wRw` and `w` itself witnesses the negative support.

Thus

\[
-P(\varphi)\Rightarrow-\Box P(\varphi)
\]

is **not an informative negative rigidity principle in S5**. It is a reflexivity consequence.

It is retired as an experimental switch.

---

## 7. Informative negative persistence of positivity

The genuine negative-information analogue of modal persistence is:

\[
\boxed{
R^-_{\mathrm{nec}}:\qquad
-P(\varphi)\Rightarrow+\Box\neg P(\varphi)
}
\]

Using the Gate-2 modal duality and FDE negation, this is equivalent to

\[
\boxed{
-P(\varphi)\Rightarrow-\Diamond P(\varphi).
}
\]

Semantically it says:

> if positivity of `φ` has negative support here, then every accessible world also negatively supports positivity of `φ`.

This is universal negative persistence, not the weak existential failure encoded by `-□P(φ)`.

---

## 8. Channel-coupling theorem for positivity rigidity

### Proposition — strong A1 plus positive rigidity yields negative rigidity

Assume globally:

\[
A1_L,
\qquad
A1_R,
\qquad
R^+.
\]

Then

\[
R^-_{\mathrm{nec}}
\]

follows.

### Semantic derivation

Assume at `w`:

\[
-P(\varphi).
\]

By `A1_L`:

\[
+P(\neg\varphi).
\]

By `R+`, applied to the property `¬φ`:

\[
+\Box P(\neg\varphi).
\]

Hence every accessible `v` satisfies

\[
+P(\neg\varphi).
\]

By global `A1_R`, every such `v` satisfies

\[
-P(\varphi).
\]

Therefore every accessible world negatively supports `P(φ)`, so

\[
+\Box\neg P(\varphi).
\]

Thus:

\[
\boxed{
A1_L+A1_R+R^+\models R^-_{\mathrm{nec}}.
}
\]

This result makes A1 a **channel coupler**. Under strong A1, negative positivity rigidity is not an independent switch once positive rigidity is assumed.

---

# Part III — Correcting bilateral modal collapse

## 9. The weak negative collapse clause is also trivial on S5

Earlier project notes used

\[
MC^-_{\mathrm{weak}}:\qquad
-\chi\Rightarrow-\Box\chi.
\]

Exactly the same reflexivity argument shows that this holds for every formula on every reflexive frame, independently of Gödel–Scott.

Therefore it cannot diagnose a non-classical analogue of modal collapse.

---

## 10. Informative bilateral modal-collapse pair

The project henceforth uses:

\[
\boxed{
MC^+:\qquad
+\chi\Rightarrow+\Box\chi
}
\]

and

\[
\boxed{
MC^-:\qquad
-\chi\Rightarrow+\Box\neg\chi.
}
\]

By modal duality:

\[
MC^-\quad\text{is equivalent to}\quad
-\chi\Rightarrow-\Diamond\chi.
\]

This pair has the correct classical interpretation:

- positive truth persists to all accessible worlds;
- negative truth, i.e. falsity on the classical fragment, also persists to all accessible worlds.

Classically, applying ordinary modal collapse to `¬χ` gives precisely this negative persistence.

The old weak clause is retained only as a warning example and must not be used in the Gate-4 collapse matrix.

---

# Part IV — The classical `G + Z -> P(Z)` bridge under FDE

## 11. Minimal support interface for Godlikeness

The final four-valued D1 is intentionally deferred. For the local classical proof spine, only the following support interface is required:

\[
\boxed{
D1^+:\qquad
+G(x)\land+P(\varphi)\Rightarrow+\varphi(x).
}
\]

This says only that a positively supported God-like entity positively exemplifies positively supported positive properties.

It is **not** adopted as the final definition of Godlikeness.

---

## 12. Positive-property reflection does not follow in the minimal four-valued setting

The classical proof spine uses the local step

\[
G(x),Z(x)\Rightarrow P(Z).
\]

The natural signed target is

\[
\boxed{
REF^+:\qquad
+G(x)\land+Z(x)\Rightarrow+P(Z).
}
\]

Even strong A1 together with `D1+` does **not** force `REF+` in the FDE setting.

### Glut counterassignment

Take locally:

\[
v(Z(x))=B,
\]

\[
v(P(Z))=F,
\qquad
v(P(\neg Z))=T,
\]

and assume

\[
+G(x).
\]

Strong A1 is respected because `T` and `F` are swapped across property negation. `D1+` is also respected: since `+P(¬Z)`, Godlikeness requires `+¬Z(x)`, equivalently `-Z(x)`, and this is already present because `Z(x)=B`.

But

\[
+P(Z)
\]

fails.

Thus the classical reductio no longer forces positivity: `Z(x)` and `¬Z(x)` may coexist without explosion.

### Gap counterassignment

Take instead:

\[
v(Z(x))=T,
\]

\[
v(P(Z))=N,
\qquad
v(P(\neg Z))=N,
\]

with

\[
+G(x).
\]

Strong A1 preserves the gap, and `D1+` imposes no condition because neither positivity statement has positive support. Again

\[
+P(Z)
\]

fails.

The two failures are structurally different:

- the glut case blocks the classical contradiction-elimination step;
- the gap case blocks the positivity dichotomy itself.

These are local signed counterassignments to the proof interface, not yet full higher-order countermodels of the complete Gödel–Scott theory.

---

## 13. What the classical reflection step secretly uses

The classical derivation of

\[
G(x),Z(x)\Rightarrow P(Z)
\]

compresses more structure than A1 and D1 alone.

At the bilateral metalanguage level, `REF+` is recovered if the following are available:

### God-like exemplification consistency

For the relevant property `Z`:

\[
+G(x)\land+Z(x)\Rightarrow\neg(-Z(x)),
\]

where the outer `¬` is metalanguage denial of negative satisfaction.

### Positivity completeness

For the relevant property:

\[
+P(Z)\ \text{or}\ -P(Z).
\]

Then, assuming `-P(Z)`, `A1_L` yields `+P(¬Z)` and `D1+` yields `-Z(x)`, contradicting exemplification consistency. Hence `-P(Z)` is excluded; positivity completeness then leaves `+P(Z)`.

So the classical local bridge factors schematically as

```text
A1-L
+ D1+
+ consistency of exemplification
+ completeness of positivity information
----------------------------------------
REF+ : +G(x), +Z(x) => +P(Z)
```

This decomposition will be a central control point in Gate 4.

---

## 14. Gate-3 consequences for the experiment design

The earlier four-switch plan

```text
A1+ / A1- / R+ / R-
```

must be retired in that form.

Two reasons:

1. the two biconditional `A1+` / `A1-` formulations are not independent schemas under involutive property negation;
2. `-P -> -□P` is trivial on the fixed reflexive S5 frames.

The meaningful independent A1 switches are now:

```text
A1-L : -P(φ)  => +P(¬φ)
A1-R : +P(¬φ) => -P(φ)
```

while the direct A4 switch is:

```text
R+ : +P(φ) => +□P(φ)
```

and informative negative rigidity is a derived target:

```text
R-nec- : -P(φ) => +□¬P(φ)
```

The next collapse experiment must also use the corrected pair:

```text
MC+ : +χ => +□χ
MC- : -χ => +□¬χ
```

The local `REF+` obstruction indicates that Gate 4 will need to track at least one additional structural dimension concerning consistency/completeness, rather than pretending that A1/A4 alone reproduce the classical proof spine.

---

## 15. Gate 3 exit criteria

- [x] treat `P(φ)` as four-valued;
- [x] identify independent directional liftings of A1;
- [x] prove independence of `A1-L` and `A1-R` by finite assignments;
- [x] characterize strong A1 as value swapping under property negation;
- [x] isolate `R+` as the direct A4 lifting;
- [x] retire the reflexively trivial old `R-` clause;
- [x] define informative negative rigidity `R-nec-`;
- [x] derive `R-nec-` from strong A1 plus `R+`;
- [x] correct the negative modal-collapse target;
- [x] show that minimal strong A1 + `D1+` does not recover the classical `G + Z -> P(Z)` bridge;
- [x] distinguish glut and gap failure modes for that bridge;
- [x] identify consistency/completeness assumptions sufficient to recover the local reflection step;
- [ ] mechanize the finite assignments and the channel-coupling theorem;
- [ ] lift the final D1 object-language definition after a conditional policy is chosen.

The final two items belong to later mechanization and Gödel-reconstruction gates and do not block Gate 4.
