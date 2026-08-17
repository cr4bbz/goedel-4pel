import Goedel4PEL.GoedelScott.FittingAdmissibleNecessaryExistence

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/--
Consistency is only needed when completeness classifies a currently possessed
admissible extension negatively. Positively classified gluts are not ruled out
by this condition itself.
-/
def NegClassConsistencyAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w x (Y : Extension Entity),
    M.admissible Y → GodPlusAdm M w x → Y.pos x →
    M.base.pNeg w Y → ¬ Y.neg x

/-- The original relevant consistency condition implies the targeted one. -/
theorem consGGAdm_implies_negClassConsistencyAdm
    (M : AdmissibleSemantics World Entity)
    (hCons : ConsGGAdm M) :
    NegClassConsistencyAdm M := by
  intro w x Y hYAdm hGod hYPos _hNeg
  exact hCons w x Y hYAdm hGod hYPos

/--
Targeted Fitting recovery package: positivity completeness plus consistency only
on the negatively classified branch.
-/
def RegGNegClassAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  CompPGAdm M ∧ NegClassConsistencyAdm M

/-- The previous admissible recovery package implies the targeted package. -/
theorem regGAdm_implies_regGNegClassAdm
    (M : AdmissibleSemantics World Entity)
    (hReg : RegGAdm M) :
    RegGNegClassAdm M := by
  exact ⟨hReg.1, consGGAdm_implies_negClassConsistencyAdm M hReg.2⟩

/--
Admissible Fitting essence recovery with consistency restricted to the branch
where the possessed extension is negatively classified.

This theorem permits positively classified glutty extensions at Godlike
witnesses; the stronger `ConsGGAdm` premise is not used.
-/
theorem god_has_currentExtension_essence_negClass
    (M : AdmissibleSemantics World Entity)
    (hGAdm : GAdmissible M)
    (hReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGNegClassAdm M) :
    ∀ w x, GodPlusAdm M w x →
      EssPlusAdm M w (extensionAt M.base.G w) x := by
  intro w x hGodX
  constructor
  · exact hGAdm w
  constructor
  · exact (hReal w x).2 hGodX
  · intro Y hYAdm hYx
    have hPY : M.base.pPos w Y := by
      rcases hReg.1 w x Y hYAdm hGodX hYx with hPos | hNeg
      · exact hPos
      · have hNotYAdm : M.admissible Y.negate := M.negate_closed Y hYAdm
        have hPNotY : M.base.pPos w Y.negate := hA1L w Y hYAdm hNeg
        have hNotYx : Y.negate.pos x := hGodX Y.negate hNotYAdm hPNotY
        have hNoNegY : ¬ Y.neg x :=
          hReg.2 w x Y hYAdm hGodX hYx hNeg
        exact False.elim (hNoNegY hNotYx)
    intro z hwz y hyExists hGy
    have hGodY : GodPlusAdm M w y := (hReal w y).1 hGy
    exact hGodY Y hYAdm hPY

/--
A possibilist admissible-domain Godlike individual yields de-re necessary
actual exemplification under the targeted recovery package.
-/
theorem possibilistGodAdm_implies_necessaryCurrent_negClass
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGNegClassAdm M)
    (hNEAdm : NEAdmissible M NE)
    (hNEReal : NERealizationAdm M NE)
    (hA5 : A5PlusAdm M NE) :
    ∀ w, GodPossibilistAtAdm M w → NecessaryCurrentGodExtensionAdm M w := by
  intro w hGod
  rcases hGod with ⟨x, hGodX⟩
  have hNEEx : IntensionExPos NE w x :=
    god_has_ne_admissible M NE hNEAdm hA5 w x hGodX
  have hNE : NEPlusAdm M w x := (hNEReal w x).1 hNEEx
  have hEss : EssPlusAdm M w (extensionAt M.base.G w) x :=
    god_has_currentExtension_essence_negClass
      M hGAdm hGReal hA1L hReg w x hGodX
  exact hNE (extensionAt M.base.G w) hEss

/-- Targeted de-re possibility-to-necessity theorem. -/
theorem possibleCurrentAdm_implies_necessary_negClass
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGNegClassAdm M)
    (hNEAdm : NEAdmissible M NE)
    (hNEReal : NERealizationAdm M NE)
    (hA5 : A5PlusAdm M NE) :
    ∀ w, PossibleCurrentGodExtensionAdm M w →
      NecessaryCurrentGodExtensionAdm M w := by
  intro w hPossible
  have hGod : GodPossibilistAtAdm M w :=
    possibleCurrentAdm_implies_possibilistGod M hGReal w hPossible
  exact possibilistGodAdm_implies_necessaryCurrent_negClass
    M NE hGAdm hGReal hA1L hReg hNEAdm hNEReal hA5 w hGod

