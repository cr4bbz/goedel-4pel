import Goedel4PEL.GoedelScott.FittingEntailmentQuotient

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- Positive-support inclusion, the order used by the classical `delta`-filter. -/
def ExtensionPositiveLe (X Y : Extension Entity) : Prop :=
  ∀ x, X.pos x → Y.pos x

/--
The FDE truth order on bilateral extensions.

Positive support grows upwards while negative support shrinks. This must be
kept distinct from `ExtensionSupportLe`, which is the information order and
grows both support channels simultaneously.
-/
def ExtensionTruthLe (X Y : Extension Entity) : Prop :=
  (∀ x, X.pos x → Y.pos x) ∧
  (∀ x, Y.neg x → X.neg x)

theorem extensionTruthLe_refl (X : Extension Entity) :
    ExtensionTruthLe X X := by
  exact ⟨fun _ hx => hx, fun _ hx => hx⟩

theorem extensionTruthLe_trans
    {X Y Z : Extension Entity}
    (hXY : ExtensionTruthLe X Y)
    (hYZ : ExtensionTruthLe Y Z) :
    ExtensionTruthLe X Z := by
  constructor
  · intro x hx
    exact hYZ.1 x (hXY.1 x hx)
  · intro x hx
    exact hXY.2 x (hYZ.2 x hx)

theorem extensionTruthLe_implies_positiveLe
    {X Y : Extension Entity}
    (hXY : ExtensionTruthLe X Y) :
    ExtensionPositiveLe X Y := by
  exact hXY.1

/-- Under classical coherence, positive inclusion recovers the full truth order. -/
theorem extensionPositiveLe_implies_truthLe_of_classical
    (M : AdmissibleSemantics World Entity)
    (hClassical : ExtensionClassicalAdm M)
    {X Y : Extension Entity}
    (hXAdm : M.admissible X)
    (hYAdm : M.admissible Y)
    (hXY : ExtensionPositiveLe X Y) :
    ExtensionTruthLe X Y := by
  constructor
  · exact hXY
  · intro x hYNeg
    have hNotYPos : ¬ Y.pos x := (hClassical Y hYAdm x).1 hYNeg
    have hNotXPos : ¬ X.pos x := by
      intro hXPos
      exact hNotYPos (hXY x hXPos)
    exact (hClassical X hXAdm x).2 hNotXPos

/-- FDE negation reverses the truth order. -/
theorem extensionTruthLe_negate
    {X Y : Extension Entity}
    (hXY : ExtensionTruthLe X Y) :
    ExtensionTruthLe Y.negate X.negate := by
  exact ⟨hXY.2, hXY.1⟩

/-- FDE conjunction is below its left argument in the truth order. -/
theorem fdeConj_truthLe_left (X Y : Extension Entity) :
    ExtensionTruthLe (X.fdeConj Y) X := by
  constructor
  · intro x h
    exact h.1
  · intro x h
    exact Or.inl h

/-- FDE conjunction is below its right argument in the truth order. -/
theorem fdeConj_truthLe_right (X Y : Extension Entity) :
    ExtensionTruthLe (X.fdeConj Y) Y := by
  constructor
  · intro x h
    exact h.2
  · intro x h
    exact Or.inr h

/-- FDE conjunction is the greatest lower bound in the truth order. -/
theorem truthLe_fdeConj
    {X Y Z : Extension Entity}
    (hZX : ExtensionTruthLe Z X)
    (hZY : ExtensionTruthLe Z Y) :
    ExtensionTruthLe Z (X.fdeConj Y) := by
  constructor
  · intro x hZ
    exact ⟨hZX.1 x hZ, hZY.1 x hZ⟩
  · intro x hNeg
    cases hNeg with
    | inl hXNeg => exact hZX.2 x hXNeg
    | inr hYNeg => exact hZY.2 x hYNeg

/-- FDE disjunction is above its left argument in the truth order. -/
theorem left_truthLe_fdeDisj (X Y : Extension Entity) :
    ExtensionTruthLe X (X.fdeDisj Y) := by
  constructor
  · intro x h
    exact Or.inl h
  · intro x h
    exact h.1

/-- FDE disjunction is above its right argument in the truth order. -/
theorem right_truthLe_fdeDisj (X Y : Extension Entity) :
    ExtensionTruthLe Y (X.fdeDisj Y) := by
  constructor
  · intro x h
    exact Or.inr h
  · intro x h
    exact h.2

