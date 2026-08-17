import Goedel4PEL.GoedelScott.AndersonBilateral

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/--
On a symmetric frame, positive Anderson Godlikeness already makes `G` an
Anderson essence. No reflexivity, transitivity, or separate positivity-rigidity
premise is required.

The forward essence direction uses symmetry twice conceptually: an accessible
Godlike witness at `z` necessarily exemplifies positive `G`, hence exemplifies
`G` back at `w`; realization makes it Godlike at `w`, where the positivity of
`psi` obtained from the original individual's backward Anderson direction sends
`psi` forward again to `z`.
-/
theorem andersonGod_has_andersonEssence_of_symmetric
    (M : Semantics World Entity Property)
    (hReal : AndersonGRealization M)
    (hGPos : AndersonGPositive M)
    (hA2 : A2Plus M)
    (hSym : Goedel4PEL.Modal.Symmetric M.R) :
    ∀ w x, AndersonGodPlus M w x → AndersonEssPlus M w M.G x := by
  intro w x hGodA
  constructor
  · intro ψ hNecX
    have hPψw : M.pPos w ψ := hGodA.2 ψ hNecX
    intro z hwz y hyExists hGyZ
    have hGodAZ : AndersonGodPlus M z y := (hReal z y).1 hGyZ
    have hNecGZ : AndersonNecExPlus M z y M.G := hGodAZ.1 M.G (hGPos z)
    have hzw : M.R z w := hSym hwz
    have hGyW : M.exPos w y M.G := hNecGZ w hzw
    have hGodAW : AndersonGodPlus M w y := (hReal w y).1 hGyW
    have hNecψW : AndersonNecExPlus M w y ψ := hGodAW.1 ψ hPψw
    exact hNecψW z hwz
  · intro ψ hNEnt
    have hPψ : M.pPos w ψ := hA2 w M.G ψ (hGPos w) hNEnt
    exact hGodA.1 ψ hPψ

/--
Gate-8 frame reduction for positive Anderson necessary Godlike existence.

Symmetry alone suffices. From a possible actual Godlike witness `x` at `v`,
Anderson's positive Godlikeness sends both `G` and `NEA` necessarily across the
reverse edge `v -> w`. Thus `x` is Anderson-Godlike at `w` and positively
exemplifies the realized necessary-existence property there. The symmetric
essence theorem above and `NEA` realization then give necessary actual Godlike
existence directly at `w`.

No reflexivity, transitivity, or `R+` premise occurs in this theorem.
-/
theorem andersonT3Plus_of_possibleGod_symmetric
    (M : Semantics World Entity Property)
    (NEA : Property)
    (hReal : AndersonGRealization M)
    (hGPos : AndersonGPositive M)
    (hA2 : A2Plus M)
    (hNEReal : AndersonNERealization M NEA)
    (hNEPos : AndersonNEPositive M NEA)
    (hSym : Goedel4PEL.Modal.Symmetric M.R)
    (hPossible : ∀ w, PossibleExemplification M w M.G) :
    AndersonT3Plus M := by
  intro w
  rcases hPossible w with ⟨v, hwv, x, hxExists, hGxV⟩
  have hGodAV : AndersonGodPlus M v x := (hReal v x).1 hGxV
  have hvw : M.R v w := hSym hwv
  have hNecG : AndersonNecExPlus M v x M.G := hGodAV.1 M.G (hGPos v)
  have hGxW : M.exPos w x M.G := hNecG w hvw
  have hGodAW : AndersonGodPlus M w x := (hReal w x).1 hGxW
  have hNecNE : AndersonNecExPlus M v x NEA := hGodAV.1 NEA (hNEPos v)
  have hNEAxW : M.exPos w x NEA := hNecNE w hvw
  have hNEW : AndersonNEPlus M w x := (hNEReal w x).1 hNEAxW
  have hEssG : AndersonEssPlus M w M.G x :=
    andersonGod_has_andersonEssence_of_symmetric M hReal hGPos hA2 hSym w x hGodAW
  exact hNEW M.G hEssG

/-- S5 is a strict over-specification of the frame premise for this route. -/
theorem andersonT3Plus_of_possibleGod_s5_reduced
    (M : Semantics World Entity Property)
    (NEA : Property)
    (hReal : AndersonGRealization M)
    (hGPos : AndersonGPositive M)
    (hA2 : A2Plus M)
    (hNEReal : AndersonNERealization M NEA)
    (hNEPos : AndersonNEPositive M NEA)
    (hS5 : Goedel4PEL.Modal.S5 M.R)
    (hPossible : ∀ w, PossibleExemplification M w M.G) :
    AndersonT3Plus M := by
  exact andersonT3Plus_of_possibleGod_symmetric
    M NEA hReal hGPos hA2 hNEReal hNEPos hS5.2.1 hPossible

end Goedel4PEL.GoedelScott
