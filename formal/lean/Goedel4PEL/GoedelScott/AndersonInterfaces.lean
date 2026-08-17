import Goedel4PEL.GoedelScott.Semantics

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/--
Positive necessary exemplification of a fixed individual.

This mirrors the modal shape `Box (Y x)` in Anderson's Godlikeness definition.
It is deliberately not guarded by actual existence: Anderson's `Box (Y x)`
and the actualist quantifier inside his essence definition play different roles.
-/
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

/--
First Anderson essence direction:
necessary positive possession by x implies necessary positive entailment from φ.
-/
def AndersonEAForward (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  ∀ ψ, AndersonNecExPlus M w x ψ → NEntPlus M w φ ψ

/--
Reverse Anderson essence direction:
necessary positive entailment from φ implies necessary positive possession by x.
-/
def AndersonEABackward (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  ∀ ψ, NEntPlus M w φ ψ → AndersonNecExPlus M w x ψ

/-- Positive-channel Anderson essence interface. -/
def AndersonEssPlus (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  AndersonEAForward M w φ x ∧ AndersonEABackward M w φ x

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

end Goedel4PEL.GoedelScott
