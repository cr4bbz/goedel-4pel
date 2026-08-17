# Gate 8 — Fitting admissible-domain structure

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-domain-v0.2`  
**Scope:** principled reconstruction and algebraic analysis of the COMP-independent quotient route  
**Verification:** Lean 4.30.0 + executable finite regression  
**Literature anchor:** Benzmüller–Fuenmayor's extensional `delta`-ultrafilter analysis of Fitting positivity

This milestone refines `fitting-minimality-v0.2`. It asks whether the previously primitive interface `GodlikeIndiscernibilityAdm` can be derived from a more structural condition on the selected admissible property domain.

The answer is yes, by a quotient-style positive-profile saturation principle. Negation closure upgrades the positive quotient to a bilateral quotient, and the class of quotient-respecting bilateral extensions is closed under the basic FDE extension operations. A separate finite counterexample shows that ordinary FDE algebra closure does not itself force profile saturation. A separate ultrafilter-style analysis explains why the classical Fitting architecture does not by itself provide the genuinely COMP-independent route in the bilateral setting.

---

## 1. Literature-facing ultrafilter motivation

In the published mechanized comparison of Scott, Anderson, and Fitting, Fitting positivity ranges over rigid property extensions and is proved to form a `delta`-ultrafilter. The maximality component classically decides an extension or its complement as positive.

For the present four-valued project, isolate only this decision component:

```text
PositiveComplementDecisionAdm:
  Adm(Y) -> pPos(w,Y) or pPos(w,neg Y)
```

This is not declared to be a complete four-valued ultrafilter definition. It is only the part relevant to the current dependency question.

The bilateral setting exposes a difference from the Boolean case. Positive support for `neg Y` gives negative exemplification information about `Y`; it does not by itself imply absence of positive exemplification of `Y`.

Lean proves two interaction results:

```text
PositiveComplementDecisionAdm
+ ConsGGAdm
=> local positive reflection at Godlike witnesses
=> CompPGAdm
```

and independently:

```text
PositiveComplementDecisionAdm
+ A1RAdm
=> CompPGAdm.
```

Hence an ultrafilter-maximality explanation naturally reconstructs the earlier positivity-classification route once either relevant membership consistency or the right A1 channel is supplied. It does not explain the genuinely COMP-independent branch discovered in `fitting-minimality-v0.2`.

---

## 2. Positive property profiles

Define positive-profile equivalence at a world by

\[
x \approx_w^+ y
\]

iff every positively supported admissible extension contains `x` and `y` alike:

```text
PositiveProfileEqAdm M w x y :=
  forall X,
    Adm(X) -> pPos(w,X) -> (X.pos(x) iff X.pos(y))
```

Lean proves that this relation is reflexive, symmetric, and transitive.

Every pair of positive Fitting-Godlike individuals is automatically equivalent under this relation:

\[
G_F^+(x,w) \land G_F^+(y,w)
\Longrightarrow
x \approx_w^+ y.
\]

---

## 3. Quotient-style saturation of `Adm`

The structural domain condition is:

```text
PositiveProfileSaturatedAdm:
  Adm(Y)
  + PositiveProfileEqAdm(w,x,y)
  -> (Y.pos(x) iff Y.pos(y))
```

Lean proves:

\[
\boxed{
PositiveProfileSaturatedAdm
\Longrightarrow
GodlikeIndiscernibilityAdm.
}
\]

Combining this theorem with the existing alternative recovery result yields:

\[
\boxed{
G\text{-admissible}
+G_F\text{-realization}
+PositiveProfileSaturatedAdm
\Longrightarrow
G_F^+(x,w)\Rightarrow Ess_F^+(ext_wG,x,w).
}
\]

The necessary-existence and de-re/de-dicto results then follow through the already machine-checked indiscernibility route. No A1 direction, `COMP_P^G(adm)`, or exemplification-consistency assumption is needed for this route.

---

## 4. Negation closure upgrades the quotient to bilateral factorization

`AdmissibleSemantics` already requires FDE-negation closure:

```text
Adm(Y) -> Adm(neg Y).
```

Applying positive-profile saturation to `neg Y` transfers constancy of positive membership into constancy of negative membership of `Y`.

Define:

```text
BilateralProfileSaturatedAdm:
  Adm(Y)
  + PositiveProfileEqAdm(w,x,y)
  ->
     (Y.pos(x) iff Y.pos(y))
     and
     (Y.neg(x) iff Y.neg(y))
