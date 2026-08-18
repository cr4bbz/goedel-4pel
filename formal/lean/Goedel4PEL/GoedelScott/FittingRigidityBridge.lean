import Goedel4PEL.FourValued.Modal
import Goedel4PEL.GoedelScott.FittingMinimality

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/--
Positive rigidity restricted to the selected admissible extension domain.

The Fitting definitions of admissible-domain Godlikeness quantify only over
extensions selected by `M.admissible`, so no rigidity premise for extensions
outside that domain is needed by the bridge below. This is intentionally a
Fitting-typed interface rather than an identification with the Scott theory's
generic property type.
-/
def RPlusAdm (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w (X : Extension Entity),
    M.admissible X →
    M.base.pPos w X →
    ∀ z, M.base.R w z → M.base.pPos z X

/--
Forward rigidity of positive admissible extensions reflects positive
Godlikeness membership from an accessible target back to the source.

If `x` is Godlike at `z`, every extension positive at `w` remains positive at
`z`; target Godlikeness therefore puts `x` in each such extension, which is
exactly source Godlikeness.
-/
theorem rPlusAdm_implies_gPosReflects
    (M : AdmissibleSemantics World Entity)
    (hGReal : GRealizationAdm M)
    (hRPlus : RPlusAdm M) :
    GPosReflectsAlongRAdm M := by
  intro w z hwz x hGz
  have hGodZ : GodPlusAdm M z x := (hGReal z x).1 hGz
  have hGodW : GodPlusAdm M w x := by
    intro X hXAdm hPXw
    have hPXz : M.base.pPos z X := hRPlus w X hXAdm hPXw z hwz
    exact hGodZ X hXAdm hPXz
  exact (hGReal w x).2 hGodW

/--
On a symmetric frame, the same forward rigidity premise also yields positive
G-membership persistence. Symmetry reverses the edge, allowing positivity at
the target to be transported back to the source where source Godlikeness can
consume it.
-/
theorem rPlusAdm_symmetric_implies_gPosPersists
    (M : AdmissibleSemantics World Entity)
    (hGReal : GRealizationAdm M)
    (hRPlus : RPlusAdm M)
    (hSym : Goedel4PEL.Modal.Symmetric M.base.R) :
    GPosPersistsAlongRAdm M := by
  intro w z hwz x hGw
  have hGodW : GodPlusAdm M w x := (hGReal w x).1 hGw
  have hzw : M.base.R z w := hSym hwz
  have hGodZ : GodPlusAdm M z x := by
    intro X hXAdm hPXz
    have hPXw : M.base.pPos w X := hRPlus z X hXAdm hPXz w hzw
    exact hGodW X hXAdm hPXw
  exact (hGReal z x).2 hGodZ

/--
Admissible positive rigidity plus symmetry derives the complete positive-only
G-stability interface used by the minimized de-dicto theorem.
-/
theorem rPlusAdm_symmetric_implies_gPosStable
    (M : AdmissibleSemantics World Entity)
    (hGReal : GRealizationAdm M)
    (hRPlus : RPlusAdm M)
    (hSym : Goedel4PEL.Modal.Symmetric M.base.R) :
    GPosStableAlongRAdm M := by
  constructor
  · exact rPlusAdm_symmetric_implies_gPosPersists M hGReal hRPlus hSym
  · exact rPlusAdm_implies_gPosReflects M hGReal hRPlus

/--
Derived-rigidity version of the minimized positive de-dicto Fitting theorem.

The earlier result is frame-free because it assumes `GPosStableAlongRAdm`
directly. If that stability is instead derived from positivity rigidity,
symmetry re-enters precisely for the persistence half of the bridge; neither
reflexivity nor transitivity is used.
-/
theorem possibleGodDeDictoAdm_implies_necessary_rPlus_symmetric
    (M : AdmissibleSemantics World Entity)
    (NE : Intension World Entity)
    (hGAdm : GAdmissible M)
    (hGReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGNegClassAdm M)
    (hNEAdm : NEAdmissible M NE)
    (hNEReal : NERealizationAdm M NE)
    (hA5 : A5PlusAdm M NE)
    (hRPlus : RPlusAdm M)
    (hSym : Goedel4PEL.Modal.Symmetric M.base.R) :
    ∀ w, PossibleGodDeDictoAdm M w → NecessaryGodDeDictoAdm M w := by
  exact possibleGodDeDictoAdm_implies_necessary_minimized
    M NE hGAdm hGReal hA1L hReg hNEAdm hNEReal hA5
      (rPlusAdm_symmetric_implies_gPosStable M hGReal hRPlus hSym)

end Goedel4PEL.GoedelScott.Fitting
