import Goedel4PEL.FourValued.Modal
import Goedel4PEL.GoedelScott.T1

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/-- Positive necessary exemplification of a fixed individual. -/
def AndersonNecExPlus (M : Semantics World Entity Property)
    (w : World) (x : Entity) (φ : Property) : Prop :=
  ∀ z, M.R w z → M.exPos z x φ

/-- Positive direction: positivity implies necessary positive exemplification. -/
def AndersonGAForward (M : Semantics World Entity Property)
    (w : World) (x : Entity) : Prop :=
  ∀ φ, M.pPos w φ → AndersonNecExPlus M w x φ

/-- Reverse direction: necessary positive exemplification implies positivity. -/
def AndersonGABackward (M : Semantics World Entity Property)
    (w : World) (x : Entity) : Prop :=
  ∀ φ, AndersonNecExPlus M w x φ → M.pPos w φ

/-- Positive-channel Anderson Godlikeness interface. -/
def AndersonGodPlus (M : Semantics World Entity Property)
    (w : World) (x : Entity) : Prop :=
  AndersonGAForward M w x ∧ AndersonGABackward M w x

/-- The distinguished property `G` realizes the positive Anderson interface. -/
def AndersonGRealization (M : Semantics World Entity Property) : Prop :=
  ∀ w x, M.exPos w x M.G ↔ AndersonGodPlus M w x

/-- Positive support for the distinguished Anderson Godlikeness property. -/
def AndersonGPositive (M : Semantics World Entity Property) : Prop :=
  ∀ w, M.pPos w M.G

