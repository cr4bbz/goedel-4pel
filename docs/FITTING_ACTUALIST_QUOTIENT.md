# Gate 8 — Explicit actualist profile quotient

**Milestone:** `fitting-actualist-quotient-v0.1`

**Status:** Lean-machine-checked and finite-regression-tested
**Scope:** explicit quotient entities, bilateral extension transport, actual-existence factorization, and quotient entailment

## Result

The earlier profile-saturation development represented quotient semantics indirectly, through extensions that are constant on positive-profile classes. This milestone constructs the quotient itself:

```text
ProfileQuotient M w := Entity / PositiveProfileEqAdm(M,w)
```

The canonical projection is `profileClass M w x = [x]`. Lean proves that bilateral extensions on quotient classes pull back to profile-respecting extensions on entities, and that every profile-respecting extension pushes forward to the quotient. Both round trips recover the original extension up to bilateral extensional equivalence.

Consequently, the fixed points of `profileSaturateAt` are not merely quotient-like: they have explicit representations as bilateral extensions on `ProfileQuotient M w`.

## Actual existence

For a source world `w` and accessible target `z`, define:

```text
ExistenceFactorsAt M w z :=
  exists existsQ : ProfileQuotient M w -> Prop,
    existsQ [x] <-> M.Exists z x
```

Lean proves the exact characterization

```text
ProfileExistenceSaturatedAdm M
  <-> forall w z, w R z -> ExistenceFactorsAt M w z.
```

Thus the earlier compatibility premise is precisely the representative-independence condition needed to interpret actual existence on quotient entities. It is not derived from a weaker actualist-domain axiom here; the explicit quotient identifies its semantic role.

## Actualist entailment

`ProfileQuotientEntailPlus` quantifies directly over accessible worlds and actually existing quotient classes. Under existence factorization, Lean proves:

```text
ProfileQuotientEntailPlus(w,QX,QY)
  <-> EntailPlus(w,pullback(QX),pullback(QY)).
```

For any profile-respecting ordinary extensions `X,Y`, this yields:

```text
EntailPlus(w,X,Y)
  <-> ProfileQuotientEntailPlus(w,push(X),push(Y)).
```

The previous one-way descent theorem is therefore strengthened to a two-way representation theorem on the quotient-respecting fragment.

## Finite regression

`formal/finite/gate8_fitting_actualist_quotient.py` uses two entities with one non-singleton positive-profile class. It checks:

- quotient/pullback round trips for all 16 bilateral extensions after profile saturation;
- all 256 ordered entailment comparisons between saturated extensions;
- survival of both `B` and `N` values on quotient classes;
- failure of representative-independent quotient existence when actual existence splits the class;
- the corresponding failure of entailment descent in that split-existence fixture.

The finite checks are bounded evidence for the implementation. The general factorization and entailment equivalences are Lean theorems.

## Consequence for the research program

The explicit quotient resolves the representation question left open by `fitting-entailment-v0.1`. The next algebraic question is now well posed: which genuinely four-valued filter conditions on the fixed-point/quotient extension algebra preserve `B` and `N` without automatically reconstructing positivity completeness?

No historical uniqueness, global minimality, or novelty claim is made.
