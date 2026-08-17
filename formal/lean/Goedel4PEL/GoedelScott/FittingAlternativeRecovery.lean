import Goedel4PEL.GoedelScott.FittingMinimality

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/--
Admissible-property indiscernibility among positive Fitting-Godlike individuals.

This condition is deliberately orthogonal to positivity classification. It says
that admissible rigid extensions cannot distinguish two individuals that are
both positive Fitting-Godlike at the same world.
-/
def GodlikeIndiscernibilityAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w x y (Y : Extension Entity),
    M.admissible Y →
    GodPlusAdm M w x →
    GodPlusAdm M w y →
    (Y.pos x ↔ Y.pos y)

/--
Alternative admissible Fitting essence recovery.

Unlike the positivity-classification route, this theorem uses no A1 direction,
no positivity completeness, and no exemplification-consistency premise. The
current G extension contains exactly the positive Godlike individuals at the
source world, and admissible-property indiscernibility makes every admissible
property of one such individual hold of all of them.
-/
theorem god_has_currentExtension_essence_indiscernible
    (M : AdmissibleSemantics World Entity)
    (hGAdm : GAdmissible M)
    (hReal : GRealizationAdm M)
    (hInd : GodlikeIndiscernibilityAdm M) :
    ∀ w x, GodPlusAdm M w x →
      EssPlusAdm M w (extensionAt M.base.G w) x := by
  intro w x hGodX
  constructor
  · exact hGAdm w
  constructor
  · exact (hReal w x).2 hGodX
  · intro Y hYAdm hYx
    intro z hwz y hyExists hGy
    have hGodY : GodPlusAdm M w y := (hReal w y).1 hGy
    exact (hInd w x y Y hYAdm hGodX hGodY).1 hYx

/--
A possibilist Godlike individual yields de-re necessary actual exemplification
through the indiscernibility route, without `COMP_P^G`, A1, or consistency.
-/
theorem possibilistGodAdm_implies_necessaryCurrent_indiscernible
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hInd : GodlikeIndiscernibilityAdm M)
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
    god_has_currentExtension_essence_indiscernible M hGAdm hGReal hInd w x hGodX
  exact hNE (extensionAt M.base.G w) hEss

/-- Frame-free de-re possibility-to-necessity via Godlike indiscernibility. -/
theorem possibleCurrentAdm_implies_necessary_indiscernible
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hInd : GodlikeIndiscernibilityAdm M)
    (hNEAdm : NEAdmissible M NE)
    (hNEReal : NERealizationAdm M NE)
    (hA5 : A5PlusAdm M NE) :
    ∀ w, PossibleCurrentGodExtensionAdm M w →
      NecessaryCurrentGodExtensionAdm M w := by
  intro w hPossible
  have hGod : GodPossibilistAtAdm M w :=
    possibleCurrentAdm_implies_possibilistGod M hGReal w hPossible
  exact possibilistGodAdm_implies_necessaryCurrent_indiscernible
    M NE hGAdm hGReal hInd hNEAdm hNEReal hA5 w hGod

/--
Positive de-dicto possibility-to-necessity through the alternative recovery
route. Only positive G-extension stability is needed for the de-re/de-dicto
bridge; positivity completeness remains absent.
-/
theorem possibleGodDeDictoAdm_implies_necessary_indiscernible
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hInd : GodlikeIndiscernibilityAdm M)
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
    possibleCurrentAdm_implies_necessary_indiscernible
      M NE hGAdm hGReal hInd hNEAdm hNEReal hA5 w hCurrentPossible
  exact necessaryCurrentAdm_implies_necessaryGodDeDicto_posPersists
    M hGReal hPosStable.1 w hCurrentNecessary

end Goedel4PEL.GoedelScott.Fitting
