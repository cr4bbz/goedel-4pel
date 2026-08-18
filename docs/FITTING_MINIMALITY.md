# Gate 8 — Fitting assumption minimization

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-minimality-v0.2`  
**Scope:** theorem-level minimization and alternative recovery routes inside the admissible bilateral Fitting candidate  
**Verification:** Lean 4.30.0 + executable finite regressions

This milestone refines `fitting-bilateral-v0.2`. It does not replace that candidate and does not claim global model-theoretic minimality.

---

## 1. The original admissible recovery package

The substantive Fitting candidate used

```text
REG_G^adm := COMP_P^G(adm) + CONS_G^G(adm)
```

where `CONS_G^G(adm)` requires every admissible extension positively possessed by a positive Godlike witness to be locally non-glutty at that witness.

The extensional essence proof actually uses this consistency premise only in one branch: when `COMP_P^G(adm)` classifies the possessed extension negatively.

---

## 2. Targeted negative-classification consistency

Define

```text
NegClassConsistencyAdm:
  Adm(Y)
  + GodPlusAdm(w,x)
  + Y.pos(x)
  + pNeg(w,Y)
  -> not Y.neg(x)
```

and

```text
REG_G^neg := COMP_P^G(adm) + NegClassConsistencyAdm.
```

Lean proves

```text
ConsGGAdm -> NegClassConsistencyAdm
RegGAdm   -> RegGNegClassAdm
```

and, more importantly,

\[
\boxed{
G\text{-admissible}
+G_F\text{-realization}
+A1_{L,F}^{adm}
+REG_G^{neg}
\Longrightarrow
G_F^+(x,w)\Rightarrow Ess_F^+(ext_wG,x,w).
}
\]

The corresponding de-re necessary-existence chain is also machine-checked with `REG_G^neg` in place of the original full `REG_G^adm`.

The reason is proof-local. If completeness already returns positive support for `Y`, no consistency premise is needed. Only the negative-classification branch uses `A1-L` to make the complement positively supported and then needs enough local consistency to close that branch.

---

## 3. The weakening is A1-channel sensitive

The targeted consistency condition is genuinely weaker on the **A1-L-only** recovery route. A one-world one-entity finite fixture has one admissible self-negating `B` extension. It satisfies:

```text
A1-L
COMP_P^G(adm)
NegClassConsistencyAdm
positive Godlikeness
positive extensional essence
```

while full `CONS_G^G(adm)` fails. The model intentionally does **not** satisfy `A1-R`.

This limitation is structural rather than accidental. Lean proves:

\[
\boxed{
A1_R^{adm}
+COMP_P^G(adm)
+NegClassConsistencyAdm
\Longrightarrow
CONS_G^G(adm).
}
\]

Hence, once the right A1 information-flow channel is restored, the targeted package reconstructs the older full consistency requirement.

The result should therefore be read as an A1-sensitive dependency decomposition, not as an unconditional global weakening of the complete bilateral Fitting candidate.

---

## 4. `COMP_P^G(adm)` is exact for the classification route

Within the preceding proof architecture, `COMP_P^G(adm)` provides exactly the missing gap branch. At a positive Godlike witness that positively exemplifies an admissible `Y`, the proof needs either positive support for `Y` immediately or negative support for `Y` so that `A1-L` can activate the complement route.

A mere rewrite of completeness as

```text
not pPos(w,Y) -> pNeg(w,Y)
```

would not be a genuine weakening: at the classical meta-level this is equivalent to the disjunction used by `COMP_P^G(adm)` on the same relevant domain.

Consequently, weakening `COMP` requires a different recovery mechanism rather than a syntactic reformulation of the same branch coverage.

---

## 5. Alternative recovery by Godlike indiscernibility

Gate 8 now contains such an alternative mechanism. Define admissible-property indiscernibility among positive Fitting-Godlike individuals by

\[
Ind_G^{adm}:
\quad
Adm(Y)\land G_F^+(x,w)\land G_F^+(y,w)
\Longrightarrow
\bigl(+Y(x)\leftrightarrow +Y(y)\bigr).
\]

This condition does **not** classify `Y` as positively or negatively supported. Instead it says that the selected rigid property domain cannot distinguish two positive Godlike individuals at the same world.

Lean proves the alternative essence theorem

\[
\boxed{
G\text{-admissible}
+G_F\text{-realization}
+Ind_G^{adm}
\Longrightarrow
G_F^+(x,w)\Rightarrow Ess_F^+(ext_wG,x,w).
}
\]

No A1 direction, no `COMP_P^G(adm)`, and no exemplification-consistency premise occurs.

The proof is extensional. If an admissible extension `Y` contains the chosen Godlike individual `x`, every member `y` of the frozen current `G` extension is also Godlike at the source world by `G` realization. Indiscernibility therefore transfers positive membership in `Y` from `x` to `y`, which is exactly the rigid extensional entailment needed for Fitting essence.

The same alternative route continues through necessary existence. Lean proves frame-free de-re possibility-to-necessity from

```text
GAdmissible
+ GRealizationAdm
+ GodlikeIndiscernibilityAdm
+ NEAdmissible
+ NERealizationAdm
+ A5PlusAdm
```

with neither `COMP`, A1, nor a consistency premise. Adding positive-only `G` stability yields the corresponding positive de-dicto theorem.

This is an **alternative structural route**, not a claim that indiscernibility is globally weaker than positivity completeness. The two assumptions constrain different parts of the semantics.

---

## 6. Finite separation: Essence and NE with a genuine positivity gap

A one-world, two-entity reflexive finite fixture validates the alternative route while explicitly falsifying `COMP_P^G(adm)`.

The selected negation-closed admissible domain consists of the four classical rigid extensions

```text
EMPTY, ONLY_A, ONLY_B, ALL.
```

Positivity is chosen so that

```text
+p(ONLY_A)
-p(ONLY_B)
```

while `ALL` is a genuine positivity gap:

```text
not +P(ALL)
not -P(ALL).
```

Entity `a` is the unique positive Fitting-Godlike individual, the distinguished `G` extension is `ONLY_A`, and both A1 directions hold. Full relevant exemplification consistency also holds. Nevertheless `COMP_P^G(adm)` fails because `ALL` contains the Godlike witness while its positivity status is `N`.

The model still satisfies:

```text
GodlikeIndiscernibilityAdm
G realization
current-G extensional essence of a
NE realization
A5+
de-re possible current-G exemplification
de-re necessary current-G exemplification.
```

Therefore

\[
\boxed{
COMP_P^G(adm)
\text{ is not globally necessary for the current Fitting essence/NE conclusion.}
}
\]

What fails is only the earlier classification-based recovery route.

The regression is implemented in:

```text
formal/finite/gate8_fitting_comp.py
```

---

## 7. Bilateral `STAB_G` is stronger than the positive theorem needs

The earlier de-dicto theorem used full bilateral extension stability:

\[
STAB_G^{\pm}:
\quad
wRz\Rightarrow ext_wG\equiv ext_zG,
\]

where equivalence preserves both positive and negative membership.

The positive theorem never inspects the negative membership channel. Gate 8 therefore separates two directional positive conditions:

```text
GPosPersistsAlongRAdm:
  wRz + ext_w G .pos(x) -> ext_z G .pos(x)

