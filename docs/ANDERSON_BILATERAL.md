# Gate 8 — Bilateral Anderson candidate

## Status

**Gate:** 8 — Comparative variants  
**Version:** `anderson-bilateral-v0.2`  
**Scope:** bilateral four-valued candidate reconstruction of the Anderson variant  
**Verification:** Lean 4.30.0 + executable finite regressions

This file freezes the current bilateral Anderson candidate used by `goedel-4pel`.

It is literature-grounded on the positive/classical side, but the negative-support clauses are a project reconstruction. Anderson's historical theory does not itself prescribe an FDE bilateral semantics. The candidate is therefore not presented as the unique four-valued Anderson logic.

---

## 1. Positive source interface

The classical Anderson control definitions are represented positively by directional meta-level interfaces rather than by introducing a four-valued object-language biconditional.

### Necessary exemplification of a fixed individual

\[
AndNecEx^+(\varphi,x,w)
\quad\text{iff}\quad
\forall v\,(wRv\Rightarrow +\varphi(x)@v).
\]

### Anderson Godlikeness

\[
GA^+_{\to}:
+P(\varphi)@w\Rightarrow AndNecEx^+(\varphi,x,w),
\]

\[
GA^+_{\leftarrow}:
AndNecEx^+(\varphi,x,w)\Rightarrow +P(\varphi)@w.
\]

Thus

\[
G_A^+(x,w)
:=GA^+_{\to}\land GA^+_{\leftarrow}.
\]

### Anderson essence

\[
EA^+_{\to}:
AndNecEx^+(\psi,x,w)\Rightarrow NEnt_E^+(\varphi,\psi,w),
\]

\[
EA^+_{\leftarrow}:
NEnt_E^+(\varphi,\psi,w)\Rightarrow AndNecEx^+(\psi,x,w).
\]

### Anderson necessary existence

\[
NE_A^+(x,w)
\quad\text{iff}\quad
\forall\varphi\,
\bigl(E_A^+(\varphi,x,w)\Rightarrow
\Box^+\exists^E y\,\varphi(y)\bigr).
\]

The positive definitions are machine-checked in `AndersonInterfaces.lean`.

---

## 2. Negative evidence design

The bilateral candidate follows the same methodological rule as Gate 6 `NEnt-_E`:

> negative support records explicit counter-information, not merely meta-level failure of the positive clause.

### Negative necessary exemplification

\[
AndNecEx^-(\varphi,x,w)
\quad\text{iff}\quad
\exists v\,(wRv\land-\varphi(x)@v).
\]

### Negative Anderson Godlikeness

\[
-G_A(x)@w
\quad\text{iff}\quad
\exists\varphi\,
\Bigl[
(+P(\varphi)@w\land AndNecEx^-(\varphi,x,w))
\lor
(AndNecEx^+(\varphi,x,w)\land-P(\varphi)@w)
\Bigr].
\]

### Negative Anderson essence

\[
-E_A(\varphi,x)@w
\quad\text{iff}\quad
\exists\psi\,
\Bigl[
(AndNecEx^+(\psi,x,w)\land NEnt_E^-(\varphi,\psi,w))
\lor
(NEnt_E^+(\varphi,\psi,w)\land AndNecEx^-(\psi,x,w))
\Bigr].
\]

### Negative necessary actual exemplification

\[
AndBoxExists^-(\varphi,w)
\quad\text{iff}\quad
\exists v\,
\bigl(wRv\land
\forall y(E(v,y)\Rightarrow-\varphi(y)@v)
\bigr).
\]

### Negative Anderson necessary existence

\[
-NE_A(x)@w
\quad\text{iff}\quad
\exists\varphi\,
\bigl(E_A^+(\varphi,x,w)\land AndBoxExists^-(\varphi,w)
\bigr).
\]

The definitions live in `formal/lean/Goedel4PEL/GoedelScott/AndersonBilateral.lean`.

---

## 3. Classical recovery

Assume classical coherence of exemplification and, where needed, positivity:

```text
-phi(x) iff not +phi(x)
-P(phi) iff not +P(phi).
```

Lean proves generally:

```text
AndersonNecExMinus(phi,x)  iff not AndersonNecExPlus(phi,x)
AndersonGodMinus(x)         iff not AndersonGodPlus(x)
AndersonEssMinus(phi,x)     iff not AndersonEssPlus(phi,x)
AndersonBoxExistsMinus(phi) iff not AndersonBoxExistsPlus(phi)
AndersonNEMinus(x)          iff not AndersonNEPlus(x)
```

Thus the project-specific bilateral evidence semantics collapses to the intended Boolean equivalence behavior when both information channels are classically coherent.

---

## 4. Positive theorem chain and frame reduction

The first Anderson mechanization used the S5 control frame, mirroring the Scott control environment. Gate 8 has now reduced that modal requirement substantially.

### Essence on symmetric frames

Lean proves:

```text
AndersonGRealization
+ AndersonGPositive
+ A2+
+ Symmetric(R)
---------------------
AndersonGod+(x) => AndersonEss+(G,x)
```

No reflexivity, transitivity, or separate `R+` premise is used.