```

Lean proves the exact equivalence

\[
\boxed{
PositiveProfileSaturatedAdm
\Longleftrightarrow
BilateralProfileSaturatedAdm.
}
\]

Thus the selected bilateral extensions genuinely factor through one and the same entity quotient.

---

## 5. FDE algebra on the quotient

`FittingAdmissibleAlgebra.lean` defines pointwise extension-level FDE conjunction and disjunction, together with constant FDE top and bottom extensions.

For a fixed world, `RespectsProfileAt` means that a bilateral extension is constant in both support channels on every positive-profile equivalence class.

Lean proves that quotient-respecting bilateral extensions contain top and bottom and are closed under:

```text
FDE negation
FDE conjunction
FDE disjunction
```

Therefore the extensions that factor through the positive-profile quotient form a De-Morgan-style subalgebra of the full bilateral extension algebra.

This is deliberately an **algebraic preservation result**, not a new closure axiom for `Adm`. It shows that extending a profile-respecting domain by these FDE operations does not destroy quotient factorization.

---

## 6. Algebra closure does not generate the quotient

The converse idea fails. `formal/finite/gate8_fitting_algebra.py` uses the full classical four-extension algebra over two entities:

```text
EMPTY, {a}, {b}, ALL
```

This domain contains top and bottom and is closed under FDE negation, conjunction, and disjunction.

Positivity supports only `ALL`, so `a` and `b` have the same positive-property profile. Nevertheless the admissible singleton `{a}` contains `a` but not `b`. Hence profile saturation fails.

Therefore:

\[
\boxed{
\text{ordinary FDE algebra closure does not imply }PositiveProfileSaturatedAdm.
}
\]

The two results together locate the dependency precisely:

```text
profile saturation
  -> compatible with / preserved by the FDE algebra

FDE algebra closure
  -/-> profile saturation
```

So the quotient needs an additional extensionality or saturation principle. Closure under the ordinary FDE operations is not enough to derive it.

---

## 7. Nontrivial finite witness with two Godlike individuals

`formal/finite/gate8_fitting_profile_saturation.py` supplies a one-world, three-entity witness with admissible domain:

```text
EMPTY
AB
C
ALL
```

Positive support selects only `AB`, negative support selects `C`, and:

```text
a and b are both positive Godlike
c is not positive Godlike
```

The pair `a,b` forms one non-singleton positive-profile class and every admissible extension respects it. At the same time `ALL` is a genuine positivity gap:

```text
not pPos(w0, ALL)
not pNeg(w0, ALL)
```

so `CompPGAdm` fails. Nevertheless the current `G` extension `AB` is an essence of both `a` and `b`, and the finite fixture validates the corresponding NE realization and positive A5 interface.

Thus quotient-style profile saturation is compatible with a genuine relevant positivity gap and provides a nontrivial COMP-independent explanation of the indiscernibility route.

---

## 8. Interpretation

The current Fitting branch now contains three conceptually different mechanisms:

```text
classification route:
  A1-L + COMP + targeted consistency
  -> recover positivity of a possessed extension
  -> essence

ultrafilter-style route:
  complement decision + consistency (or A1-R)
  -> positive reflection / COMP
  -> classification route

profile-quotient route:
  admissible extensions factor bilaterally through positive-profile classes
  -> Godlike indiscernibility
  -> essence
```

The third route is the genuinely non-classificatory one.

It gives `Adm` a mathematical interpretation as a selected property algebra on a quotient of the entity domain by positive-property profile. The basic FDE operations preserve this factorization, but ordinary algebra closure alone does not generate it. This is a project-specific structural proposal, not a claim that Fitting historically imposed such a quotient semantics.

---

## 9. Open questions

1. What independently motivated extensionality or saturation principle should generate the positive-profile quotient, given that ordinary FDE algebra closure is insufficient?
2. Which additional operations, especially relevant entailment closure, preserve profile factorization?
3. Can a four-valued analogue of the literature's `delta`-ultrafilter be defined on the quotient domain so that profile saturation becomes automatic without reinstating `COMP`?
4. Does the quotient interpretation interact with genuinely glutty extension membership in a principled way?
5. Does the same construction survive paired-neighborhood modal semantics?
6. What relation, if any, does positive-profile equivalence have to monotheism or identity principles?

No global minimality or novelty claim is made at this stage.
