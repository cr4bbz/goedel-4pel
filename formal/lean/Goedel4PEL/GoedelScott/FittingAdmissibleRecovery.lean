import Goedel4PEL.GoedelScott.FittingAdmissible

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- Classical recovery of extensional entailment inside the admissible domain. -/
theorem entailMinusAdm_iff_not_entailPlus
    (M : AdmissibleSemantics World Entity)
    (hExt : ExtensionClassicalAdm M)
    (w : World) (X Y : Extension Entity)
    (_hXAdm : M.admissible X) (hYAdm : M.admissible Y) :
    EntailMinus M.base w X Y ↔ ¬ EntailPlus M.base w X Y := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨z, hwz, x, hxExists, hXPos, hYNeg⟩
    have hYPos : Y.pos x := hPlus z hwz x hxExists hXPos
    exact (hExt Y hYAdm x).1 hYNeg hYPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro z hwz x hxExists hXPos
    apply Classical.byContradiction
    intro hNoYPos
    have hYNeg : Y.neg x := (hExt Y hYAdm x).2 hNoYPos
    exact hNoMinus ⟨z, hwz, x, hxExists, hXPos, hYNeg⟩

/-- Classical recovery of necessary actual exemplification in the admissible domain. -/
theorem boxExistsMinusAdm_iff_not_boxExistsPlus
    (M : AdmissibleSemantics World Entity)
    (hExt : ExtensionClassicalAdm M)
    (w : World) (X : Extension Entity)
    (hXAdm : M.admissible X) :
    BoxExistsMinus M.base w X ↔ ¬ BoxExistsPlus M.base w X := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨z, hwz, hAllNeg⟩
    rcases hPlus z hwz with ⟨x, hxExists, hXPos⟩
    have hXNeg : X.neg x := hAllNeg x hxExists
    exact (hExt X hXAdm x).1 hXNeg hXPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro z hwz
    apply Classical.byContradiction
    intro hNoWitness
    have hAllNeg : ∀ x, M.base.Exists z x → X.neg x := by
      intro x hxExists
      have hNoXPos : ¬ X.pos x := by
        intro hXPos
        exact hNoWitness ⟨x, hxExists, hXPos⟩
      exact (hExt X hXAdm x).2 hNoXPos
    exact hNoMinus ⟨z, hwz, hAllNeg⟩

end Goedel4PEL.GoedelScott.Fitting
