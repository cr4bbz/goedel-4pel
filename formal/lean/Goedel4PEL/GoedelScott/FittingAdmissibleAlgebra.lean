import Goedel4PEL.GoedelScott.FittingAdmissibleStructure

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- Pointwise FDE conjunction of bilateral rigid extensions. -/
def Extension.fdeConj (X Y : Extension Entity) : Extension Entity :=
  ⟨fun x => X.pos x ∧ Y.pos x, fun x => X.neg x ∨ Y.neg x⟩

/-- Pointwise FDE disjunction of bilateral rigid extensions. -/
def Extension.fdeDisj (X Y : Extension Entity) : Extension Entity :=
  ⟨fun x => X.pos x ∨ Y.pos x, fun x => X.neg x ∧ Y.neg x⟩

/-- Constant top extension in the FDE extension algebra. -/
def Extension.fdeTop : Extension Entity :=
  ⟨fun _ => True, fun _ => False⟩

/-- Constant bottom extension in the FDE extension algebra. -/
def Extension.fdeBot : Extension Entity :=
  ⟨fun _ => False, fun _ => True⟩

/-- One bilateral extension respects one positive-profile quotient at one world. -/
def RespectsProfileAt
    (M : AdmissibleSemantics World Entity)
    (w : World) (Y : Extension Entity) : Prop :=
  ∀ x y,
    PositiveProfileEqAdm M w x y →
    (Y.pos x ↔ Y.pos y) ∧ (Y.neg x ↔ Y.neg y)

/-- FDE negation preserves factorization through the quotient. -/
theorem respectsProfileAt_negate
    (M : AdmissibleSemantics World Entity)
    (w : World) (X : Extension Entity)
    (hX : RespectsProfileAt M w X) :
    RespectsProfileAt M w X.negate := by
  intro x y hEq
  have h := hX x y hEq
  exact ⟨h.2, h.1⟩

/-- FDE conjunction preserves factorization through the quotient. -/
theorem respectsProfileAt_fdeConj
    (M : AdmissibleSemantics World Entity)
    (w : World) (X Y : Extension Entity)
    (hX : RespectsProfileAt M w X)
    (hY : RespectsProfileAt M w Y) :
    RespectsProfileAt M w (X.fdeConj Y) := by
  intro x y hEq
  have hx := hX x y hEq
  have hy := hY x y hEq
  constructor
  · constructor
    · intro h
      exact ⟨hx.1.1 h.1, hy.1.1 h.2⟩
    · intro h
      exact ⟨hx.1.2 h.1, hy.1.2 h.2⟩
  · constructor
    · intro h
      cases h with
      | inl hXNeg => exact Or.inl (hx.2.1 hXNeg)
      | inr hYNeg => exact Or.inr (hy.2.1 hYNeg)
    · intro h
      cases h with
      | inl hXNeg => exact Or.inl (hx.2.2 hXNeg)
      | inr hYNeg => exact Or.inr (hy.2.2 hYNeg)

/-- FDE disjunction preserves factorization through the quotient. -/
theorem respectsProfileAt_fdeDisj
    (M : AdmissibleSemantics World Entity)
    (w : World) (X Y : Extension Entity)
    (hX : RespectsProfileAt M w X)
    (hY : RespectsProfileAt M w Y) :
    RespectsProfileAt M w (X.fdeDisj Y) := by
  intro x y hEq
  have hx := hX x y hEq
  have hy := hY x y hEq
  constructor
  · constructor
    · intro h
      cases h with
      | inl hXPos => exact Or.inl (hx.1.1 hXPos)
      | inr hYPos => exact Or.inr (hy.1.1 hYPos)
    · intro h
      cases h with
      | inl hXPos => exact Or.inl (hx.1.2 hXPos)
      | inr hYPos => exact Or.inr (hy.1.2 hYPos)
  · constructor
    · intro h
      exact ⟨hx.2.1 h.1, hy.2.1 h.2⟩
    · intro h
      exact ⟨hx.2.2 h.1, hy.2.2 h.2⟩

/-- FDE top respects every profile quotient. -/
theorem respectsProfileAt_fdeTop
    (M : AdmissibleSemantics World Entity) (w : World) :
    RespectsProfileAt M w (Extension.fdeTop (Entity := Entity)) := by
  intro x y hEq
  exact ⟨Iff.rfl, Iff.rfl⟩

/-- FDE bottom respects every profile quotient. -/
theorem respectsProfileAt_fdeBot
    (M : AdmissibleSemantics World Entity) (w : World) :
    RespectsProfileAt M w (Extension.fdeBot (Entity := Entity)) := by
  intro x y hEq
  exact ⟨Iff.rfl, Iff.rfl⟩

/-- Every admissible extension in a profile-saturated model factors through the quotient. -/
theorem admissible_respectsProfileAt
    (M : AdmissibleSemantics World Entity)
    (hSat : PositiveProfileSaturatedAdm M)
    (Y : Extension Entity)
    (hYAdm : M.admissible Y) :
    ∀ w, RespectsProfileAt M w Y := by
  intro w x y hEq
  exact (positiveProfileSaturated_implies_bilateralProfileSaturated M hSat)
    w x y Y hYAdm hEq

/--
At each world, bilateral extensions that factor through the positive-profile
quotient contain top and bottom and are closed under FDE negation,
conjunction, and disjunction.

This is an algebraic preservation theorem. It does not assert that the
selected `Adm` predicate itself is closed under all these operations.
-/
theorem profileFactorization_closed_under_fde
    (M : AdmissibleSemantics World Entity) (w : World) :
    RespectsProfileAt M w (Extension.fdeTop (Entity := Entity)) ∧
    RespectsProfileAt M w (Extension.fdeBot (Entity := Entity)) ∧
    (∀ X, RespectsProfileAt M w X → RespectsProfileAt M w X.negate) ∧
    (∀ X Y, RespectsProfileAt M w X → RespectsProfileAt M w Y →
      RespectsProfileAt M w (X.fdeConj Y)) ∧
    (∀ X Y, RespectsProfileAt M w X → RespectsProfileAt M w Y →
      RespectsProfileAt M w (X.fdeDisj Y)) := by
  exact ⟨
    respectsProfileAt_fdeTop M w,
    respectsProfileAt_fdeBot M w,
    fun X hX => respectsProfileAt_negate M w X hX,
    fun X Y hX hY => respectsProfileAt_fdeConj M w X Y hX hY,
    fun X Y hX hY => respectsProfileAt_fdeDisj M w X Y hX hY
  ⟩

end Goedel4PEL.GoedelScott.Fitting
