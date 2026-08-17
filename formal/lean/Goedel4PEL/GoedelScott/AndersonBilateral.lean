import Goedel4PEL.GoedelScott.AndersonInterfaces
import Goedel4PEL.Analysis.Recovery

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/-- Negative support for necessary exemplification of a fixed individual. -/
def AndersonNecExMinus (M : Semantics World Entity Property)
    (w : World) (x : Entity) (φ : Property) : Prop :=
  ∃ z, M.R w z ∧ M.exNeg z x φ

/--
Explicit negative evidence against Anderson Godlikeness.

A witness either violates positivity -> necessary exemplification, or violates
necessary exemplification -> positivity. This is counter-support, not mere
meta-level failure of `AndersonGodPlus`.
-/
def AndersonGodMinus (M : Semantics World Entity Property)
    (w : World) (x : Entity) : Prop :=
  ∃ φ,
    (M.pPos w φ ∧ AndersonNecExMinus M w x φ) ∨
    (AndersonNecExPlus M w x φ ∧ M.pNeg w φ)

/-- Explicit negative evidence against the Anderson essence equivalence. -/
def AndersonEssMinus (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  ∃ ψ,
    (AndersonNecExPlus M w x ψ ∧ NEntMinus M w φ ψ) ∨
    (NEntPlus M w φ ψ ∧ AndersonNecExMinus M w x ψ)

/-- Negative support for necessary actual exemplification. -/
def AndersonBoxExistsMinus (M : Semantics World Entity Property)
    (w : World) (φ : Property) : Prop :=
  ∃ z, M.R w z ∧ ∀ y, M.Exists z y → M.exNeg z y φ

/-- Bilateral negative Anderson necessary existence. -/
def AndersonNEMinus (M : Semantics World Entity Property)
    (w : World) (x : Entity) : Prop :=
  ∃ φ, AndersonEssPlus M w φ x ∧ AndersonBoxExistsMinus M w φ

/-- Bilateral realization of Anderson Godlikeness by the distinguished property `G`. -/
def AndersonGRealizationBilateral (M : Semantics World Entity Property) : Prop :=
  AndersonGRealization M ∧
  ∀ w x, M.exNeg w x M.G ↔ AndersonGodMinus M w x

/-- Bilateral realization of Anderson necessary existence. -/
def AndersonNERealizationBilateral (M : Semantics World Entity Property)
    (NEA : Property) : Prop :=
  AndersonNERealization M NEA ∧
  ∀ w x, M.exNeg w x NEA ↔ AndersonNEMinus M w x

/-- Classical recovery for fixed-individual necessary exemplification. -/
theorem andersonNecExMinus_iff_not_plus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M)
    (w : World) (x : Entity) (φ : Property) :
    AndersonNecExMinus M w x φ ↔ ¬ AndersonNecExPlus M w x φ := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨z, hwz, hNeg⟩
    have hPos : M.exPos z x φ := hPlus z hwz
    exact (hEx z x φ).1 hNeg hPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro z hwz
    apply Classical.byContradiction
    intro hNoPos
    have hNeg : M.exNeg z x φ := (hEx z x φ).2 hNoPos
    exact hNoMinus ⟨z, hwz, hNeg⟩

/-- Classical recovery of bilateral Anderson Godlikeness. -/
theorem andersonGodMinus_iff_not_plus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M)
    (hP : PClassical M)
    (w : World) (x : Entity) :
    AndersonGodMinus M w x ↔ ¬ AndersonGodPlus M w x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨φ, hBad⟩
    cases hBad with
    | inl hForward =>
        have hNec : AndersonNecExPlus M w x φ := hPlus.1 φ hForward.1
        exact (andersonNecExMinus_iff_not_plus M hEx w x φ).1 hForward.2 hNec
    | inr hBackward =>
        have hPos : M.pPos w φ := hPlus.2 φ hBackward.1
        exact (hP w φ).1 hBackward.2 hPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    constructor
    · intro φ hPos
      apply Classical.byContradiction
      intro hNoNec
      have hNecMinus : AndersonNecExMinus M w x φ :=
        (andersonNecExMinus_iff_not_plus M hEx w x φ).2 hNoNec
      exact hNoMinus ⟨φ, Or.inl ⟨hPos, hNecMinus⟩⟩
    · intro φ hNec
      apply Classical.byContradiction
      intro hNoPos
      have hNegP : M.pNeg w φ := (hP w φ).2 hNoPos
      exact hNoMinus ⟨φ, Or.inr ⟨hNec, hNegP⟩⟩

