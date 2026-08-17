# Gate 8 — Fitting assumption minimization

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-minimality-v0.1`  
**Scope:** theorem-level minimization inside the admissible bilateral Fitting candidate  
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

## 4. Bilateral `STAB_G` is stronger than the positive theorem needs

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

Thus the minimized positive theorem is

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

No negative-extension stability and no S4/S5 frame property occurs in this theorem.

---

## 5. Strictness of positive-only stability

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

---

## 6. Current dependency picture

The admissible Fitting branch now has a more precise spine:

```text
A1-L
+ COMP_P^G(adm)
+ consistency only if pNeg(Y)
        |
        v
extensional G-as-essence
        |
        v
de-re possibility -> necessity
        |
        |  positive G reflection/persistence only
        v
de-dicto possibility -> necessity
```

Restoring `A1-R` closes one of these savings by reconstructing full relevant exemplification consistency. It does **not** restore the need for negative `G`-extension stability in the positive de-dicto theorem.

This makes the A1 split productive again inside the Fitting comparison: the left channel drives the recovery proof, while the right channel strengthens the surrounding theory enough to erase one local weakening.

---

## 7. Open questions

The next principled minimization questions are:

1. can `COMP_P^G(adm)` itself be weakened without simply postulating the desired reflection conclusion;
2. can positive persistence or positive reflection be derived from other Fitting assumptions rather than assumed symmetrically as `STAB_G^+`;
3. which closure principles on `Adm` interact with these reductions;
4. whether the same A1-sensitive phenomenon survives paired-neighborhood semantics;
5. whether a source-grounded Fitting reconstruction should retain both A1 directions in the four-valued candidate or treat the A1-L recovery route independently.

No claim is made that `REG_G^neg` or `STAB_G^+` is globally weakest.
