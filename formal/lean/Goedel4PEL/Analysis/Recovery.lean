import Goedel4PEL.GoedelScott.T1
import Goedel4PEL.GoedelScott.T3Collapse

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/-- Classical coherence of exemplification channels. -/
def ExClassical (M : Semantics World Entity Property) : Prop :=
  ∀ w x φ, M.exNeg w x φ ↔ ¬ M.exPos w x φ

/-- Classical coherence of positivity channels. -/
def PClassical (M : Semantics World Entity Property) : Prop :=
  ∀ w φ, M.pNeg w φ ↔ ¬ M.pPos w φ

/-- On classical positivity information, truth-only positivity reduces to positivity. -/
theorem posT_iff_pPos
    (M : Semantics World Entity Property)
    (hP : PClassical M) (w : World) (φ : Property) :
    PosT M w φ ↔ M.pPos w φ := by
  constructor
  · intro h
    exact h.1
  · intro hPos
    constructor
    · exact hPos
    · intro hNeg
      exact (hP w φ).1 hNeg hPos

/-- Classical recovery of signed necessary entailment. -/
theorem nentMinus_iff_not_nentPlus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M) (w : World) (φ ψ : Property) :
    NEntMinus M w φ ψ ↔ ¬ NEntPlus M w φ ψ := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨z, hwz, y, hyExists, hφ, hNegψ⟩
    have hψ : M.exPos z y ψ := hPlus z hwz y hyExists hφ
    exact (hEx z y ψ).1 hNegψ hψ
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro z hwz y hyExists hφ
    apply Classical.byContradiction
    intro hNoψ
    have hNegψ : M.exNeg z y ψ := (hEx z y ψ).2 hNoψ
    exact hNoMinus ⟨z, hwz, y, hyExists, hφ, hNegψ⟩

/-- Classical recovery of support-based Godlikeness. -/
theorem godMinus_iff_not_godPlus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M) (w : World) (x : Entity) :
    GodMinus M w x ↔ ¬ GodPlus M w x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨φ, hPφ, hNegφ⟩
    have hφ : M.exPos w x φ := hPlus φ hPφ
    exact (hEx w x φ).1 hNegφ hφ
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro φ hPφ
    apply Classical.byContradiction
    intro hNoφ
    have hNegφ : M.exNeg w x φ := (hEx w x φ).2 hNoφ
    exact hNoMinus ⟨φ, hPφ, hNegφ⟩

/-- Classical recovery of bilateral essence. -/
theorem essMinus_iff_not_essPlus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M) (w : World) (φ : Property) (x : Entity) :
    EssMinus M w φ x ↔ ¬ EssPlus M w φ x := by
  constructor
  · intro hMinus hPlus
    cases hMinus with
    | inl hNegφ =>
        exact (hEx w x φ).1 hNegφ hPlus.1
    | inr hWitness =>
        rcases hWitness with ⟨ψ, hψ, hNEntMinus⟩
        have hNEntPlus : NEntPlus M w φ ψ := hPlus.2 ψ hψ
        exact (nentMinus_iff_not_nentPlus M hEx w φ ψ).1 hNEntMinus hNEntPlus
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    constructor
    · apply Classical.byContradiction
      intro hNoφ
      have hNegφ : M.exNeg w x φ := (hEx w x φ).2 hNoφ
      exact hNoMinus (Or.inl hNegφ)
    · intro ψ hψ
      apply Classical.byContradiction
      intro hNoNEnt
      have hNEntMinus : NEntMinus M w φ ψ :=
        (nentMinus_iff_not_nentPlus M hEx w φ ψ).2 hNoNEnt
      exact hNoMinus (Or.inr ⟨ψ, hψ, hNEntMinus⟩)

/-- Negative support for necessary positive exemplification. -/
def BoxExistsPropNeg
    (M : Semantics World Entity Property) (w : World) (φ : Property) : Prop :=
  ∃ z, M.R w z ∧ ∀ y, M.Exists z y → M.exNeg z y φ

/-- Bilateral negative necessary existence corresponding to Gate-6 D3. -/
def NEMinus
    (M : Semantics World Entity Property) (w : World) (x : Entity) : Prop :=
  ∃ φ, EssPlus M w φ x ∧ BoxExistsPropNeg M w φ

/-- Classical recovery of necessary existence. -/
theorem neMinus_iff_not_nePlus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M) (w : World) (x : Entity) :
    NEMinus M w x ↔ ¬ NEPlus M w x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨φ, hEss, z, hwz, hAllNeg⟩
    rcases hPlus φ hEss z hwz with ⟨y, hyExists, hPosφ⟩
    have hNegφ : M.exNeg z y φ := hAllNeg y hyExists
    exact (hEx z y φ).1 hNegφ hPosφ
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro φ hEss z hwz
    apply Classical.byContradiction
    intro hNoWitness
    have hAllNeg : ∀ y, M.Exists z y → M.exNeg z y φ := by
      intro y hyExists
      have hNoPos : ¬ M.exPos z y φ := by
        intro hPos
        exact hNoWitness ⟨y, hyExists, hPos⟩
      exact (hEx z y φ).2 hNoPos
    exact hNoMinus ⟨φ, hEss, z, hwz, hAllNeg⟩

end Goedel4PEL.GoedelScott
