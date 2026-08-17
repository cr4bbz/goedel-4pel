# Gate 8 — Godlikeness variants

## Status

**Gate:** 8 — Comparative variants  
**Version:** `variants-v0.1`  
**First comparison:** `G-sup-v0.1` versus project-internal `G-exact+`  
**Verification:** Lean 4.30.0 + executable finite regressions

Gate 8 changes one semantic design dimension at a time while retaining the Gate-7 S5 control infrastructure.

The first comparison deliberately uses a project-internal exactness candidate. It is **not** identified with Anderson's or Fitting's published variants. Literature correspondence is a separate Gate-8 task.

---

## 1. Support-based positive Godlikeness

The Gate-5 control definition is:

```text
G-sup+(x): for every property phi,
           +P(phi) => +phi(x)
```

Equivalently, the positively supported positive properties form a subset of the positive property extension of a positive God-like entity.

This one-way definition permits additional positively exemplified properties that are not positively supported as positive. That freedom is exactly what the Gate-6 T2 countermodels exploit.

---

## 2. Project-internal exact positive Godlikeness

Define:

```text
G-exact+(x): for every property phi,
             +phi(x) iff +P(phi)
```

or formally:

\[
G^+_{\mathrm{exact}}(x,w)
\quad\text{iff}\quad
\forall\varphi\,
\bigl(
w\models^+\varphi(x)
\leftrightarrow
w\models^+P(\varphi)
\bigr).
\]

The distinguished property `G` realizes this variant when:

\[
w\models^+G(x)
\leftrightarrow
G^+_{\mathrm{exact}}(x,w).
\]

This comparison initially concerns the positive channel only. A final bilateral negative clause is deliberately not frozen yet.

---

## 3. Exactness strictly contains the support condition

Immediately:

\[
G^+_{\mathrm{exact}}(x,w)
\Rightarrow
G^+_{\mathrm{sup}}(x,w).
\]

The converse is false in general.

The Gate-6 glut and gap T2 countermodels are both positive support-Godlike at the critical world but fail positive exact Godlikeness:

```text
glut obstruction:
  +Z(x)
  but not +P(Z)

gap obstruction:
  +Z(x)
  but P(Z)=N
```

Thus both failures use precisely the freedom allowed by the one-way support definition.

---

## 4. Exactness internalizes positive reflection

Under exact positive Godlikeness:

\[
G^+_{\mathrm{exact}}(x,w)
\land
w\models^+\psi(x)
\Rightarrow
w\models^+P(\psi).
\]

No A1 direction, positivity completeness assumption, or exemplification consistency assumption is required for this positive reflection step. It follows directly from the reverse direction of exactness.

This is the principal structural difference from `G-sup-v0.1`.

---

## 5. Gate-8 T2 theorem

Define the exact positive T2 target:

\[
T2^+_{\mathrm{exact}}:
\quad
G^+_{\mathrm{exact}}(x,w)
\Rightarrow
w\models^+\bigl(G\operatorname{Ess}x\bigr).
\]

Assume:

1. the distinguished property `G` realizes exact positive Godlikeness at every world;
2. positive rigidity:

\[
+P(\psi)@w
\Rightarrow
+P(\psi)@v
\quad\text{whenever }wRv.
\]

Then:

\[
\boxed{
G\text{-exact}^+ + R^+
\models
T2^+_{\mathrm{exact}}.
}
\]

### Proof spine

Suppose `x` is exact positive-Godlike at `w` and positively exemplifies an arbitrary `psi`.

By exactness:

\[
+\psi(x)@w
\Rightarrow
+P(\psi)@w.
\]

By `R+`, every accessible world positively supports `P(psi)`.

At any accessible world, every actual entity positively exemplifying the distinguished Godlikeness property is exact positive-Godlike. Hence it positively exemplifies `psi`.

Therefore:

\[
\operatorname{NEnt}^+_E(G,\psi,w),
\]

so `G` is a positive essence of `x`.

This theorem is machine-checked in `formal/lean/Goedel4PEL/GoedelScott/GodlikeVariants.lean`.

---

## 6. Comparison with the support route

The two T2 routes are now:

### Support theory

```text
NegExemplification
+ G-sup
+ A1-L
+ R+
+ COMP_P^G
+ CONS_G^G
-----------------
T2+
```

### Exact-positive theory

```text
G-exact+
+ R+
--------
T2-exact+
```

The difference is explanatory rather than merely economical.

`G-sup` leaves the converse reflection step open and therefore exposes classical consistency/completeness resources as separate assumptions.

`G-exact+` builds the converse reflection step into Godlikeness itself. The later regularity assumptions disappear because their positive inferential work has been moved upstream into the definition.

---

## 7. Exactness does not restore bivalence

A finite one-world regression model satisfies:

- FDE complement exemplification;
- strong A1;
- positive rigidity;
- realization of exact positive Godlikeness;
- a genuine glut

```text
Z(a)=B
P(Z)=B.
```

Thus `G-exact+` is compatible with inconsistent positive information. It equates positive support extensions; it does not require formulas or positivity statements to be truth-only.

This blocks a misleading interpretation of the T2 theorem as a disguised return to classical bivalence.

---

## 8. Current interpretation

Gate 6 located the T2 obstruction in glut/gap failures of the reflection move under support-based Godlikeness.

Gate 8 now shows that the obstruction is **definition-sensitive**:

```text
G-sup   leaves positive reflection to be derived later;
G-exact embeds positive reflection in Godlikeness itself.
```

Therefore the T2 bottleneck should not be described as an unavoidable consequence of four-valued essence semantics. It is a consequence of the interaction between essence and the chosen informational strength of Godlikeness.

This is a comparative theorem, not an argument that `G-exact+` is philosophically preferable.

---

## 9. Next Gate-8 questions

1. Can a principled bilateral negative clause for exact Godlikeness be frozen without trivializing gluts/gaps?
2. How does this project-internal exactness candidate relate, if at all, to Anderson- and Fitting-style revisions in the literature?
3. Which parts of T1/T3/collapse change under exact positive Godlikeness?
4. Does the comparison persist on K, KB, and S4 frames?
5. Which results survive in the paired-neighborhood generalization?

The next step is literature-grounded comparison. Until that is complete, the name `G-exact+` remains purely internal to this repository.
