import Goedel4PEL.GoedelScott.AndersonBilateral

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/--
Gate-8 frame reduction for the positive Anderson necessary-existence theorem.

Unlike the generic `◇□ -> □` route used by the earlier S5 theorem, the Anderson
Godlikeness definition itself can transport `G` back from a possible Godlike
world to the current world on a symmetric frame. Reflexivity is then enough for
the local Anderson essence/necessary-existence branch.

Thus transitivity is not a premise of this theorem.
-/
theorem andersonT3Plus_of_possibleGod_reflexive_symmetric
    (M : Semantics World Entity Property)
    (NEA : Property)
    (hReal : AndersonGRealization M)
    (hGPos : AndersonGPositive M)
    (hA2 : A2Plus M)
    (hRPlus : RPlus M)
    (hNEReal : AndersonNERealization M NEA)
    (hNEPos : AndersonNEPositive M NEA)
    (hRefl : Goedel4PEL.Modal.Reflexive M.R)
    (hSym : Goedel4PEL.Modal.Symmetric M.R)
    (hPossible : ∀ w, PossibleExemplification M w M.G) :
    AndersonT3Plus M := by
  intro w
  rcases hPossible w with ⟨v, hwv, x, hxExists, hGxv⟩
  have hGodAv : AndersonGodPlus M v x := (hReal v x).1 hGxv
  have hNecG : AndersonNecExPlus M v x M.G := hGodAv.1 M.G (hGPos v)
  have hvw : M.R v w := hSym hwv
  have hGxw : M.exPos w x M.G := hNecG w hvw
  have hGodAw : AndersonGodPlus M w x := (hReal w x).1 hGxw
  exact andersonGod_implies_boxGodExists
    M NEA hReal hGPos hA2 hRPlus hRefl hNEReal hNEPos w x hGodAw

/-- The previous S5 result is an immediate corollary of the reduced frame theorem. -/
theorem andersonT3Plus_of_possibleGod_s5_reduced
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
  exact andersonT3Plus_of_possibleGod_reflexive_symmetric
    M NEA hReal hGPos hA2 hRPlus hNEReal hNEPos
    hS5.1 hS5.2.1 hPossible

end Goedel4PEL.GoedelScott
