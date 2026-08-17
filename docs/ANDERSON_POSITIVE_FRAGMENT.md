# Gate 8 — Anderson positive fragment

## Status

**Gate:** 8 — Comparative variants  
**Version:** `anderson-positive-v0.1`  
**Scope:** positive-channel four-valued reconstruction of Anderson Godlikeness, essence, and necessary existence  
**Verification:** Lean 4.30.0 + executable two-world finite fixture

This document records a deliberately restricted Anderson comparison. It is not yet a complete bilateral four-valued reconstruction of Anderson's theory.

The classical source control is the Anderson variant analyzed by Christoph Benzmüller and David Fuenmayor in *Computer-supported Analysis of Positive Properties, Ultrafilters and Modal Collapse in Variants of Gödel's Ontological Argument* and the corresponding AFP development *Types, Tableaus and Gödel's God in Isabelle/HOL*.

---

## 1. Classical source boundary

The literature-grounded Anderson definitions are:

\[
G_Ax\equiv\forall Y\,\bigl(P(Y)\leftrightarrow\Box Y(x)\bigr),
\]

\[
E_A(Y,x)\equiv\forall Z\,\bigl(
\Box Z(x)\leftrightarrow
\Box\forall^E z\,(Y(z)\to Z(z))
\bigr),
\]

and

\[
NE_A(x)\equiv\forall Y\,\bigl(E_A(Y,x)\to\Box\exists^E Y\bigr).
\]

Anderson drops Scott's A1b while retaining the direction that excludes positivity of a property when its complement is positive. The presentation also retains A2 and positive rigidity, directly assumes positivity of `G_A` under the label `T2`, and assumes positivity of `NE_A`.

The label `T2` is therefore source-specific: in this Anderson presentation it denotes positivity of `G_A`, not Scott's theorem that Godlikeness is an essence.

The classical mechanized analysis reports necessary existence of an Anderson-Godlike being while modal collapse remains countersatisfiable in a two-world / one-entity model.

---

## 2. Positive four-valued Godlikeness

No four-valued object-language biconditional is fixed. The classical equivalence is split into two meta-level information flows:

```text
GA-forward:
  +P(phi) => AndersonNecEx+(phi,x)

GA-backward:
  AndersonNecEx+(phi,x) => +P(phi)
```

where

```text
AndersonNecEx+(phi,x,w):
  every world accessible from w positively exemplifies phi at the same x.
```

The fixed individual is not guarded by actual existence in this modal clause. This mirrors the source-level distinction between `Box (Y x)` and the actualist individual quantifier inside Anderson essence.

Define:

```text
AndersonGod+(x) := GA-forward(x) + GA-backward(x).
```

On reflexive frames Lean proves:

\[
\boxed{
AndersonGod^+(x)\Rightarrow God^+_{sup}(x)
}
\]

because necessary positive exemplification entails current positive exemplification.

---

## 3. Positive four-valued essence

The Anderson essence biconditional is likewise split:

```text
EA-forward:
  AndersonNecEx+(psi,x) => NEnt+_E(phi,psi)

EA-backward:
  NEnt+_E(phi,psi) => AndersonNecEx+(psi,x)
```

with

```text
AndersonEss+(phi,x) := EA-forward(phi,x) + EA-backward(phi,x).
```

This differs substantially from `Ess-sup-v0.1`. Scott essence begins with current exemplification of the essence property and quantifies only over currently positively exemplified properties. Anderson essence instead characterizes the complete match between necessary possession and necessary entailment.

---

## 4. Machine-checked Anderson essence bridge

Lean proves:

```text
AndersonGRealization
+ AndersonGPositive
+ A2+
+ R+
+ Reflexivity
-----------------------
AndersonGod+(x) => AndersonEss+(G,x)
```

The proof separates the two Anderson essence directions.

### Necessary possession to entailment

If `x` necessarily positively possesses `psi`, the backward Anderson Godlikeness direction yields `+P(psi)` at the current world. `R+` transports this positivity to accessible worlds. Any accessible positive `G` witness is Anderson-Godlike by realization, and its forward direction supplies `psi`.

### Entailment to necessary possession

If `G` necessarily positively entails `psi`, `A2+` combines that entailment with positive support for `G` to derive `+P(psi)`. The forward Anderson Godlikeness direction then yields necessary positive possession by `x`.

No `A1-L`, `COMP_P^G`, or `CONS_G^G` premise from the Scott-support T2 recovery route is used.

---

## 5. Positive Anderson necessary existence

Define:

