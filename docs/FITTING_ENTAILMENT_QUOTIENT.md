# Gate 8 — Fitting entailment and the profile quotient

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-entailment-v0.1`  
**Scope:** interaction between Fitting-style extensional entailment, admissible-domain closure, and the positive-profile quotient  
**Verification target:** Lean 4.30.0 + executable finite regressions  
**Literature anchor:** Benzmüller–Fuenmayor 2020, especially the `delta`-filter / `delta`-ultrafilter analysis

This milestone follows `fitting-domain-v0.2`. Its initial question was whether a natural entailment-closure condition could generate the positive-profile saturation principle that underwrites the COMP-independent Fitting recovery route.

The answer is negative for naive domain closure, but the investigation produces a more useful positive structure: profile saturation is the fixed-point condition of a canonical closure operator, and actualist Fitting entailment descends through this closure when actual existence respects the same entity quotient.

---

## 1. Filter closure and domain closure are different interfaces

The classical Fitting analysis should not be read as requiring the entire property domain to be closed under arbitrary entailment consequences. In the published mechanized comparison, the `delta`-filter is a family of **positive extensions**. It contains the universal extension, excludes the empty extension, is upward closed under supersets, and is closed under intersections. The ultrafilter adds a maximality condition.

That is a closure principle for the positivity filter, not for the ambient extension domain.

The present four-valued reconstruction already has the corresponding positivity-level monotonicity interface in `A2PlusAdm`:

```text
Adm(X) + Adm(Y) + pPos(w,X) + EntailPlus(w,X,Y)
-> pPos(w,Y)
```

The new experiment therefore separates this source-grounded filter behavior from a much stronger candidate condition on `Adm` itself.

---

## 2. Naive domain-level entailment closure

Define:

```text
GlobalEntailmentClosedAdm:
  Adm(X)
  + (forall w. EntailPlus(w,X,Y))
  -> Adm(Y)
```

This looks natural at first, but it is the wrong kind of closure for the selected admissible property universe.

FDE bottom has no positive members, so

\[
  \bot_F \Vdash_E Y
\]

for every rigid extension `Y`: positive entailment from bottom is vacuous.

Lean therefore proves:

\[
\boxed{
GlobalEntailmentClosedAdm + Adm(\bot_F)
\Longrightarrow
\forall Y\,Adm(Y).
}
\]

Thus adding bottom to a globally entailment-closed admissible domain collapses the selected property universe to unrestricted bilateral comprehension.

This interacts directly with the earlier Gate-8 comprehension obstruction. Lean also proves:

\[
\boxed{
GlobalEntailmentClosedAdm
+Adm(\bot_F)
+CONS_G^{G,adm}
\Longrightarrow
\forall w,x\;\neg G_F^+(x,w).
}
\]

The universal glut extension is forced into `Adm`, and relevant exemplification consistency then excludes every positive Godlike witness.

So the classical filter closure cannot be lifted by simply turning `Adm` itself into an entailment-closed universe.

---

## 3. Strong finite separation

`formal/finite/gate8_fitting_entailment.py` uses the complete bilateral extension universe over two entities:

```text
4^2 = 16 bilateral extensions.
```

Both entities are actual at one reflexive world. Positive support is assigned to exactly those extensions whose positive channel contains both entities.

The fixture satisfies simultaneously:

```text
A2+
full domain-level entailment closure
full FDE algebra closure
profile-saturated actual existence
```

and positivity gives `a` and `b` the same positive-property profile.

Nevertheless the admissible universe contains a singleton positive distinguisher for `a`, so positive-profile saturation fails.

Hence even the strong package

\[
A2^+
+\text{domain entailment closure}
+\text{FDE algebra closure}
+\text{profile-compatible existence}
\]

does **not** derive `PositiveProfileSaturatedAdm`.

This strengthens the earlier algebra-only counterexample. Entailment closure is not the missing generator of the quotient.

---

## 4. Canonical profile-saturation closure

Instead of trying to derive the quotient by admitting more properties, define a closure operation on each bilateral extension.

For a fixed world `w`, let

\[
  x\approx_w^+y
\]

be the existing positive-profile equivalence relation. Define the bilateral saturation of `Y` by

\[
\begin{aligned}
 +Sat_w(Y)(x)
 &\Longleftrightarrow
 \exists y\,(x\approx_w^+y\land +Y(y)),\\
 -Sat_w(Y)(x)
 &\Longleftrightarrow
 \exists y\,(x\approx_w^+y\land -Y(y)).
\end{aligned}
\]

Lean formalizes this as `Extension.profileSaturateAt`.

The operation is machine-proved to be:

```text
extensive
monotone
idempotent up to bilateral extensional equivalence
```

and every saturated extension respects the profile quotient.

More strongly, Lean proves the universal property:

\[
\boxed{
Sat_w(X)
\text{ is the least quotient-respecting bilateral extension above }X.
}
\]

Thus the construction is a genuine closure operator on bilateral support information, not merely a restatement of the earlier saturation axiom.

---

## 5. Profile saturation as a fixed-point condition

The earlier domain principle can now be characterized exactly.

Lean proves:

\[
\boxed{
PositiveProfileSaturatedAdm
\Longleftrightarrow
\forall w,Y\,
\bigl(Adm(Y)\rightarrow Sat_w(Y)\equiv Y\bigr).
}
\]

Because `Adm` is already FDE-negation closed, the fixed-point condition is bilateral even though the profile relation was generated from positive support.

This gives the quotient route a more canonical mathematical reading:

> the admissible property domain is selected from the fixed points of the closure operator induced by positive-property observational equivalence.

It remains a substantive modeling condition, but it is no longer an isolated indiscernibility postulate.

---

## 6. Actualist entailment descends through the quotient

Fitting entailment is actualist:

\[
EntailPlus(w,X,Y)
\]

quantifies only over entities that actually exist at worlds accessible from `w`.

This introduces one further quotient issue. Two positive-profile-equivalent individuals can still be distinguished by the actual-existence predicate.

Define:

```text
ProfileExistenceSaturatedAdm:
  w R z
  + PositiveProfileEqAdm(w,x,y)
  -> (Exists(z,x) iff Exists(z,y))