/-- FDE disjunction is the least upper bound in the truth order. -/
theorem fdeDisj_truthLe
    {X Y Z : Extension Entity}
    (hXZ : ExtensionTruthLe X Z)
    (hYZ : ExtensionTruthLe Y Z) :
    ExtensionTruthLe (X.fdeDisj Y) Z := by
  constructor
  · intro x hPos
    cases hPos with
    | inl hXPos => exact hXZ.1 x hXPos
    | inr hYPos => exact hYZ.1 x hYPos
  · intro x hZNeg
    exact ⟨hXZ.2 x hZNeg, hYZ.2 x hZNeg⟩

/-- The selected admissible domain is an FDE subalgebra. -/
structure AdmissibleFDEAlgebra
    (M : AdmissibleSemantics World Entity) : Prop where
  top_admissible : M.admissible (Extension.fdeTop (Entity := Entity))
  bot_admissible : M.admissible (Extension.fdeBot (Entity := Entity))
  conj_admissible : ∀ X Y,
    M.admissible X → M.admissible Y → M.admissible (X.fdeConj Y)
  disj_admissible : ∀ X Y,
    M.admissible X → M.admissible Y → M.admissible (X.fdeDisj Y)

/--
A proper lattice filter of positively supported admissible extensions, using
the FDE truth order. Maximality is deliberately not part of this definition.
-/
structure DeltaFilterAdmAt
    (M : AdmissibleSemantics World Entity) (w : World) : Prop where
  top_positive : M.base.pPos w (Extension.fdeTop (Entity := Entity))
  bot_not_positive : ¬ M.base.pPos w (Extension.fdeBot (Entity := Entity))
  upward : ∀ X Y,
    M.admissible X → M.admissible Y →
    M.base.pPos w X → ExtensionTruthLe X Y → M.base.pPos w Y
  conj_positive : ∀ X Y,
    M.admissible X → M.admissible Y →
    M.base.pPos w X → M.base.pPos w Y → M.base.pPos w (X.fdeConj Y)

/-- The direct classical set-filter formulation, using positive inclusion only. -/
structure ClassicalDeltaFilterAdmAt
    (M : AdmissibleSemantics World Entity) (w : World) : Prop where
  top_positive : M.base.pPos w (Extension.fdeTop (Entity := Entity))
  bot_not_positive : ¬ M.base.pPos w (Extension.fdeBot (Entity := Entity))
  upward : ∀ X Y,
    M.admissible X → M.admissible Y →
    M.base.pPos w X → ExtensionPositiveLe X Y → M.base.pPos w Y
  conj_positive : ∀ X Y,
    M.admissible X → M.admissible Y →
    M.base.pPos w X → M.base.pPos w Y → M.base.pPos w (X.fdeConj Y)

/-- Every classical positive-set filter is an FDE truth-order filter. -/
theorem classicalDeltaFilter_implies_deltaFilter
    (M : AdmissibleSemantics World Entity) (w : World)
    (h : ClassicalDeltaFilterAdmAt M w) :
    DeltaFilterAdmAt M w := by
  refine ⟨h.top_positive, h.bot_not_positive, ?_, h.conj_positive⟩
  intro X Y hXAdm hYAdm hPX hXY
  exact h.upward X Y hXAdm hYAdm hPX
    (extensionTruthLe_implies_positiveLe hXY)

/-- Under classical coherence, the FDE filter recovers the classical set filter. -/
theorem deltaFilter_implies_classicalDeltaFilter_of_classical
    (M : AdmissibleSemantics World Entity) (w : World)
    (hClassical : ExtensionClassicalAdm M)
    (h : DeltaFilterAdmAt M w) :
    ClassicalDeltaFilterAdmAt M w := by
  refine ⟨h.top_positive, h.bot_not_positive, ?_, h.conj_positive⟩
  intro X Y hXAdm hYAdm hPX hXY
  exact h.upward X Y hXAdm hYAdm hPX
    (extensionPositiveLe_implies_truthLe_of_classical
      M hClassical hXAdm hYAdm hXY)

