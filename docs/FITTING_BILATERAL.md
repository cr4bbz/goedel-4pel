# Gate 8 — Bilateral Fitting candidate

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-bilateral-v0.2`  
**Scope:** bilateral four-valued Fitting comparison with an explicit extensional property domain  
**Verification:** Lean 4.30.0 + executable finite regressions

This file freezes the current substantive Fitting candidate. It extends the earlier type-boundary milestone in `FITTING_TYPES.md`.

The positive/classical architecture is literature-grounded by the published mechanized Scott/Anderson/Fitting comparison. The bilateral negative-support clauses and admissible-domain reconstruction are project choices. They are not presented as the unique four-valued Fitting semantics.

---

## 1. Intensions and extensions remain different types

The Fitting branch keeps the type boundary:

```text
Extension Entity
Intension World Entity := World -> Extension Entity
```

with

```text
extensionAt : Intension World Entity -> World -> Extension Entity
```

Positivity consumes an extension:

```text
pPos : World -> Extension Entity -> Prop
pNeg : World -> Extension Entity -> Prop
```

rather than an intension. Necessary entailment and essence therefore compare rigid extensions.

---

## 2. The unrestricted bilateral-comprehension obstruction

A first naive lift let Fitting Godlikeness and the relevant regularity package quantify over every inhabitant of the bilateral type `Extension Entity`.

That domain automatically contains the universal glut extension

```text
B.pos x = True
B.neg x = True
```

for every entity `x`.

Lean proves generally:

```text
ConsGG M -> forall w x, not GodPlus M w x
RegG  M -> forall w x, not GodPlus M w x
```

because every Godlike individual must positively belong to every positive extension, while relevant exemplification consistency applied to the universal glut extension forbids its negative membership. Under unrestricted bilateral comprehension the current `REG_G^ext` recovery route is therefore incompatible with a positive Godlike witness.

This is a semantic obstruction, not an elaboration or finite-model artifact. The earlier unrestricted implication from `RegG` to Fitting essence remains logically valid but is not used as the substantive recovery theorem because its Godlike antecedent is excluded by the package itself.

---

## 3. Admissible extensional property domain

The substantive candidate introduces a selected domain

\[
Adm(X)
\]

of admissible bilateral extensions. The only structural closure currently frozen is FDE negation:

\[
Adm(X) \Longrightarrow Adm(\neg X).
\]

Lean represents this by:

```text
AdmissibleSemantics
  base          : Fitting.Semantics
  admissible    : Extension Entity -> Prop
  negate_closed : admissible X -> admissible (negate X)
