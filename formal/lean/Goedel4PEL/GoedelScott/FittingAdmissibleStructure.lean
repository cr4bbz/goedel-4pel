import Goedel4PEL.GoedelScott.FittingAlternativeRecovery

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/--
Two individuals have the same positive admissible-property profile at a world
when every positively supported admissible extension contains them alike.
-/
def PositiveProfileEqAdm
    (M : AdmissibleSemantics World Entity)
    (w : World) (x y : Entity) : Prop :=
  ∀ X : Extension Entity,
    M.admissible X → M.base.pPos w X → (X.pos x ↔ X.pos y)

 theorem positiveProfileEqAdm_refl
    (M : AdmissibleSemantics World Entity) (w : World) (x : Entity) :
    PositiveProfileEqAdm M w x x := by
  intro X hAdm hPos
  exact Iff.rfl

 theorem positiveProfileEqAdm_symm
    (M : AdmissibleSemantics World Entity) (w : World) (x y : Entity)
    (h : PositiveProfileEqAdm M w x y) :
    PositiveProfileEqAdm M w y x := by
  intro X hAdm hPos
  exact (h X hAdm hPos).symm

 theorem positiveProfileEqAdm_trans
    (M : AdmissibleSemantics World Entity) (w : World) (x y z : Entity)
    (hxy : PositiveProfileEqAdm M w x y)
    (hyz : PositiveProfileEqAdm M w y z) :
    PositiveProfileEqAdm M w x z := by
  intro X hAdm hPos
  exact (hxy X hAdm hPos).trans (hyz X hAdm hPos)

/--
Quotient-style saturation of the admissible extension domain.

Every admissible rigid extension must respect positive-profile equivalence.
Equivalently, each admissible extension is a union of equivalence classes of
`PositiveProfileEqAdm` at every evaluation world.
-/
def PositiveProfileSaturatedAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w x y (Y : Extension Entity),
    M.admissible Y →
    PositiveProfileEqAdm M w x y →
    (Y.pos x ↔ Y.pos y)

/-- Positive Fitting-Godlike individuals automatically share their positive profile. -/
theorem godlike_implies_positiveProfileEqAdm
    (M : AdmissibleSemantics World Entity) :
    ∀ w x y,
      GodPlusAdm M w x →
      GodPlusAdm M w y →
      PositiveProfileEqAdm M w x y := by
  intro w x y hGodX hGodY X hXAdm hPX
  have hx : X.pos x := hGodX X hXAdm hPX
  have hy : X.pos y := hGodY X hXAdm hPX
  constructor
  · intro _
    exact hy
  · intro _
    exact hx

/--
Positive-profile saturation derives the previously primitive Godlike
indiscernibility interface.
-/
theorem positiveProfileSaturated_implies_godlikeIndiscernibility
    (M : AdmissibleSemantics World Entity)
    (hSat : PositiveProfileSaturatedAdm M) :
    GodlikeIndiscernibilityAdm M := by
  intro w x y Y hYAdm hGodX hGodY
  exact hSat w x y Y hYAdm
    (godlike_implies_positiveProfileEqAdm M w x y hGodX hGodY)

/--
A literature-facing ultrafilter-maximality fragment: every admissible
extension or its FDE complement is positively supported.

This is only the maximality/decision component, not a full four-valued
ultrafilter definition.
-/
def PositiveComplementDecisionAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w (Y : Extension Entity),
    M.admissible Y →
    M.base.pPos w Y ∨ M.base.pPos w Y.negate

/--
With relevant exemplification consistency, complement decision is already
strong enough to recover local positive reflection at Godlike witnesses.
Thus an ultrafilter-style explanation does not provide the genuinely
COMP-independent route obtained from profile saturation.
-/
theorem complementDecision_cons_implies_positiveReflection
    (M : AdmissibleSemantics World Entity)
    (hDec : PositiveComplementDecisionAdm M)
    (hCons : ConsGGAdm M) :
    ∀ w x (Y : Extension Entity),
      M.admissible Y →
      GodPlusAdm M w x →
      Y.pos x →
      M.base.pPos w Y := by
  intro w x Y hYAdm hGodX hYx
  rcases hDec w Y hYAdm with hPY | hPNotY
  · exact hPY
  · have hNotYAdm : M.admissible Y.negate := M.negate_closed Y hYAdm
    have hNotYx : Y.neg x := by
      have h : Y.negate.pos x := hGodX Y.negate hNotYAdm hPNotY
      simpa using h
    have hNoNegY : ¬ Y.neg x := hCons w x Y hYAdm hGodX hYx
    exact False.elim (hNoNegY hNotYx)

/-- Complement decision plus relevant consistency implies the old completeness interface. -/
theorem complementDecision_cons_implies_compPGAdm
    (M : AdmissibleSemantics World Entity)
    (hDec : PositiveComplementDecisionAdm M)
    (hCons : ConsGGAdm M) :
    CompPGAdm M := by
  intro w x Y hYAdm hGodX hYx
  exact Or.inl
    (complementDecision_cons_implies_positiveReflection
      M hDec hCons w x Y hYAdm hGodX hYx)

/--
If A1-R is retained, complement decision also yields positivity completeness
directly by translating positive support for the complement into negative
support for the original extension.
-/
theorem complementDecision_a1R_implies_compPGAdm
    (M : AdmissibleSemantics World Entity)
    (hDec : PositiveComplementDecisionAdm M)
    (hA1R : A1RAdm M) :
    CompPGAdm M := by
  intro w x Y hYAdm hGodX hYx
  rcases hDec w Y hYAdm with hPY | hPNotY
  · exact Or.inl hPY
  · exact Or.inr (hA1R w Y hYAdm hPNotY)

end Goedel4PEL.GoedelScott.Fitting
