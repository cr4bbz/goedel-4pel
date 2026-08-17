import Goedel4PEL.FourValued.Modal
import Goedel4PEL.GoedelScott.Semantics

namespace Goedel4PEL.GoedelScott

universe u v e f

variable {World : Type u} {Entity : Type v} {Property : Type e}

/-- Positive necessary existence, parameterized by the chosen `NE` property. -/
def NEPlus (M : Semantics World Entity Property) (w : World) (x : Entity) : Prop :=
  ∀ φ, EssPlus M w φ x →
    ∀ z, M.R w z → ∃ y, M.Exists z y ∧ M.exPos z y φ

/-- The chosen `NE` property realizes `NE-sup-v0.1`. -/
def NESup (M : Semantics World Entity Property) (NE : Property) : Prop :=
  ∀ w x, M.exPos w x NE ↔ NEPlus M w x

/-- Positive support for Scott A5. -/
def A5Plus (M : Semantics World Entity Property) (NE : Property) : Prop :=
  ∀ w, M.pPos w NE

/-- An actual positive God-like witness at a world. -/
def GodWitness (M : Semantics World Entity Property) (w : World) : Prop :=
  ∃ x, M.Exists w x ∧ GodPlus M w x

/-- Gate-5 positive possible God-like existence, globally stated. -/
def PossibleGod (M : Semantics World Entity Property) : Prop :=
  ∀ w, ∃ z, M.R w z ∧ GodWitness M z

/-- Positive T3: every accessible world has an actual positive God-like witness. -/
def T3Plus (M : Semantics World Entity Property) : Prop :=
  ∀ w z, M.R w z → GodWitness M z

/-- Gate-4 global-witness interface. -/
def GW (M : Semantics World Entity Property) : Prop :=
  ∀ w, GodWitness M w

/--
Gate-6 positive T3 reconstruction.

Possible Godlikeness plus positive T2, A5+, the NE realization, G-sup, and S5
suffice for T3+. Only positive support for A5 is used.
-/
theorem t3Plus_of_possible_t2_a5
    (M : Semantics World Entity Property) (NE : Property)
    (hS5 : Goedel4PEL.Modal.S5 M.R)
    (hPossible : PossibleGod M)
    (hT2 : T2Plus M)
    (hA5 : A5Plus M NE)
    (hNESup : NESup M NE)
    (hGSup : GSup M) :
    T3Plus M := by
  intro w z hwz
  rcases hPossible w with ⟨v, hwv, x, hxExists, hGodx⟩
  have hNEx : M.exPos v x NE := hGodx NE (hA5 v)
  have hNEPlus : NEPlus M v x := (hNESup v x).1 hNEx
  have hEssG : EssPlus M v M.G x := hT2 v x hGodx
  have hBoxAtV : ∀ q, M.R v q → GodWitness M q := by
    intro q hvq
    rcases hNEPlus M.G hEssG q hvq with ⟨y, hyExists, hyG⟩
    exact ⟨y, hyExists, (hGSup q y).1 hyG⟩
  have hvw : M.R v w := hS5.2.1 hwv
  have hvz : M.R v z := hS5.2.2 hvw hwz
  exact hBoxAtV z hvz

/-- On reflexive frames, positive T3 discharges the global witness interface. -/
theorem gw_of_t3Plus
    (M : Semantics World Entity Property)
    (hRefl : Goedel4PEL.Modal.Reflexive M.R)
    (hT3 : T3Plus M) :
    GW M := by
  intro w
  exact hT3 w w (hRefl w)

/-- Constant-property embedding for an external modal formula language. -/
def ConstPlusEmbedding
    (M : Semantics World Entity Property)
    {Formula : Type f}
    (FormulaPos : World → Formula → Prop)
    (constProp : Formula → Property) : Prop :=
  ∀ w x χ, M.exPos w x (constProp χ) ↔ FormulaPos w χ

/-- Positive modal collapse for an external formula language over `M.R`. -/
def FormulaMCPlus
    (M : Semantics World Entity Property)
    {Formula : Type f}
    (FormulaPos : World → Formula → Prop) : Prop :=
  ∀ w χ, FormulaPos w χ → ∀ z, M.R w z → FormulaPos z χ

/--
Essence-compressed collapse theorem from Gate 6.

On the fixed reflexive control frames, `T2+ + T3+ + CONST` yields positive
modal collapse. No separate reflection, positivity-completeness, or
exemplification-consistency premise occurs in this compressed route.
-/
theorem formulaMCPlus_of_t2_t3_const
    (M : Semantics World Entity Property)
    {Formula : Type f}
    (FormulaPos : World → Formula → Prop)
    (constProp : Formula → Property)
    (hRefl : Goedel4PEL.Modal.Reflexive M.R)
    (hGSup : GSup M)
    (hT2 : T2Plus M)
    (hT3 : T3Plus M)
    (hConst : ConstPlusEmbedding M FormulaPos constProp) :
    FormulaMCPlus M FormulaPos := by
  intro w χ hχ z hwz
  rcases hT3 w w (hRefl w) with ⟨x, hxExists, hGodx⟩
  have hEssG : EssPlus M w M.G x := hT2 w x hGodx
  have hConstAtX : M.exPos w x (constProp χ) := (hConst w x χ).2 hχ
  have hNEnt : NEntPlus M w M.G (constProp χ) := hEssG.2 (constProp χ) hConstAtX
  rcases hT3 w z hwz with ⟨y, hyExists, hGody⟩
  have hyG : M.exPos z y M.G := (hGSup z y).2 hGody
  have hyConst : M.exPos z y (constProp χ) := hNEnt z hwz y hyExists hyG
  exact (hConst z y χ).1 hyConst

end Goedel4PEL.GoedelScott
