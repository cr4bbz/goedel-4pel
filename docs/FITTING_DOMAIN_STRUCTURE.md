# Gate 8 — Fitting admissible-domain structure

## Status

**Gate:** 8 — Comparative variants  
**Version:** `fitting-domain-v0.1`  
**Scope:** principled reconstruction of the COMP-independent indiscernibility route  
**Verification:** Lean 4.30.0 + executable finite regression  
**Literature anchor:** Benzmüller–Fuenmayor's extensional `delta`-ultrafilter analysis of Fitting positivity

This milestone refines `fitting-minimality-v0.2`. It asks whether the previously primitive interface `GodlikeIndiscernibilityAdm` can be derived from a more structural condition on the selected admissible property domain.

The answer is yes, by a quotient-style positive-profile saturation principle. A separate ultrafilter-style analysis explains why the classical Fitting architecture does not by itself provide the genuinely COMP-independent route in the bilateral setting.

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
```

and therefore

```text
PositiveComplementDecisionAdm
+ ConsGGAdm
=> CompPGAdm.
```

Independently,

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

Every pair of positive Fitting-Godlike individuals is automatically equivalent under this relation, because both individuals positively exemplify every positively supported admissible extension:

\[
G_F^+(x,w) \land G_F^+(y,w)
\Longrightarrow
x \approx_w^+ y.
\]

---

## 3. Quotient-style saturation of `Adm`

The new structural domain condition is:

```text
PositiveProfileSaturatedAdm:
  Adm(Y)
  + PositiveProfileEqAdm(w,x,y)
  -> (Y.pos(x) iff Y.pos(y))
```

Equivalently, at each world every selected admissible rigid extension is a union of equivalence classes of the positive-profile relation.

This is a property-domain condition rather than a positivity-classification condition. It does not require every admissible extension to receive positive or negative positivity support.

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

The necessary-existence and de-re/de-dicto results then follow through the already machine-checked indiscernibility route.

No A1 direction, `COMP_P^G(adm)`, or exemplification-consistency assumption is needed for this route.

---

## 4. Nontrivial finite witness with two Godlike individuals

`formal/finite/gate8_fitting_profile_saturation.py` supplies a one-world, three-entity witness.

The admissible negation-closed Boolean extension domain is:

```text
EMPTY
AB
C
ALL
```

with entities `a`, `b`, and `c`. Positive support selects only `AB`, and negative support selects its complement `C`.

Consequently:

```text
a and b are both positive Godlike
c is not positive Godlike
```

and `a` and `b` form one non-singleton positive-profile equivalence class.

Every admissible extension respects that class:

```text
EMPTY : neither a nor b
AB    : both a and b
C     : neither a nor b
ALL   : both a and b
```

so `PositiveProfileSaturatedAdm` and `GodlikeIndiscernibilityAdm` both hold non-vacuously.

At the same time, `ALL` contains both Godlike individuals but is a genuine positivity gap:

```text
not pPos(w0, ALL)
not pNeg(w0, ALL)
```

Therefore `CompPGAdm` fails.

Nevertheless the current `G` extension `AB` is an essence of both `a` and `b`, and the finite fixture also validates the corresponding NE realization and positive A5 interface.

Thus quotient-style profile saturation is compatible with a genuine relevant positivity gap and provides a nontrivial COMP-independent explanation of the indiscernibility route.

---

## 5. Interpretation

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

profile-saturation route:
  admissible extensions factor through positive-profile classes
  -> Godlike indiscernibility
  -> essence
```

The third route is the genuinely non-classificatory one.

It also gives `Adm` a more mathematical interpretation: the admissible property algebra can be viewed as living on a quotient of the entity domain by positive-property profile. This is currently a project-specific structural proposal, not a claim that Fitting historically imposed such a quotient semantics.

---

## 6. Open questions

1. Can positive-profile saturation be derived from independently motivated closure operations on `Adm` rather than postulated directly?
2. Which algebraic operations on admissible extensions preserve profile saturation: FDE negation, conjunction/intersection, disjunction/union, and relevant entailment closure?
3. Can a four-valued analogue of the literature's `delta`-ultrafilter be defined on the quotient domain so that profile saturation becomes automatic without reinstating `COMP`?
4. Does the quotient interpretation interact with genuine glutty extension membership in a principled way?
5. Does the same construction survive paired-neighborhood modal semantics?
6. What relation, if any, does positive-profile equivalence have to monotheism or identity principles? The published Fitting comparison leaves monotheism/polytheism as a separate research direction.

No global minimality or novelty claim is made at this stage.