The reason is specific to Anderson's necessary-exemplification definition. If an accessible witness `y` is Godlike at `z`, positivity of `G` makes `G(y)` necessary from `z`. Symmetry sends this Godlikeness back to `w`; realization makes `y` Godlike at `w`, from which positivity information at `w` is sent forward again to `z`.

### Necessary Godlike existence on symmetric frames

With a realized and positively supported `NEA`, and keeping possible actual Godlikeness explicit, Lean proves:

\[
\boxed{
Symmetric(R)
+ Possible\,G_A
+ AndersonGRealization
+ AndersonGPositive
+ A2^+
+ AndersonNERealization
+ AndersonNEPositive
\Rightarrow AndersonT3^+.
}
\]

No reflexivity, transitivity, or `R+` premise occurs in this theorem.

The proof uses the reverse edge from a possible Godlike world to transport both `G` and `NEA` back to the current world. There the realization clauses and symmetric essence theorem activate positive necessary existence directly.

The theorem is machine-checked in:

```text
formal/lean/Goedel4PEL/GoedelScott/AndersonFrames.lean
```

This changes the interpretation of the earlier S5 result: S5 was a convenient control envelope, not the minimal frame package for the current Anderson route.

---

## 5. Bilateral two-world no-collapse model

The finite oracle contains a two-world complete-S5 model with one actual entity `a` and properties:

```text
G, notG, NEA, notNEA, Q, notQ.
```

At both worlds:

```text
G(a)   = T
NEA(a) = T
P(G)   = T
P(NEA) = T.
```

The formula application `Q(a)` is contingent:

```text
Q(a) @ w0 = T
Q(a) @ w1 = F,
```

while Anderson-indifferent positivity is represented by gaps:

```text
P(Q)    = N
P(notQ) = N.
```

The executable regression verifies the currently encoded bilateral Anderson candidate, positive necessary actual Godlike existence, and failure of positive modal collapse:

\[
+Q(a)@w_0
\]

but

\[
\neg(+\Box Q(a)@w_0).
\]

The regression is implemented in `formal/finite/gate8_anderson.py` and runs in CI.

---

## 6. Symmetry boundary: S4 is insufficient

The finite oracle also contains a two-world frame that is:

```text
reflexive    = true
transitive   = true
symmetric    = false
```

so it is an S4-style frame but not symmetric.

The model satisfies the currently encoded bilateral Anderson stack, including:

- Anderson-retained A1 direction;
- `A2+`;
- `R+`;
- bilateral `G_A` realization;
- positive `G_A`;
- bilateral `NE_A` realization;
- positive `NE_A`;
- possible actual Godlikeness at every world.

Nevertheless:

\[
\neg AndersonT3^+.
\]

This finite result does not prove global logical necessity of symmetry, but it shows that even reflexivity plus transitivity does not replace the symmetry used by the general Lean theorem.

The attempted search for a symmetric non-reflexive countermodel instead exposed the stronger symmetry-only proof above: `A2+` and Anderson's own necessary-exemplification directions prevented the intended countermodel construction.

---

## 7. Result and limitation

The current result can be stated as follows:

> The frozen bilateral Anderson candidate admits necessary positive Godlike existence under a symmetry-only frame theorem, while also admitting a concrete two-world model in which positive necessary Godlike existence coexists with failure of positive modal collapse.

Moreover, a reflexive/transitive non-symmetric finite model shows that the S4 package alone does not force the Anderson T3 target in the current semantic stack.

Two qualifications remain mandatory.

First, the negative clauses are a principled FDE reconstruction, not a historically fixed Anderson semantics. Other bilateral lifts may be possible.

Second, the project represents the Anderson axioms through signed semantic interfaces rather than a complete object-language axiom system with a fixed four-valued implication/biconditional. The result is therefore a semantic variant theorem, not yet a line-for-line non-classical translation of the full Isabelle/HOL theory.

---

## 8. Comparison with the other Godlikeness variants

```text
G-sup+:
  +P(phi) -> current +phi(x)

G-exact+:
  +P(phi) <-> current +phi(x)

Anderson G_A+:
  +P(phi) <-> necessary +phi(x) for the same individual
```

Thus:

- `G-sup+` leaves local reflection and persistence open;
- `G-exact+` internalizes local reflection;
- Anderson internalizes necessary persistence and classifies necessary rather than merely current possession.

Finite models separate `G-exact+` and Anderson in both directions.

The frame reduction adds another distinction: Anderson's own modal persistence is strong enough to replace the generic S5 `Diamond Box -> Box` transport used by the Scott-control T3 route.

---

## 9. Next research frontier

The next frame questions are now narrower:

1. Is symmetry globally minimal for the current Anderson T3 interface, or can a weaker relational condition replace it?
2. Which exact frame condition is required by the Scott T3 route, and does it remain strictly stronger than the Anderson route?
3. Can the Anderson no-collapse fixture be reproduced directly on a merely symmetric non-S5 frame?
4. How do these results compare with K, KB, S4, and standard modal-system nomenclature once the source-level frame audit is completed?
5. Which frame-dependent results survive the later paired-neighborhood generalization?

After the frame comparison, Gate 8 should introduce the intension/extension type distinction required for a faithful Fitting reconstruction.
