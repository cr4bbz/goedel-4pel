import Goedel4PEL.GoedelScott.T1
import Goedel4PEL.GoedelScott.T2
import Goedel4PEL.GoedelScott.ScottFrames
import Goedel4PEL.GoedelScott.FittingAdmissible
import Goedel4PEL.GoedelScott.FittingActualistQuotient
import Goedel4PEL.GoedelScott.FittingQuotientDeltaFilter
import Goedel4PEL.FourValued.PairedNeighborhood

/-!
# Publication correspondence gate

These examples restate the theorem-level claims used in the manuscript with
their advertised premise lists.  They are deliberately compiled as part of
the library root: a renamed theorem, changed premise, or changed conclusion
must be repaired here before the formal result can continue to support the
paper claim.
-/

namespace Goedel4PEL.PublicationCorrespondence

universe u v e f

open Goedel4PEL
open Goedel4PEL.GoedelScott

variable {World : Type u} {Entity : Type v} {Property : Type e}

/-- Appendix A: A1-R plus A2+ yields truth-only T1. -/
example (M : Semantics World Entity Property)
    (hA1R : A1R M) (hA2 : A2Plus M) :
    T1T M :=
  t1T_of_a1R_a2Plus M hA1R hA2

/-- Appendix A: the advertised Scott T2 recovery package. -/
example (M : Semantics World Entity Property)
    (hNeg : NegExemplification M)
    (hGSup : GSup M)
    (hA1L : A1L M)
    (hRPlus : RPlus M)
    (hRegG : RegG M) :
    T2Plus M :=
  t2Plus_of_regG M hNeg hGSup hA1L hRPlus hRegG

/-- Appendix A: symmetry-only positive T3 recovery. -/
example (M : Semantics World Entity Property) (NE : Property)
    (hSym : Goedel4PEL.Modal.Symmetric M.R)
    (hPossible : PossibleGod M)
    (hT2 : T2Plus M)
    (hA5 : A5Plus M NE)
    (hNESup : NESup M NE)
    (hGSup : GSup M) :
    T3Plus M :=
  t3Plus_of_possible_t2_a5_symmetric
    M NE hSym hPossible hT2 hA5 hNESup hGSup

namespace Fitting

open Goedel4PEL.GoedelScott.Fitting

variable {World : Type u} {Entity : Type v}

/-- Appendix A: admissible-domain Fitting essence recovery. -/
example (M : AdmissibleSemantics World Entity)
    (hGAdm : GAdmissible M)
    (hReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGAdm M) :
    ∀ w x, GodPlusAdm M w x →
      EssPlusAdm M w (extensionAt M.base.G w) x :=
  god_has_currentExtension_essence_admissible
    M hGAdm hReal hA1L hReg

/-- Appendix A: actualist entailment on the explicit profile quotient. -/
example (M : AdmissibleSemantics World Entity)
    (hExists : ProfileExistenceSaturatedAdm M)
    (w : World) (X Y : Extension (ProfileQuotient M w)) :
    ProfileQuotientEntailPlus M hExists w X Y ↔
      EntailPlus M.base w
        (X.fromProfileQuotient M w) (Y.fromProfileQuotient M w) :=
  profileQuotientEntailPlus_iff_pullback M hExists w X Y

/-- Appendix A: every inhabited quotient carries a non-deciding prime filter. -/
example (M : AdmissibleSemantics World Entity)
    (w : World) (x : Entity) :
    ∃ F : Extension (ProfileQuotient M w) → Prop,
      PositivePrimeDeltaFilter F ∧ ¬ PositiveComplementDeciding F :=
  profileQuotient_has_nondeciding_primeDeltaFilter M w x

end Fitting

/-- Appendix A: paired-neighborhood modal duality. -/
example {Formula : Type f}
    (F : PairedNeighborhood.Frame World)
    (Pos Neg : World → Formula → Prop)
    (neg : Formula → Formula)
    (hneg : PairedNeighborhood.NegationSwaps Pos Neg neg)
    (w : World) (φ : Formula) :
    PairedNeighborhood.DiamondPlus F Pos w φ ↔
      PairedNeighborhood.BoxNeg F Neg w (neg φ) :=
  PairedNeighborhood.diamondPlus_iff_boxNeg_neg
    F Pos Neg neg hneg w φ

end Goedel4PEL.PublicationCorrespondence
