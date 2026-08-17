import Goedel4PEL.GoedelScott.Semantics

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/--
Project-internal Gate-8 comparison candidate.

An entity is exactly positive-Godlike when its positively exemplified
properties coincide with the positively supported positive properties.
This is deliberately not identified with an Anderson or Fitting variant.
-/
def GodExactPlus (M : Semantics World Entity Property)
    (w : World) (x : Entity) : Prop :=
  ∀ φ, M.exPos w x φ ↔ M.pPos w φ

/-- The distinguished property `G` realizes exact positive Godlikeness. -/
def GExactSup (M : Semantics World Entity Property) : Prop :=
  ∀ w x, M.exPos w x M.G ↔ GodExactPlus M w x

/-- Positive T2 target for the exact-Godlikeness comparison theory. -/
def T2ExactPlus (M : Semantics World Entity Property) : Prop :=
  ∀ w x, GodExactPlus M w x → EssPlus M w M.G x

/-- Exact positive Godlikeness strictly contains the support condition. -/
theorem godExactPlus_implies_godPlus
    (M : Semantics World Entity Property)
    {w : World} {x : Entity}
    (hExact : GodExactPlus M w x) :
    GodPlus M w x := by
  intro φ hPφ
  exact (hExact φ).2 hPφ

/--
Exactness internalizes the positive reflection step: every positively
exemplified property of an exact God-like entity is positively supported.
-/
theorem reflection_of_godExactPlus
    (M : Semantics World Entity Property)
    {w : World} {x : Entity} {ψ : Property}
    (hExact : GodExactPlus M w x)
    (hψ : M.exPos w x ψ) :
    M.pPos w ψ := by
  exact (hExact ψ).1 hψ

/--
Gate-8 comparison theorem.

If the distinguished Godlikeness property realizes exact positive Godlikeness,
then positive rigidity alone suffices for positive Godlikeness-as-essence.
The Gate-6 support-theory recovery assumptions `A1-L`, `COMP_P^G`, and
`CONS_G^G` are not premises of this route.
-/
theorem t2ExactPlus_of_rPlus
    (M : Semantics World Entity Property)
    (hExactSup : GExactSup M)
    (hRPlus : RPlus M) :
    T2ExactPlus M := by
  intro w x hExactX
  constructor
  · exact (hExactSup w x).2 hExactX
  · intro ψ hψ
    intro z hwz y hyExists hGy
    have hPψw : M.pPos w ψ := (hExactX ψ).1 hψ
    have hPψz : M.pPos z ψ := hRPlus w ψ hPψw z hwz
    have hExactY : GodExactPlus M z y := (hExactSup z y).1 hGy
    exact (hExactY ψ).2 hPψz

end Goedel4PEL.GoedelScott
