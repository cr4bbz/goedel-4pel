import Goedel4PEL.FourValued.Modal
import Goedel4PEL.GoedelScott.T1

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
Positive support for the distinguished Anderson Godlikeness property.

In the literature-grounded Anderson presentation this corresponds to the
premise labelled `T2`, namely positivity of `G_A`; it is not Scott's theorem
that Godlikeness is an essence.
-/
def AndersonGPositive (M : Semantics World Entity Property) : Prop :=
  ∀ w, M.pPos w M.G

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

/--
On reflexive frames, Anderson positive Godlikeness entails the weaker
support-based positive Godlikeness interface.

The converse is not built in: `GodPlus` requires only current exemplification,
whereas Anderson's forward direction requires necessary exemplification.
-/
theorem andersonGodPlus_implies_godPlus_of_reflexive
    (M : Semantics World Entity Property)
    (hRefl : Goedel4PEL.Modal.Reflexive M.R)
    {w : World} {x : Entity}
    (hGodA : AndersonGodPlus M w x) :
    GodPlus M w x := by
  intro φ hPφ
  have hNec : AndersonNecExPlus M w x φ := hGodA.1 φ hPφ
  exact hNec w (hRefl w)

/--
Literature-grounded positive Anderson essence bridge.

Assume the distinguished `G` realizes Anderson positive Godlikeness, `G` is
positive (the premise labelled `T2` in the Anderson presentation), A2+ holds,
positivity is positively rigid, and the frame is reflexive. Then every positive
Anderson-Godlike entity has `G` as a positive Anderson essence.

No Scott-style `A1-L`, `COMP_P^G`, or `CONS_G^G` premise is used. The two
Anderson essence directions are supplied differently:

* necessary possession -> positivity by the backward Godlikeness direction,
  then rigidity transports positivity to accessible worlds;
* necessary entailment -> positivity by A2+ using positivity of `G`, then the
  forward Godlikeness direction turns positivity into necessary possession.
-/
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

end Goedel4PEL.GoedelScott