GPosReflectsAlongRAdm:
  wRz + ext_z G .pos(x) -> ext_w G .pos(x)
```

and defines

```text
STAB_G^+ := persistence + reflection.
```

Lean proves

```text
STAB_G^± -> STAB_G^+
```

and separately verifies the two bridge roles:

```text
positive reflection:
  de-dicto possibility -> frozen de-re possibility

positive persistence:
  frozen de-re necessity -> de-dicto necessity
```

Thus the minimized classification-route theorem is

\[
\boxed{
\begin{aligned}
&G\text{-admissible}
+G_F\text{-realization}
+A1_{L,F}^{adm}
+REG_G^{neg}\\
&+NE_F\text{-realization}
+A5_F^+
+STAB_G^+\\
&+\Diamond^+\exists^E x\,G_F(x)
\Longrightarrow
\Box^+\exists^E x\,G_F(x).
\end{aligned}}
\]

The alternative indiscernibility route reaches the same de-dicto target with `Ind_G^{adm}` replacing the entire `A1-L + COMP + NegCons` block.

No negative-extension stability and no S4/S5 frame property occurs in either theorem.

---

## 8. Strictness of positive-only stability

A complete two-world S5 finite fixture separates the stability notions while retaining a strong control stack.

Both worlds have the same positive `G` membership set `{a}`. The negative information about a non-Godlike entity `b` changes from falsity support to a gap:

```text
w0: G(a)=T, G(b)=F
w1: G(a)=T, G(b)=N
```

Consequently:

```text
STAB_G^+     = true
STAB_G^±     = false
```

while the model also satisfies:

```text
A1-L
A1-R
COMP_P^G(adm)
CONS_G^G(adm)
NE realization
A5+
positive necessary de-dicto Godlikeness.
```

Thus positive-only stability is strictly weaker than bilateral extension stability even when the old full regularity package and both A1 directions are retained.

The regression is implemented in:

```text
formal/finite/gate8_fitting_minimality.py
```

The subsequent `fitting-rigidity-v0.1` milestone derives the positive interface from a Fitting-typed rigidity condition:

```text
G realization + RPlusAdm
-> positive G reflection

G realization + RPlusAdm + symmetry
-> positive G persistence
```

Hence `RPlusAdm + symmetry` derives all of `STAB_G+`. The direct theorem remains frame-free when `STAB_G+` is assumed primitively; symmetry re-enters only in the derived-rigidity route.

---

## 9. Current dependency picture

The admissible Fitting branch now has two machine-checked essence/NE routes:

```text
classification route:
  A1-L
  + COMP_P^G(adm)
  + consistency only if pNeg(Y)
          |
          v
  extensional G-as-essence

indiscernibility route:
  admissible-property indiscernibility of Godlike individuals
          |
          v
  extensional G-as-essence
```

Both feed the same frame-free de-re necessary-existence architecture. Positive `G` reflection/persistence then provides the current de-dicto bridge.

Restoring `A1-R` closes one saving inside the classification route by reconstructing full relevant exemplification consistency. It does not make `COMP` globally necessary, because the indiscernibility route bypasses positivity classification altogether.

---

## 10. Open questions

The next principled questions are:

1. whether `GodlikeIndiscernibilityAdm` follows from a more independently motivated property-domain principle or should remain only a control alternative;
2. whether there are weaker non-classificatory conditions between indiscernibility and the direct essence conclusion;
3. whether positive persistence has a principled derivation weaker than the verified `RPlusAdm + symmetry` bridge;
4. which closure principles on `Adm` interact with the two recovery routes;
5. whether the same route separation survives paired-neighborhood semantics;
6. whether a source-grounded Fitting reconstruction should retain both A1 directions in the four-valued candidate or treat the A1-L classification route independently.

No claim is made that either recovery route is globally weakest.