/-- The classical and FDE filter notions coincide on coherent extensions. -/
theorem deltaFilter_iff_classicalDeltaFilter_of_classical
    (M : AdmissibleSemantics World Entity) (w : World)
    (hClassical : ExtensionClassicalAdm M) :
    DeltaFilterAdmAt M w ↔ ClassicalDeltaFilterAdmAt M w := by
  constructor
  · exact deltaFilter_implies_classicalDeltaFilter_of_classical M w hClassical
  · exact classicalDeltaFilter_implies_deltaFilter M w

/--
A profile `delta`-filter lives on an admissible FDE subalgebra whose elements
are fixed points of the canonical profile closure.
-/
structure ProfileDeltaFilterAdm
    (M : AdmissibleSemantics World Entity) : Prop where
  profile_saturated : PositiveProfileSaturatedAdm M
  algebra : AdmissibleFDEAlgebra M
  filter_at : ∀ w, DeltaFilterAdmAt M w

/-- Every carrier element of a profile filter is a closure fixed point. -/
theorem profileDeltaFilter_admissible_fixed
    (M : AdmissibleSemantics World Entity)
    (h : ProfileDeltaFilterAdm M) :
    ∀ w (X : Extension Entity), M.admissible X →
      ExtensionEquivalent (X.profileSaturateAt M w) X := by
  exact (positiveProfileSaturated_iff_fixedByProfileClosure M).1
    h.profile_saturated

/--
The bilateral version connects negative positivity-support to positive support
of the FDE complement. This is precisely the combined A1-L/A1-R interface on
the admissible carrier; it still permits both gluts and gaps.
-/
structure BilateralProfileDeltaFilterAdm
    (M : AdmissibleSemantics World Entity) : Prop
    extends ProfileDeltaFilterAdm M where
  polarity : ∀ w X, M.admissible X →
    (M.base.pNeg w X ↔ M.base.pPos w X.negate)

theorem bilateralProfileDeltaFilter_implies_a1L
    (M : AdmissibleSemantics World Entity)
    (h : BilateralProfileDeltaFilterAdm M) :
    A1LAdm M := by
  intro w X hXAdm hNeg
  exact (h.polarity w X hXAdm).1 hNeg

theorem bilateralProfileDeltaFilter_implies_a1R
    (M : AdmissibleSemantics World Entity)
    (h : BilateralProfileDeltaFilterAdm M) :
    A1RAdm M := by
  intro w X hXAdm hPosNeg
  exact (h.polarity w X hXAdm).2 hPosNeg

/-- The negative support family contains FDE bottom. -/
theorem bilateralProfileDeltaFilter_bot_negative
    (M : AdmissibleSemantics World Entity)
    (h : BilateralProfileDeltaFilterAdm M) :
    ∀ w, M.base.pNeg w (Extension.fdeBot (Entity := Entity)) := by
  intro w
  have hBotAdm := h.toProfileDeltaFilterAdm.algebra.bot_admissible
  apply (h.polarity w (Extension.fdeBot (Entity := Entity)) hBotAdm).2
  have hTopAdm := h.toProfileDeltaFilterAdm.algebra.top_admissible
  have hNegBotAdm := M.negate_closed _ hBotAdm
  exact (h.toProfileDeltaFilterAdm.filter_at w).upward
    (Extension.fdeTop (Entity := Entity))
    (Extension.fdeBot (Entity := Entity)).negate
    hTopAdm hNegBotAdm
    (h.toProfileDeltaFilterAdm.filter_at w).top_positive
    (by
      constructor
      · intro x hx
        trivial
      · intro x hx
        exact False.elim hx)

/-- The negative support family excludes FDE top. -/
theorem bilateralProfileDeltaFilter_top_not_negative
    (M : AdmissibleSemantics World Entity)
    (h : BilateralProfileDeltaFilterAdm M) :
    ∀ w, ¬ M.base.pNeg w (Extension.fdeTop (Entity := Entity)) := by
  intro w hNegTop
  have hTopAdm := h.toProfileDeltaFilterAdm.algebra.top_admissible
  have hPosNegTop := (h.polarity w _ hTopAdm).1 hNegTop
  have hNegTopAdm := M.negate_closed _ hTopAdm
  have hBotAdm := h.toProfileDeltaFilterAdm.algebra.bot_admissible
  have hPosBot := (h.toProfileDeltaFilterAdm.filter_at w).upward
    (Extension.fdeTop (Entity := Entity)).negate
    (Extension.fdeBot (Entity := Entity))
    hNegTopAdm hBotAdm hPosNegTop
    (by
      constructor
      · intro x hx
        exact False.elim hx
      · intro x hx
        trivial)
  exact (h.toProfileDeltaFilterAdm.filter_at w).bot_not_positive hPosBot