/-- Classical recovery of bilateral Anderson essence. -/
theorem andersonEssMinus_iff_not_plus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M)
    (w : World) (φ : Property) (x : Entity) :
    AndersonEssMinus M w φ x ↔ ¬ AndersonEssPlus M w φ x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨ψ, hBad⟩
    cases hBad with
    | inl hForward =>
        have hNEnt : NEntPlus M w φ ψ := hPlus.1 ψ hForward.1
        exact (nentMinus_iff_not_nentPlus M hEx w φ ψ).1 hForward.2 hNEnt
    | inr hBackward =>
        have hNec : AndersonNecExPlus M w x ψ := hPlus.2 ψ hBackward.1
        exact (andersonNecExMinus_iff_not_plus M hEx w x ψ).1 hBackward.2 hNec
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    constructor
    · intro ψ hNec
      apply Classical.byContradiction
      intro hNoNEnt
      have hNEntMinus : NEntMinus M w φ ψ :=
        (nentMinus_iff_not_nentPlus M hEx w φ ψ).2 hNoNEnt
      exact hNoMinus ⟨ψ, Or.inl ⟨hNec, hNEntMinus⟩⟩
    · intro ψ hNEnt
      apply Classical.byContradiction
      intro hNoNec
      have hNecMinus : AndersonNecExMinus M w x ψ :=
        (andersonNecExMinus_iff_not_plus M hEx w x ψ).2 hNoNec
      exact hNoMinus ⟨ψ, Or.inr ⟨hNEnt, hNecMinus⟩⟩

/-- Classical recovery for necessary actual exemplification. -/
theorem andersonBoxExistsMinus_iff_not_plus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M)
    (w : World) (φ : Property) :
    AndersonBoxExistsMinus M w φ ↔ ¬ AndersonBoxExistsPlus M w φ := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨z, hwz, hAllNeg⟩
    rcases hPlus z hwz with ⟨y, hyExists, hPos⟩
    have hNeg : M.exNeg z y φ := hAllNeg y hyExists
    exact (hEx z y φ).1 hNeg hPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro z hwz
    apply Classical.byContradiction
    intro hNoWitness
    have hAllNeg : ∀ y, M.Exists z y → M.exNeg z y φ := by
      intro y hyExists
      have hNoPos : ¬ M.exPos z y φ := by
        intro hPos
        exact hNoWitness ⟨y, hyExists, hPos⟩
      exact (hEx z y φ).2 hNoPos
    exact hNoMinus ⟨z, hwz, hAllNeg⟩

/-- Classical recovery of bilateral Anderson necessary existence. -/
theorem andersonNEMinus_iff_not_plus
    (M : Semantics World Entity Property)
    (hEx : ExClassical M)
    (w : World) (x : Entity) :
    AndersonNEMinus M w x ↔ ¬ AndersonNEPlus M w x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨φ, hEss, hBoxMinus⟩
    have hBoxPlus : AndersonBoxExistsPlus M w φ := hPlus φ hEss
    exact (andersonBoxExistsMinus_iff_not_plus M hEx w φ).1 hBoxMinus hBoxPlus
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro φ hEss
    apply Classical.byContradiction
    intro hNoBox
    have hBoxMinus : AndersonBoxExistsMinus M w φ :=
      (andersonBoxExistsMinus_iff_not_plus M hEx w φ).2 hNoBox
    exact hNoMinus ⟨φ, hEss, hBoxMinus⟩

end Goedel4PEL.GoedelScott