```text
AndersonBoxExists+(phi,w):
  every accessible world contains an actual +phi witness
```

and

```text
AndersonNE+(x,w):
  every positive Anderson essence of x is AndersonBoxExists+
```

A distinguished property `NEA` realizes this interface when:

```text
+NEA(x) iff AndersonNE+(x).
```

Lean proves the local core:

```text
AndersonGod+(x)
+ AndersonEss+(G,x)
+ +P(NEA)
+ AndersonNERealization
--------------------------------
AndersonBoxExists+(G)
```

Only positive support for `NEA` is used in this positive branch.

---

## 6. Positive necessary Godlike existence

Keeping possible actual Godlikeness explicit, Lean proves on the fixed S5 control frames:

```text
Possible +G
+ AndersonGRealization
+ AndersonGPositive
+ A2+
+ R+
+ AndersonNERealization
+ AndersonNEPositive
+ S5
---------------------------
AndersonT3+
```

where

\[
AndersonT3^+:
\quad
\forall w\,\Box^+\exists^E x\,G(x).
\]

Possible Godlikeness is not silently derived from mere `+P(G)`: Gate 5 already established that four-valued T1 requires truth-only positivity rather than arbitrary positive support.

The theorem is machine-checked in:

```text
formal/lean/Goedel4PEL/GoedelScott/AndersonInterfaces.lean
```

---

## 7. Two-world positive-fragment no-collapse fixture

The executable finite oracle contains a complete two-world S5 model with one actual entity `a` and properties

```text
G, notG, NEA, notNEA, Q, notQ.
```

At both worlds:

```text
G(a)   = T
NEA(a) = T
P(G)   = T
P(NEA) = T
```

while `Q` is contingent:

```text
Q(a) @ w0 = T
Q(a) @ w1 = F.
```

Both `Q` and `notQ` are positivity gaps:

```text
P(Q)    = N
P(notQ) = N.
```

This implements Anderson's intended room for indifferent properties after Scott's second A1 direction is dropped.

The model validates the currently encoded positive Anderson fragment:

- FDE complement exemplification;
- retained Anderson-style A1 direction `+P(not phi) => -P(phi)`;
- `A2+`;
- `R+`;
- Anderson positive Godlikeness realization;
- positive support for `G`;
- Anderson necessary-existence realization;
- positive support for `NEA`;
- possible Godlike existence at every world;
- positive necessary Godlike existence;
- positive Anderson essence of `G` at both worlds.

Nevertheless:

\[
+Q(a)@w_0
\quad\text{but}\quad
\neg\bigl(+\Box Q(a)@w_0\bigr).
\]

Hence positive modal collapse fails for the concrete formula application `Q(a)`.

The fixture is executable in:

```text
formal/finite/gate8_anderson.py
```

and is part of the CI regression suite.

---

## 8. Exact epistemic status

The finite fixture establishes:

> the currently encoded **positive four-valued Anderson fragment** is jointly satisfiable with positive necessary Godlike existence and failure of positive modal persistence for a concrete formula.

It does **not** yet establish a countermodel to a complete bilateral Anderson theory.

Still missing before that stronger claim:

1. a principled negative-channel lift of Anderson Godlikeness;
2. a principled negative-channel lift of Anderson essence;
3. a bilateral `NE_A` definition;
4. a check that the resulting negative clauses preserve the finite model or admit another no-collapse model;
5. a source-level audit of any further premises required by the full Anderson development.

This distinction is mandatory: the present result is stronger than a paper sketch but weaker than a complete four-valued reconstruction of Anderson's classical theory.

---

## 9. Structural comparison so far

```text
G-sup+:
  +P(phi) -> current +phi(x)

G-exact+:
  +P(phi) <-> current +phi(x)

Anderson G_A+:
  +P(phi) <-> necessary +phi(x) for the same x
```

The three definitions move information in different places:

- `G-sup+` leaves both local reflection and persistence open;
- `G-exact+` internalizes local reflection;
- Anderson internalizes modal persistence and classifies only necessary properties.

This is why `G-exact+` and Anderson are not interchangeable names for one strengthening.

---

## 10. Next target

The next Anderson step is bilateral rather than another positive theorem:

1. generate candidate negative clauses for `G_A`, `E_A`, and `NE_A` from the FDE reading of the classical biconditionals;
2. test whether they preserve gluts, gaps, and Anderson-indifferent properties;
3. run the two-world no-collapse fixture against each candidate;
4. freeze only a negative interface that survives those tests.

Only after that should the project claim a genuinely bilateral four-valued Anderson variant.