/-- Negative support is downward closed in the FDE truth order. -/
theorem bilateralProfileDeltaFilter_negative_downward
    (M : AdmissibleSemantics World Entity)
    (h : BilateralProfileDeltaFilterAdm M) :
    ∀ w X Y,
      M.admissible X → M.admissible Y →
      ExtensionTruthLe X Y → M.base.pNeg w Y → M.base.pNeg w X := by
  intro w X Y hXAdm hYAdm hXY hNegY
  apply (h.polarity w X hXAdm).2
  have hPosNegY := (h.polarity w Y hYAdm).1 hNegY
  exact (h.toProfileDeltaFilterAdm.filter_at w).upward
    Y.negate X.negate
    (M.negate_closed Y hYAdm) (M.negate_closed X hXAdm)
    hPosNegY (extensionTruthLe_negate hXY)

/-- Negative support is closed under FDE disjunction. -/
theorem bilateralProfileDeltaFilter_negative_disj
    (M : AdmissibleSemantics World Entity)
    (h : BilateralProfileDeltaFilterAdm M) :
    ∀ w X Y,
      M.admissible X → M.admissible Y →
      M.base.pNeg w X → M.base.pNeg w Y →
      M.base.pNeg w (X.fdeDisj Y) := by
  intro w X Y hXAdm hYAdm hNegX hNegY
  have hDisjAdm := h.toProfileDeltaFilterAdm.algebra.disj_admissible X Y hXAdm hYAdm
  apply (h.polarity w (X.fdeDisj Y) hDisjAdm).2
  have hNegXAdm := M.negate_closed X hXAdm
  have hNegYAdm := M.negate_closed Y hYAdm
  have hMeetAdm := h.toProfileDeltaFilterAdm.algebra.conj_admissible
    X.negate Y.negate hNegXAdm hNegYAdm
  have hMeetPos := (h.toProfileDeltaFilterAdm.filter_at w).conj_positive
    X.negate Y.negate hNegXAdm hNegYAdm
    ((h.polarity w X hXAdm).1 hNegX)
    ((h.polarity w Y hYAdm).1 hNegY)
  exact (h.toProfileDeltaFilterAdm.filter_at w).upward
    (X.negate.fdeConj Y.negate) (X.fdeDisj Y).negate
    hMeetAdm (M.negate_closed _ hDisjAdm) hMeetPos
    (by
      constructor
      · intro x hx
        exact hx
      · intro x hx
        exact hx)

/--
Maximality is a separate ultrafilter condition. Adding it decides every
admissible extension or its FDE complement positively.
-/
structure ProfileDeltaUltrafilterAdm
    (M : AdmissibleSemantics World Entity) : Prop
    extends ProfileDeltaFilterAdm M where
  maximal : ∀ w X, M.admissible X →
    M.base.pPos w X ∨ M.base.pPos w X.negate

theorem profileDeltaUltrafilter_implies_complementDecision
    (M : AdmissibleSemantics World Entity)
    (h : ProfileDeltaUltrafilterAdm M) :
    PositiveComplementDecisionAdm M := by
  exact h.maximal

/-- With relevant consistency, ultrafilter maximality reconstructs `COMP`. -/
theorem profileDeltaUltrafilter_cons_implies_compPGAdm
    (M : AdmissibleSemantics World Entity)
    (hUltra : ProfileDeltaUltrafilterAdm M)
    (hCons : ConsGGAdm M) :
    CompPGAdm M := by
  exact complementDecision_cons_implies_compPGAdm M
    (profileDeltaUltrafilter_implies_complementDecision M hUltra) hCons

/-- With A1-R, ultrafilter maximality also reconstructs `COMP`. -/
theorem profileDeltaUltrafilter_a1R_implies_compPGAdm
    (M : AdmissibleSemantics World Entity)
    (hUltra : ProfileDeltaUltrafilterAdm M)
    (hA1R : A1RAdm M) :
    CompPGAdm M := by
  exact complementDecision_a1R_implies_compPGAdm M
    (profileDeltaUltrafilter_implies_complementDecision M hUltra) hA1R

end Goedel4PEL.GoedelScott.Fitting
