import Goedel4PEL.GoedelScott.FittingSemantics

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- Classical coherence for every rigid bilateral extension. -/
def ExtensionClassical : Prop :=
  ∀ (X : Extension Entity) (x : Entity), X.neg x ↔ ¬ X.pos x

/-- Explicit negative evidence against Fitting Godlikeness. -/
def GodMinus
    (M : Semantics World Entity) (w : World) (x : Entity) : Prop :=
  ∃ X : Extension Entity, M.pPos w X ∧ X.neg x

/-- Classical recovery of extensional Fitting entailment. -/
theorem entailMinus_iff_not_entailPlus
    (M : Semantics World Entity)
    (hExt : ExtensionClassical (Entity := Entity))
    (w : World) (X Y : Extension Entity) :
    EntailMinus M w X Y ↔ ¬ EntailPlus M w X Y := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨z, hwz, x, hxExists, hX, hYNeg⟩
    have hYPos : Y.pos x := hPlus z hwz x hxExists hX
    exact (hExt Y x).1 hYNeg hYPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro z hwz x hxExists hX
    apply Classical.byContradiction
    intro hNoYPos
    have hYNeg : Y.neg x := (hExt Y x).2 hNoYPos
    exact hNoMinus ⟨z, hwz, x, hxExists, hX, hYNeg⟩

/-- Classical recovery of Fitting Godlikeness. -/
theorem godMinus_iff_not_godPlus
    (M : Semantics World Entity)
    (hExt : ExtensionClassical (Entity := Entity))
    (w : World) (x : Entity) :
    GodMinus M w x ↔ ¬ GodPlus M w x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨X, hPX, hXNeg⟩
    have hXPos : X.pos x := hPlus X hPX
    exact (hExt X x).1 hXNeg hXPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro X hPX
    apply Classical.byContradiction
    intro hNoXPos
    have hXNeg : X.neg x := (hExt X x).2 hNoXPos
    exact hNoMinus ⟨X, hPX, hXNeg⟩

/-- Classical recovery of positive/negative Fitting essence. -/
theorem essMinus_iff_not_essPlus
    (M : Semantics World Entity)
    (hExt : ExtensionClassical (Entity := Entity))
    (w : World) (X : Extension Entity) (x : Entity) :
    EssMinus M w X x ↔ ¬ EssPlus M w X x := by
  constructor
  · intro hMinus hPlus
    cases hMinus with
    | inl hXNeg =>
        exact (hExt X x).1 hXNeg hPlus.1
    | inr hBad =>
        rcases hBad with ⟨Y, hYPos, hEntMinus⟩
        have hEntPlus : EntailPlus M w X Y := hPlus.2 Y hYPos
        exact (entailMinus_iff_not_entailPlus M hExt w X Y).1 hEntMinus hEntPlus
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    constructor
    · apply Classical.byContradiction
      intro hNoXPos
      have hXNeg : X.neg x := (hExt X x).2 hNoXPos
      exact hNoMinus (Or.inl hXNeg)
    · intro Y hYPos
      apply Classical.byContradiction
      intro hNoEnt
      have hEntMinus : EntailMinus M w X Y :=
        (entailMinus_iff_not_entailPlus M hExt w X Y).2 hNoEnt
      exact hNoMinus (Or.inr ⟨Y, hYPos, hEntMinus⟩)

/-- Classical recovery of necessary actual exemplification for one extension. -/
theorem boxExistsMinus_iff_not_boxExistsPlus
    (M : Semantics World Entity)
    (hExt : ExtensionClassical (Entity := Entity))
    (w : World) (X : Extension Entity) :
    BoxExistsMinus M w X ↔ ¬ BoxExistsPlus M w X := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨z, hwz, hAllNeg⟩
    rcases hPlus z hwz with ⟨x, hxExists, hXPos⟩
    have hXNeg : X.neg x := hAllNeg x hxExists
    exact (hExt X x).1 hXNeg hXPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro z hwz
    apply Classical.byContradiction
    intro hNoWitness
    have hAllNeg : ∀ x, M.Exists z x → X.neg x := by
      intro x hxExists
      have hNoXPos : ¬ X.pos x := by
        intro hXPos
        exact hNoWitness ⟨x, hxExists, hXPos⟩
      exact (hExt X x).2 hNoXPos
    exact hNoMinus ⟨z, hwz, hAllNeg⟩

/-- Classical recovery of Fitting necessary existence. -/
theorem neMinus_iff_not_nePlus
    (M : Semantics World Entity)
    (hExt : ExtensionClassical (Entity := Entity))
    (w : World) (x : Entity) :
    NEMinus M w x ↔ ¬ NEPlus M w x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨X, hEss, hBoxMinus⟩
    have hBoxPlus : BoxExistsPlus M w X := hPlus X hEss
    exact (boxExistsMinus_iff_not_boxExistsPlus M hExt w X).1 hBoxMinus hBoxPlus
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro X hEss
    apply Classical.byContradiction
    intro hNoBox
    have hBoxMinus : BoxExistsMinus M w X :=
      (boxExistsMinus_iff_not_boxExistsPlus M hExt w X).2 hNoBox
    exact hNoMinus ⟨X, hEss, hBoxMinus⟩

end Goedel4PEL.GoedelScott.Fitting