```

Godlikeness, A1, A2, essence, necessary existence, and the relevant regularity assumptions quantify only over the selected extensional domain.

This is **not** a global consistency restriction. Admissible extensions may be genuinely glutty. A complete-S5 finite fixture used below contains an admissible extension with value `B` on one entity and also contains its FDE negation.

---

## 4. Admissible-domain Godlikeness and essence

Positive Fitting Godlikeness is:

\[
G_F^+(x,w)
\quad\text{iff}\quad
\forall X\,[Adm(X)\land +P(X)@w\Rightarrow +X(x)].
\]

Positive extensional necessary entailment is:

\[
Ent_F^+(X,Y,w)
\quad\text{iff}\quad
\forall z\,(wRz\Rightarrow
\forall^E y\,(+X(y)\Rightarrow +Y(y))).
\]

Positive essence is:

\[
Ess_F^+(X,x,w)
\]

iff `X` is admissible, `x` belongs positively to `X`, and `X` positively necessarily entails every admissible extension positively containing `x`.

The admissible regularity package is:

```text
REG_G^adm := COMP_P^G(adm) + CONS_G^G(adm)
```

restricted to admissible extensions positively exemplified by positive Fitting-Godlike witnesses.

Lean proves:

\[
\boxed{
G\text{-admissible}
+G_F\text{-realization}
+A1_{L,F}^{adm}
+REG_G^{adm}
\Longrightarrow
G_F^+(x,w)\Rightarrow
Ess_F^+(ext_wG,x,w).
}
\]

No positivity-rigidity premise `R+` occurs. The reason is structural: Fitting entailment ranges over rigid extensions, so the recovered current-world positivity classification does not need to be transported as positivity information to each accessible world.

---

## 5. Bilateral negative evidence and classical recovery

The project uses explicit counter-information rather than meta-level failure for the negative channels.

For example:

\[
Ent_F^-(X,Y,w)
\]

holds when an accessible actual entity belongs positively to `X` and negatively to `Y`, and

\[
NE_F^-(x,w)
\]

holds when an admissible positive essence of `x` has explicit negative evidence against necessary actual exemplification.

Assume classical coherence on the selected extensional domain:

\[
-X(x)\quad\text{iff}\quad\neg(+X(x))
\]

for every admissible `X`.

Lean proves:

```text
EntailMinus    iff not EntailPlus
GodMinusAdm    iff not GodPlusAdm
EssMinusAdm    iff not EssPlusAdm
BoxExistsMinus iff not BoxExistsPlus
NEMinusAdm     iff not NEPlusAdm
```

with the appropriate admissibility premises. Thus the bilateral evidence clauses recover the intended Boolean interfaces on the classical fragment.

---

## 6. Necessary existence and the de-re K-style channel

A distinguished intension `NE` realizes admissible-domain positive necessary existence, and positive A5 applies positivity to its current extension.

Define de-re possible actual exemplification of the current `G` extension by freezing `ext_w G` before moving to an accessible world:

\[
\Diamond_{de\,re}^+\exists^E x\,ext_wG(x).
\]

Lean proves:

\[
\boxed{
\begin{aligned}
&G\text{-admissible}
+G_F\text{-realization}
+A1_{L,F}^{adm}
+REG_G^{adm}\\
&+NE_F\text{-realization}
+A5_F^+
+\Diamond_{de\,re}^+\exists^E x\,ext_wG(x)\\
&\qquad\Longrightarrow
\Box_{de\,re}^+\exists^E x\,ext_wG(x).
\end{aligned}}
\]

No reflexivity, symmetry, transitivity, seriality, or positivity-rigidity premise is used. The result is therefore K-style at the frame level.

---

## 7. De dicto requires an intension/extension bridge

De-dicto Godlikeness re-evaluates the intension `G` at the accessible world:

\[
\Diamond^+\exists^E x\,G_F(x)
\]

and

\[
\Box^+\exists^E x\,G_F(x).
\]

The project keeps the bridge from de re to de dicto explicit:

\[
STAB_G:
\quad
wRz\Rightarrow ext_wG\equiv ext_zG.
\]

Under `STAB_G`, Lean proves both conversion lemmas and hence:

\[
\boxed{
\text{admissible Fitting stack}
+STAB_G
+\Diamond^+\exists^E x\,G_F(x)
\Longrightarrow
\Box^+\exists^E x\,G_F(x).
}
\]

Again no S4/S5 frame condition is used. The extra resource is stability of the intension/extension interface rather than a relational frame axiom.

---

## 8. Executable de-re/de-dicto separation

A three-world, two-entity finite model has a negation-closed selected extensional domain and satisfies the admissible Fitting recovery stack.

At the root world `w0`:

```text
+ de-re possible current-G exemplification
+ de-re necessary current-G exemplification
+ de-dicto possible Godlikeness
- de-dicto necessary Godlikeness
- STAB_G
```

The accessible world `w1` still has a Godlike witness, while at accessible `w2` the extension of `G` has changed so that nobody is Godlike. This explicitly separates the de-re and de-dicto channels when extension stability is absent.

The regression is implemented in:

```text
formal/finite/gate8_fitting.py
```

---

## 9. Necessary Godlike existence without positive modal collapse

A second executable fixture uses a complete two-world S5 frame and a selected negation-closed extensional domain. It satisfies the encoded admissible Fitting stack, including:

```text
A1-L
A1-R
A2+
G-realization
REG_G^adm
NE-realization
A5+
STAB_G
positive necessary actual Godlikeness
```

The selected extension domain still contains genuine inconsistent information: one admissible extension has value `B` on entity `b`, together with its FDE negation.

A contingent intension `Q` satisfies

\[
+Q(a)@w_0
\]

but not

\[
+\Box Q(a)@w_0.
\]

Therefore the current bilateral admissible Fitting candidate admits positive necessary Godlike existence while positive modal collapse fails.

This is a finite model result, not a theorem that every Fitting lift avoids modal collapse.

The regression is implemented in:

```text
formal/finite/gate8_fitting_no_collapse.py
```

---

## 10. Comparative picture

The verified Gate-8 comparison now has three distinct structural mechanisms:

```text
Scott support:
  local support Godlikeness
  + reflection recovery
  + R+
  + REG_G
  -> T2+

Anderson:
  positivity classifies necessary exemplification of the same individual
  -> modified essence / NE chain
  -> symmetry is the current T3 return bridge

Fitting admissible:
  positivity classifies selected rigid extensions
  -> no R+ in the extensional essence recovery theorem
  -> de-re possibility-to-necessity is frame-free
  -> de-dicto lifting is controlled by STAB_G
  -> necessary Godlike existence can coexist with MC+ failure
```

This supports the project's broader thesis that modal-collapse behavior is controlled not merely by the strength of the accessibility relation, but by where modal and informational structure is placed in Godlikeness, positivity, essence, and the intension/extension interface.

---

## 11. Remaining questions

Open Gate-8 questions include:

1. whether `REG_G^adm` can be weakened at the unbounded model-theoretic level;
2. which principled closure conditions should characterize the admissible extensional domain beyond negation closure;
3. whether `STAB_G` itself has a weaker extensional or local replacement;
4. how the Scott, Anderson, and Fitting results behave over paired-neighborhood semantics;
5. exact source-level correspondence with the published HOL/IHOML developments before publication claims.

No novelty claim is made before the dedicated Gate-9 prior-art audit.