/-- Positive membership in G persists from the source to the target of R. -/
def GPosPersistsAlongRAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w z, M.base.R w z → ∀ x,
    (extensionAt M.base.G w).pos x →
    (extensionAt M.base.G z).pos x

/-- Positive membership in G reflects from the target back to the source of R. -/
def GPosReflectsAlongRAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w z, M.base.R w z → ∀ x,
    (extensionAt M.base.G z).pos x →
    (extensionAt M.base.G w).pos x

/-- Only the positive G extension is stable along accessibility edges. -/
def GPosStableAlongRAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  GPosPersistsAlongRAdm M ∧ GPosReflectsAlongRAdm M

/-- Full bilateral extension stability implies positive-only stability. -/
theorem gExtensionStableAlongRAdm_implies_gPosStable
    (M : AdmissibleSemantics World Entity)
    (hStable : GExtensionStableAlongRAdm M) :
    GPosStableAlongRAdm M := by
  constructor
  · intro w z hwz x hGw
    exact ((hStable w z hwz x).1).1 hGw
  · intro w z hwz x hGz
    exact ((hStable w z hwz x).1).2 hGz

/-- Positive reflection alone converts de-dicto possibility to de-re possibility. -/
theorem possibleGodDeDictoAdm_implies_possibleCurrent_posReflects
    (M : AdmissibleSemantics World Entity)
    (hGReal : GRealizationAdm M)
    (hReflect : GPosReflectsAlongRAdm M) :
    ∀ w, PossibleGodDeDictoAdm M w → PossibleCurrentGodExtensionAdm M w := by
  intro w hPossible
  rcases hPossible with ⟨z, hwz, x, hxExists, hGodZ⟩
  have hGz : (extensionAt M.base.G z).pos x := (hGReal z x).2 hGodZ
  have hGw : (extensionAt M.base.G w).pos x := hReflect w z hwz x hGz
  exact ⟨z, hwz, x, hxExists, hGw⟩

/-- Positive persistence alone converts de-re necessity to de-dicto necessity. -/
theorem necessaryCurrentAdm_implies_necessaryGodDeDicto_posPersists
    (M : AdmissibleSemantics World Entity)
    (hGReal : GRealizationAdm M)
    (hPersist : GPosPersistsAlongRAdm M) :
    ∀ w, NecessaryCurrentGodExtensionAdm M w → NecessaryGodDeDictoAdm M w := by
  intro w hNecessary z hwz
  rcases hNecessary z hwz with ⟨x, hxExists, hGw⟩
  have hGz : (extensionAt M.base.G z).pos x := hPersist w z hwz x hGw
  have hGodZ : GodPlusAdm M z x := (hGReal z x).1 hGz
  exact ⟨x, hxExists, hGodZ⟩

/--
Minimized positive de-dicto Fitting theorem.

Compared with the previous theorem, this uses consistency only on negatively
classified possessed extensions and stability only of the positive G channel.
No negative-extension stability is required.
-/
theorem possibleGodDeDictoAdm_implies_necessary_minimized
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGNegClassAdm M)
    (hNEAdm : NEAdmissible M NE)
    (hNEReal : NERealizationAdm M NE)
    (hA5 : A5PlusAdm M NE)
    (hPosStable : GPosStableAlongRAdm M) :
    ∀ w, PossibleGodDeDictoAdm M w → NecessaryGodDeDictoAdm M w := by
  intro w hPossible
  have hCurrentPossible : PossibleCurrentGodExtensionAdm M w :=
    possibleGodDeDictoAdm_implies_possibleCurrent_posReflects
      M hGReal hPosStable.2 w hPossible
  have hCurrentNecessary : NecessaryCurrentGodExtensionAdm M w :=
    possibleCurrentAdm_implies_necessary_negClass
      M NE hGAdm hGReal hA1L hReg hNEAdm hNEReal hA5 w hCurrentPossible
  exact necessaryCurrentAdm_implies_necessaryGodDeDicto_posPersists
    M hGReal hPosStable.1 w hCurrentNecessary

end Goedel4PEL.GoedelScott.Fitting