/-- First Anderson essence direction. -/
def AndersonEAForward (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  ∀ ψ, AndersonNecExPlus M w x ψ → NEntPlus M w φ ψ

/-- Reverse Anderson essence direction. -/
def AndersonEABackward (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  ∀ ψ, NEntPlus M w φ ψ → AndersonNecExPlus M w x ψ

/-- Positive-channel Anderson essence interface. -/
def AndersonEssPlus (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  AndersonEAForward M w φ x ∧ AndersonEABackward M w φ x

/-- Positive necessary actual exemplification of a property. -/
def AndersonBoxExistsPlus (M : Semantics World Entity Property)
    (w : World) (φ : Property) : Prop :=
  ∀ z, M.R w z → ExistsPropPlus M z φ

/-- Positive Anderson necessary existence. -/
def AndersonNEPlus (M : Semantics World Entity Property)
    (w : World) (x : Entity) : Prop :=
  ∀ φ, AndersonEssPlus M w φ x → AndersonBoxExistsPlus M w φ

/-- A distinguished property realizes Anderson necessary existence. -/
def AndersonNERealization (M : Semantics World Entity Property)
    (NEA : Property) : Prop :=
  ∀ w x, M.exPos w x NEA ↔ AndersonNEPlus M w x

/-- Positive support for the Anderson necessary-existence property. -/
def AndersonNEPositive (M : Semantics World Entity Property)
    (NEA : Property) : Prop :=
  ∀ w, M.pPos w NEA

/-- Positive Anderson analogue of necessary Godlike existence. -/
def AndersonT3Plus (M : Semantics World Entity Property) : Prop :=
  ∀ w, AndersonBoxExistsPlus M w M.G

/-- The split interfaces are equivalent to the corresponding meta-level iff form. -/
theorem andersonGodPlus_iff
    (M : Semantics World Entity Property) (w : World) (x : Entity) :
    AndersonGodPlus M w x ↔
      ∀ φ, M.pPos w φ ↔ AndersonNecExPlus M w x φ := by
  constructor
  · intro h φ
    exact ⟨h.1 φ, h.2 φ⟩
  · intro h
    constructor
    · intro φ hP
      exact (h φ).1 hP
    · intro φ hNec
      exact (h φ).2 hNec

/-- Same directional packaging for the positive Anderson essence interface. -/
theorem andersonEssPlus_iff
    (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) :
    AndersonEssPlus M w φ x ↔
      ∀ ψ, AndersonNecExPlus M w x ψ ↔ NEntPlus M w φ ψ := by
  constructor
  · intro h ψ
    exact ⟨h.1 ψ, h.2 ψ⟩
  · intro h
    constructor
    · intro ψ hNec
      exact (h ψ).1 hNec
    · intro ψ hEnt
      exact (h ψ).2 hEnt

/-- On reflexive frames, Anderson positive Godlikeness entails support Godlikeness. -/
theorem andersonGodPlus_implies_godPlus_of_reflexive
    (M : Semantics World Entity Property)
    (hRefl : Goedel4PEL.Modal.Reflexive M.R)
    {w : World} {x : Entity}
    (hGodA : AndersonGodPlus M w x) :
    GodPlus M w x := by
  intro φ hPφ
  have hNec : AndersonNecExPlus M w x φ := hGodA.1 φ hPφ
  exact hNec w (hRefl w)

/-- Positive Anderson Godlikeness makes `G` an Anderson essence under A2+/R+. -/
theorem andersonGod_has_andersonEssence
    (M : Semantics World Entity Property)
    (hReal : AndersonGRealization M)
    (hGPos : AndersonGPositive M)
    (hA2 : A2Plus M)
    (hRPlus : RPlus M)
    (hRefl : Goedel4PEL.Modal.Reflexive M.R) :
    ∀ w x, AndersonGodPlus M w x → AndersonEssPlus M w M.G x := by
  intro w x hGodA
  constructor
  · intro ψ hNecX
    have hPψw : M.pPos w ψ := hGodA.2 ψ hNecX
    intro z hwz y hyExists hGy
    have hPψz : M.pPos z ψ := hRPlus w ψ hPψw z hwz
    have hGodAy : AndersonGodPlus M z y := (hReal z y).1 hGy
    have hNecY : AndersonNecExPlus M z y ψ := hGodAy.1 ψ hPψz
    exact hNecY z (hRefl z)
  · intro ψ hNEnt
    have hPψ : M.pPos w ψ := hA2 w M.G ψ (hGPos w) hNEnt
    exact hGodA.1 ψ hPψ

/-- Local positive Anderson necessary-existence core. -/
theorem andersonGod_implies_boxGodExists
    (M : Semantics World Entity Property)
    (NEA : Property)
    (hReal : AndersonGRealization M)
    (hGPos : AndersonGPositive M)
    (hA2 : A2Plus M)
    (hRPlus : RPlus M)
    (hRefl : Goedel4PEL.Modal.Reflexive M.R)
    (hNEReal : AndersonNERealization M NEA)
    (hNEPos : AndersonNEPositive M NEA) :
    ∀ w x, AndersonGodPlus M w x → AndersonBoxExistsPlus M w M.G := by
  intro w x hGodA
  have hGEss : AndersonEssPlus M w M.G x :=
    andersonGod_has_andersonEssence M hReal hGPos hA2 hRPlus hRefl w x hGodA
  have hNecNE : AndersonNecExPlus M w x NEA := hGodA.1 NEA (hNEPos w)
  have hNEAtW : M.exPos w x NEA := hNecNE w (hRefl w)
  have hNE : AndersonNEPlus M w x := (hNEReal w x).1 hNEAtW
  exact hNE M.G hGEss

/-- Positive Anderson necessary Godlike existence from possible actual Godlikeness. -/
theorem andersonT3Plus_of_possibleGod
    (M : Semantics World Entity Property)
    (NEA : Property)
    (hReal : AndersonGRealization M)
    (hGPos : AndersonGPositive M)
    (hA2 : A2Plus M)
    (hRPlus : RPlus M)
    (hNEReal : AndersonNERealization M NEA)
    (hNEPos : AndersonNEPositive M NEA)
    (hS5 : Goedel4PEL.Modal.S5 M.R)
    (hPossible : ∀ w, PossibleExemplification M w M.G) :
    AndersonT3Plus M := by
  intro w z hwz
  rcases hPossible w with ⟨v, hwv, x, hxExists, hGx⟩
  have hGodA : AndersonGodPlus M v x := (hReal v x).1 hGx
  have hBoxAtV : AndersonBoxExistsPlus M v M.G :=
    andersonGod_implies_boxGodExists
      M NEA hReal hGPos hA2 hRPlus hS5.1 hNEReal hNEPos v x hGodA
  have hvw : M.R v w := hS5.2.1 hwv
  have hvz : M.R v z := hS5.2.2 hvw hwz
  exact hBoxAtV z hvz

end Goedel4PEL.GoedelScott
