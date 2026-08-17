import Goedel4PEL.GoedelScott.Semantics

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/-- Scott A1, right information-flow direction. -/
def A1R (M : Semantics World Entity Property) : Prop :=
  ∀ w φ, M.pPos w (M.negProp φ) → M.pNeg w φ

/-- Positive closure of positivity under necessary positive actualist entailment. -/
def A2Plus (M : Semantics World Entity Property) : Prop :=
  ∀ w φ ψ, M.pPos w φ → NEntPlus M w φ ψ → M.pPos w ψ

/-- Truth-only positivity: positive support without negative support. -/
def PosT (M : Semantics World Entity Property) (w : World) (φ : Property) : Prop :=
  M.pPos w φ ∧ ¬ M.pNeg w φ

/-- Positive actual exemplification of a property at one world. -/
def ExistsPropPlus (M : Semantics World Entity Property)
    (w : World) (φ : Property) : Prop :=
  ∃ x, M.Exists w x ∧ M.exPos w x φ

/-- Positive possible actual exemplification. -/
def PossibleExemplification (M : Semantics World Entity Property)
    (w : World) (φ : Property) : Prop :=
  ∃ z, M.R w z ∧ ExistsPropPlus M z φ

/-- Gate-5 truth-only T1 target. -/
def T1T (M : Semantics World Entity Property) : Prop :=
  ∀ w φ, PosT M w φ → PossibleExemplification M w φ

/--
`A1-R + A2+ => T1-T` in the classical semantic metatheory.

The reductio is exactly the Gate-5 argument: if `φ` has no possible positive
actual instance, then `φ` necessarily positively entails its negation vacuously;
A2+ makes the negation positive, and A1-R supplies negative support for `P φ`,
contradicting truth-only positivity.
-/
theorem t1T_of_a1R_a2Plus
    (M : Semantics World Entity Property)
    (hA1R : A1R M) (hA2 : A2Plus M) :
    T1T M := by
  classical
  intro w φ hPosT
  by_contra hNoPossible
  have hNEnt : NEntPlus M w φ (M.negProp φ) := by
    intro z hwz y hyExists hφy
    exact False.elim (hNoPossible ⟨z, hwz, y, hyExists, hφy⟩)
  have hPNotφ : M.pPos w (M.negProp φ) :=
    hA2 w φ (M.negProp φ) hPosT.1 hNEnt
  have hNegPφ : M.pNeg w φ := hA1R w φ hPNotφ
  exact hPosT.2 hNegPφ

end Goedel4PEL.GoedelScott