```

Under this condition Lean proves:

\[
\boxed{
EntailPlus(w,X,Y)
\Longrightarrow
EntailPlus(w,Sat_w(X),Sat_w(Y)).
}
\]

So the actualist entailment relation is compatible with the profile closure precisely when actual existence does not split the relevant profile classes.

This identifies a new interface that was invisible while the quotient discussion concerned rigid extension membership alone: **actualist domain variation must itself respect the quotient if entailment is to descend cleanly.**

---

## 7. Why the existence condition matters

A second finite fixture uses two profile-equivalent entities `a,b` and a one-way accessibility edge to a world where only `a` actually exists.

Choose an extension `X` whose only positive member is `b`, and an empty-positive extension `Y`.

At the source world:

```text
EntailPlus(X,Y) = true
```

because the only positive member of `X` is not actual at the accessible world.

Profile saturation copies the positive membership of `b` to the equivalent entity `a`. Since `a` is actual, the saturated entailment fails:

```text
EntailPlus(Sat(X), Sat(Y)) = false.
```

Thus profile-compatible actual existence is not cosmetic. Without it, actualist entailment need not descend through the quotient.

This is a finite separation result, not a global necessity theorem for every possible quotient construction.

---

## 8. Current structural picture

The Fitting branch now distinguishes four layers:

```text
positivity filter:
  A2-style closure under extensional entailment

admissible property domain:
  selected bilateral extensions
  not naively closed under arbitrary entailment

profile closure:
  Sat_w = least quotient-respecting bilateral extension above Y
  Adm is profile-saturated iff its members are Sat_w fixed points

actualist entailment on the quotient:
  descends when actual existence respects the same profile classes
```

This explains why the initial entailment-closure idea fails and what survives from it.

The quotient is not generated by adding all logical consequences to `Adm`. Instead, quotient saturation is a closure/identification operation on extension membership, after which entailment is well behaved provided actualist existence is quotient-compatible.

---

## 9. Next questions

1. Can `ProfileExistenceSaturatedAdm` be derived from a more principled actualist-domain condition, or should quotient semantics explicitly require it?
2. Can the quotient be constructed as an explicit Lean quotient type so that admissible extensions and actual existence are represented directly on equivalence classes rather than through fixed-point predicates?
3. What is the correct four-valued filter or ultrafilter structure on the algebra of closure fixed points?
4. Does relevant entailment itself induce a useful order or topology on the quotient algebra?
5. Does the same closure construction survive paired-neighborhood modal semantics?
6. Can the quotient route be related to identity/monotheism questions without collapsing distinct profile-equivalent Godlike individuals by fiat?

No global minimality or novelty claim is made at this stage.
