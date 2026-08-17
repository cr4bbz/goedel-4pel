# Gate 8 — Godlikeness variants

## Status

**Gate:** 8 — Comparative variants  
**Version:** `variants-v0.2`  
**Comparisons:** `G-sup-v0.1`, project-internal `G-exact+`, and a literature-grounded positive Anderson interface  
**Verification:** Lean 4.30.0 + executable finite regressions

Gate 8 changes one semantic design dimension at a time while retaining the Gate-7 S5 control infrastructure.

The project-internal exactness candidate remains distinct from the literature variants. The Anderson comparison is now source-grounded in Benzmüller and Fuenmayor's computer-supported reconstruction of Anderson's emendation and the corresponding AFP development `Types_Tableaus_and_Goedels_God`.

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

## 5. Gate-8 exact-positive T2 theorem

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

## 8. Literature-grounded Anderson control

Benzmüller and Fuenmayor's reconstruction of Anderson's emendation uses the classical definitions

\[
G_Ax\equiv
\forall Y\,\bigl(P(Y)\leftrightarrow\Box Y(x)\bigr)
\]

and

\[
E_A(Y,x)\equiv
\forall Z\,\bigl(
\Box Z(x)
\leftrightarrow
\Box\forall^E z\,(Y(z)\to Z(z))
\bigr).
\]

The same presentation drops Scott's second A1 direction, retains A2 and A4, directly postulates positivity of `G_A` under the label `T2`, and adapts necessary existence accordingly. Its intended necessary-existence result survives while modal collapse is countersatisfiable in a two-world / one-entity model.

This nomenclature matters: Anderson's premise labelled `T2` is **not** Scott's theorem `G(x) -> G Ess. x`.

### Positive four-valued interface

To avoid silently choosing a four-valued object-language biconditional, the repository splits Anderson's Godlikeness into two meta-level directions:

```text
GA-forward:
  +P(phi) => +Box phi(x)

GA-backward:
  +Box phi(x) => +P(phi)
```

where `+Box phi(x)` means positive exemplification of the fixed individual `x` at every accessible world and is deliberately not guarded by actual existence.

Likewise Anderson essence is split into:

```text
EA-forward:
  +Box psi(x) => NEnt+_E(phi, psi)

EA-backward:
  NEnt+_E(phi, psi) => +Box psi(x)
```

This preserves the source-level distinction between the possibilist-looking fixed-individual modal clause `Box (Y x)` and the actualist quantifier inside the necessary entailment clause.

---

## 9. Anderson versus support Godlikeness

On reflexive frames Lean proves:

\[
\boxed{
G_A^+(x,w)
\Rightarrow
G_{\mathrm{sup}}^+(x,w).
}
\]

Reason: if positivity gives necessary positive exemplification, reflexivity gives current positive exemplification.

The converse is not built in. `G-sup` only requires current exemplification of positive properties; Anderson requires them to hold throughout the accessible worlds for the same individual.

Thus Anderson strengthens the support theory in a **modal persistence direction**.

---

## 10. Anderson versus project-internal exactness

The finite regression suite now separates the two positive interfaces in both directions.

### Anderson without local exactness

A two-world complete S5 model has an entity `a` with a contingent property `Z`:

```text
+Z(a) @ w0
not +Z(a) @ w1
```

`Z` and its complement are positively indifferent at `w0`. Anderson positive Godlikeness can therefore hold because `Z` is not a necessary property, while local exactness fails because `Z` is currently positively exemplified but not positively supported as positive.

Hence:

\[
G_A^+\not\Rightarrow G_{\mathrm{exact}}^+.
\]

### Local exactness without Anderson

Conversely, another two-world model makes current positive exemplification coincide with positivity at `w0`, but lets a positively supported property fail at `w1`. Local exactness therefore holds while Anderson's forward necessity direction fails:

\[
G_{\mathrm{exact}}^+\not\Rightarrow G_A^+.
\]

These are bounded concrete separation models, not global equivalence theorems.

The conceptual distinction is now sharp:

```text
G-sup+:
  positive -> currently exemplified

G-exact+:
  positive <-> currently exemplified

Anderson G_A+:
  positive <-> necessarily exemplified by the same individual
```

`G-exact+` strengthens the **reflection/local-classification** axis; Anderson strengthens the **modal-persistence** axis.

---

## 11. Positive Anderson essence bridge

The literature-grounded positive interfaces already support a general Lean theorem.

Assume:

```text
AndersonGRealization
AndersonGPositive
A2+
R+
Reflexivity
```

Then every positive Anderson-Godlike entity has the distinguished `G` property as a positive Anderson essence:

\[
\boxed{
G_A^+(x,w)
\Rightarrow
E_A^+(G,x,w).
}
\]

The two essence directions have different sources:

1. `+Box psi(x) -> NEnt+_E(G,psi)` uses Anderson's backward Godlikeness direction to obtain `+P(psi)`, then `R+` transports positivity to accessible worlds, where Anderson's forward direction supplies `psi` to accessible Godlike witnesses.
2. `NEnt+_E(G,psi) -> +Box psi(x)` uses `A2+` together with the directly assumed positivity of `G_A`, then Anderson's forward Godlikeness direction.

No Scott-style `A1-L`, `COMP_P^G`, or `CONS_G^G` premise occurs in this positive Anderson essence bridge.

This theorem is machine-checked in `formal/lean/Goedel4PEL/GoedelScott/AndersonInterfaces.lean`.

---

## 12. Current interpretation

Gate 6 located the T2 obstruction in glut/gap failures of the reflection move under support-based Godlikeness.

Gate 8 now shows that the obstruction is **definition-sensitive along more than one axis**:

```text
G-sup     leaves local reflection and modal persistence open;
G-exact+  builds local reflection into Godlikeness;
Anderson   builds positivity <-> necessary exemplification into Godlikeness
           and simultaneously changes essence.
```

Therefore the Scott T2 bottleneck should not be described as an unavoidable consequence of four-valued essence semantics. It is a consequence of the interaction among the chosen Godlikeness notion, its modal strength, and the essence notion paired with it.

The Anderson comparison also explains why it would be misleading to simply rename `G-exact+` as an Anderson variant.

---

## 13. Fitting boundary

The literature comparison also fixes the boundary to Fitting's revision. Fitting does not merely strengthen an implication over the same intensional properties. The positivity predicate ranges over **property extensions**, and Godlikeness and essence use rigidified applications of those extensions.

Therefore a faithful four-valued Fitting lift requires a new intensional/extension interface in the semantic structure. Reusing the current `Property` type unchanged would erase the central distinction the Fitting variant was introduced to express.

For this reason Fitting is deferred until that type-level distinction is represented explicitly.

---

## 14. Next Gate-8 questions

1. Can a principled bilateral negative clause for exact Godlikeness be frozen without trivializing gluts/gaps?
2. Which negative-channel lift of Anderson's `P(Y) <-> Box Y(x)` preserves the intended room for indifferent properties?
3. Can the positive Anderson necessary-existence chain be reconstructed without importing hidden classical biconditionals?
4. Can a finite four-valued Anderson model reproduce the literature result: necessary Godlike existence while modal collapse fails?
5. Does the `G-sup` / `G-exact+` / Anderson comparison persist on K, KB, and S4 frames?
6. What minimal extra type structure is required for a faithful Fitting extension/intension comparison?
7. Which results survive in the paired-neighborhood generalization?

The next mechanization target is the Anderson necessary-existence chain and an explicit four-valued countermodel to modal collapse. `G-exact+` remains a project-internal control definition, not a literature name.
