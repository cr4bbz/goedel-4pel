# Gate 8 — Bilateral Anderson candidate

## Status

**Gate:** 8 — Comparative variants  
**Version:** `anderson-bilateral-v0.1`  
**Scope:** bilateral four-valued candidate reconstruction of the Anderson variant  
**Verification:** Lean 4.30.0 + executable two-world finite regression

This file freezes the first bilateral Anderson candidate used by `goedel-4pel`.

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

The positive branch is recorded in `docs/ANDERSON_POSITIVE_FRAGMENT.md` and machine-checked in `AndersonInterfaces.lean`.

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

This is the bilateral dual of universal positive necessary exemplification.

### Negative Anderson Godlikeness

A failure witness may attack either direction of the positive equivalence:

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

This admits all four informational states. In particular, positive and negative Anderson Godlikeness may coexist when an equivalence direction has both positive support and explicit counter-support.

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

Again, negative support witnesses a mismatch in one of the two Anderson essence directions.

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

The definitions live in:

```text
formal/lean/Goedel4PEL/GoedelScott/AndersonBilateral.lean
```

---

## 3. Classical recovery

Assume classical coherence of exemplification:

```text
-phi(x) iff not +phi(x)
```

and, for Godlikeness, classical coherence of positivity:

```text
-P(phi) iff not +P(phi).
```

Lean proves generally:

```text
AndersonNecExMinus(phi,x) iff not AndersonNecExPlus(phi,x)
AndersonGodMinus(x)        iff not AndersonGodPlus(x)
AndersonEssMinus(phi,x)    iff not AndersonEssPlus(phi,x)
AndersonBoxExistsMinus(phi) iff not AndersonBoxExistsPlus(phi)
AndersonNEMinus(x)         iff not AndersonNEPlus(x)
```

Thus the project-specific bilateral evidence semantics collapses to the intended Boolean equivalence behavior when both information channels are classically coherent.

These are general proof-assistant theorems, not finite-model observations.

---

## 4. Positive theorem chain retained

The already machine-checked positive Anderson chain remains valid inside the bilateral candidate.

On the current control assumptions:

```text
AndersonGRealization
+ AndersonGPositive
+ A2+
+ R+
+ Reflexivity
---------------------
AndersonGod+(x) => AndersonEss+(G,x)
```

With a realized and positively supported `NEA`:

```text
AndersonGod+(x)
=> AndersonBoxExists+(G)
```

and, with possible actual Godlikeness plus the S5 control frame:

```text
Possible +G
+ Anderson positive stack
+ S5
-------------------------
AndersonT3+
```

The theorem does not use the newly introduced negative clauses. Their role is to give the variant a bilateral informational interpretation and to permit later glut/gap analysis.

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

The executable regression verifies:

- FDE complement exemplification;
- Anderson-retained A1 direction;
- `A2+`;
- `R+`;
- bilateral realization of `G_A`;
- positive support for `G_A`;
- bilateral realization of `NE_A`;
- positive support for `NE_A`;
- positive Anderson essence of `G`;
- no negative Anderson essence support for `G` in the fixture;
- possible actual Godlike existence;
- positive necessary actual Godlike existence;
- no negative support for `G_A` or `NE_A` in the fixture;
- positivity gaps for `Q` and `notQ`;
- failure of positive modal collapse at `Q(a)`.

Concretely:

\[
+Q(a)@w_0
\]

but

\[
\neg(+\Box Q(a)@w_0).
\]

The regression is implemented in:

```text
formal/finite/gate8_anderson.py
```

and runs in CI.

---

## 6. Result and limitation

The current result can now be stated more strongly than the earlier positive-fragment result:

> The frozen bilateral Anderson candidate admits a concrete two-world S5 model satisfying its currently encoded Anderson Godlikeness and necessary-existence interfaces, including their negative-support realizations, while positive necessary Godlike existence holds and positive modal collapse fails for a concrete formula application.

However, two qualifications remain mandatory.

First, the negative clauses are a principled FDE reconstruction, not a historically fixed Anderson semantics. Other bilateral lifts may be possible.

Second, the project still represents the Anderson axioms through signed semantic interfaces rather than a complete object-language axiom system with a fixed four-valued implication/biconditional. The result is therefore a semantic variant theorem, not yet a line-for-line non-classical translation of the full Isabelle/HOL theory.

---

## 7. Comparison with the other Godlikeness variants

The three positive notions now differ along two independent axes:

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

---

## 8. Next research frontier

The next Gate-8 question should vary the modal frame rather than strengthen Anderson further.

Current proof dependencies suggest separate tests for:

1. **Reflexivity**, used to recover current possession from Anderson necessary possession and in the local NE branch;
2. **Symmetry + transitivity**, used to transport a possible-world necessary-existence result back to the original world's accessible cluster;
3. the full S5 package versus K, KB, and S4;
4. comparison with the classical Anderson result, which is known to require less than an arbitrary S5 presentation in parts of the literature.

This frame analysis can distinguish which modal assumptions belong to Anderson's definitions themselves and which are artifacts of the current S5 control route.
