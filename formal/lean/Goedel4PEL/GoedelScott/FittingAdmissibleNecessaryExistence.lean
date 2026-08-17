import Goedel4PEL.GoedelScott.FittingAdmissible

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- The distinguished NE intension realizes admissible-domain positive NE. -/
def NERealizationAdm
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity) : Prop :=
  ∀ w x, IntensionExPos NE w x ↔ NEPlusAdm M w x

/-- Every current extension of NE belongs to the selected extensional domain. -/
def NEAdmissible
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity) : Prop :=
  ∀ w, M.admissible (extensionAt NE w)

/-- Positive Fitting A5 over the selected extensional domain. -/
def A5PlusAdm
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity) : Prop :=
  ∀ w, M.base.pPos w (extensionAt NE w)

/-- Possibilist positive admissible-domain Godlikeness at one world. -/
def GodPossibilistAtAdm
    (M : AdmissibleSemantics World Entity) (w : World) : Prop :=
  ∃ x, GodPlusAdm M w x

/-- De-re possibility of the frozen current admissible G extension. -/
def PossibleCurrentGodExtensionAdm
    (M : AdmissibleSemantics World Entity) (w : World) : Prop :=
  ∃ z, M.base.R w z ∧
    ∃ x, M.base.Exists z x ∧ (extensionAt M.base.G w).pos x

/-- De-re necessity of the frozen current admissible G extension. -/
def NecessaryCurrentGodExtensionAdm
    (M : AdmissibleSemantics World Entity) (w : World) : Prop :=
  BoxExistsPlus M.base w (extensionAt M.base.G w)

/-- Positive de-dicto possible actual Godlikeness. -/
def PossibleGodDeDictoAdm
    (M : AdmissibleSemantics World Entity) (w : World) : Prop :=
  ∃ z, M.base.R w z ∧
    ∃ x, M.base.Exists z x ∧ GodPlusAdm M z x

/-- Positive de-dicto necessary actual Godlikeness. -/
def NecessaryGodDeDictoAdm
    (M : AdmissibleSemantics World Entity) (w : World) : Prop :=
  ∀ z, M.base.R w z →
    ∃ x, M.base.Exists z x ∧ GodPlusAdm M z x

/-- Stability of the distinguished G extension along accessibility edges. -/
def GExtensionStableAlongRAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w z, M.base.R w z →
    ExtensionEquivalent (extensionAt M.base.G w) (extensionAt M.base.G z)

/-- Every admissible-domain Godlike individual has the realized NE property. -/
theorem god_has_ne_admissible
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hNEAdm : NEAdmissible M NE)
    (hA5 : A5PlusAdm M NE) :
    ∀ w x, GodPlusAdm M w x → IntensionExPos NE w x := by
  intro w x hGodX
  exact hGodX (extensionAt NE w) (hNEAdm w) (hA5 w)

/--
A possibilist admissible-domain Godlike individual yields de-re necessary
actual exemplification of the current G extension.

No frame property and no positivity-rigidity premise is used.
-/
theorem possibilistGodAdm_implies_necessaryCurrent
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGAdm M)
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
    god_has_currentExtension_essence_admissible
      M hGAdm hGReal hA1L hReg w x hGodX
  exact hNE (extensionAt M.base.G w) hEss

/-- De-re possibility yields current-world possibilist Godlikeness. -/
theorem possibleCurrentAdm_implies_possibilistGod
    (M : AdmissibleSemantics World Entity)
    (hGReal : GRealizationAdm M) :
    ∀ w, PossibleCurrentGodExtensionAdm M w → GodPossibilistAtAdm M w := by
  intro w hPossible
  rcases hPossible with ⟨z, hwz, x, hxExists, hxG⟩
  exact ⟨x, (hGReal w x).1 hxG⟩

/--
Non-vacuous admissible-domain de-re K-style theorem.

No reflexivity, symmetry, transitivity, seriality, or positivity-rigidity
premise is required.
-/
theorem possibleCurrentAdm_implies_necessary
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGAdm M)
    (hNEAdm : NEAdmissible M NE)
    (hNEReal : NERealizationAdm M NE)
    (hA5 : A5PlusAdm M NE) :
    ∀ w, PossibleCurrentGodExtensionAdm M w →
      NecessaryCurrentGodExtensionAdm M w := by
  intro w hPossible
  have hGod : GodPossibilistAtAdm M w :=
    possibleCurrentAdm_implies_possibilistGod M hGReal w hPossible
  exact possibilistGodAdm_implies_necessaryCurrent
    M NE hGAdm hGReal hA1L hReg hNEAdm hNEReal hA5 w hGod

/-- With G-extension stability, de-dicto possibility yields de-re possibility. -/
theorem possibleGodDeDictoAdm_implies_possibleCurrent
    (M : AdmissibleSemantics World Entity)
    (hGReal : GRealizationAdm M)
    (hStable : GExtensionStableAlongRAdm M) :
    ∀ w, PossibleGodDeDictoAdm M w → PossibleCurrentGodExtensionAdm M w := by
  intro w hPossible
  rcases hPossible with ⟨z, hwz, x, hxExists, hGodZ⟩
  have hGz : (extensionAt M.base.G z).pos x := (hGReal z x).2 hGodZ
  have hGw : (extensionAt M.base.G w).pos x :=
    ((hStable w z hwz x).1).2 hGz
  exact ⟨z, hwz, x, hxExists, hGw⟩

/-- With G-extension stability, de-re necessity yields de-dicto necessity. -/
theorem necessaryCurrentAdm_implies_necessaryGodDeDicto
    (M : AdmissibleSemantics World Entity)
    (hGReal : GRealizationAdm M)
    (hStable : GExtensionStableAlongRAdm M) :
    ∀ w, NecessaryCurrentGodExtensionAdm M w → NecessaryGodDeDictoAdm M w := by
  intro w hNecessary z hwz
  rcases hNecessary z hwz with ⟨x, hxExists, hGw⟩
  have hGz : (extensionAt M.base.G z).pos x :=
    ((hStable w z hwz x).1).1 hGw
  have hGodZ : GodPlusAdm M z x := (hGReal z x).1 hGz
  exact ⟨x, hxExists, hGodZ⟩

/--
Admissible-domain de-dicto possibility-to-necessity theorem.

The extra bridge is extension stability, not an S4/S5 frame condition.
-/
theorem possibleGodDeDictoAdm_implies_necessary
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGAdm M)
    (hNEAdm : NEAdmissible M NE)
    (hNEReal : NERealizationAdm M NE)
    (hA5 : A5PlusAdm M NE)
    (hStable : GExtensionStableAlongRAdm M) :
    ∀ w, PossibleGodDeDictoAdm M w → NecessaryGodDeDictoAdm M w := by
  intro w hPossible
  have hCurrentPossible : PossibleCurrentGodExtensionAdm M w :=
    possibleGodDeDictoAdm_implies_possibleCurrent M hGReal hStable w hPossible
  have hCurrentNecessary : NecessaryCurrentGodExtensionAdm M w :=
    possibleCurrentAdm_implies_necessary
      M NE hGAdm hGReal hA1L hReg hNEAdm hNEReal hA5 w hCurrentPossible
  exact necessaryCurrentAdm_implies_necessaryGodDeDicto
    M hGReal hStable w hCurrentNecessary

end Goedel4PEL.GoedelScott.Fitting
