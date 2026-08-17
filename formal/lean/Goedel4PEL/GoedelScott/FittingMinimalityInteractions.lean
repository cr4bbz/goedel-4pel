import Goedel4PEL.GoedelScott.FittingMinimality

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/--
If A1-R is restored, the targeted negative-classification consistency condition
plus positivity completeness recovers full relevant exemplification consistency.

Thus the weakening in `RegGNegClassAdm` is genuine for the A1-L-only recovery
route, but collapses back to `ConsGGAdm` when the right A1 information-flow
channel is also assumed.
-/
theorem a1R_regGNegClassAdm_implies_consGGAdm
    (M : AdmissibleSemantics World Entity)
    (hA1R : A1RAdm M)
    (hReg : RegGNegClassAdm M) :
    ConsGGAdm M := by
  intro w x Y hYAdm hGod hYPos hYNeg
  rcases hReg.1 w x Y hYAdm hGod hYPos with hPos | hNeg
  · have hNotYAdm : M.admissible Y.negate := M.negate_closed Y hYAdm
    have hPNotYNeg : M.base.pNeg w Y.negate := by
      apply hA1R w Y.negate hNotYAdm
      simpa using hPos
    have hNotYPos : Y.negate.pos x := hYNeg
    have hNotYNeg : Y.negate.neg x := hYPos
    have hConsNotY : ¬ Y.negate.neg x :=
      hReg.2 w x Y.negate hNotYAdm hGod hNotYPos hPNotYNeg
    exact hConsNotY hNotYNeg
  · have hConsY : ¬ Y.neg x :=
      hReg.2 w x Y hYAdm hGod hYPos hNeg
    exact hConsY hYNeg

/-- Under A1-R, the targeted recovery package reconstructs the old package. -/
theorem a1R_regGNegClassAdm_implies_regGAdm
    (M : AdmissibleSemantics World Entity)
    (hA1R : A1RAdm M)
    (hReg : RegGNegClassAdm M) :
    RegGAdm M := by
  exact ⟨hReg.1, a1R_regGNegClassAdm_implies_consGGAdm M hA1R hReg⟩

end Goedel4PEL.GoedelScott.Fitting
