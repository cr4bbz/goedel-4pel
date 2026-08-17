import Goedel4PEL.GoedelScott.T3Collapse

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/--
Gate-8 frame reduction for the Scott-support T3 theorem.

Once positive T2 is available, symmetry alone suffices to turn possible actual
Godlikeness into positive necessary actual Godlikeness. The possible Godlike
witness at `v` first yields, via A5+/NE/T2, a Godlike witness at every successor
of `v`. Symmetry therefore supplies a current Godlike witness back at `w`.
Running the same local NE/T2 package at `w` then supplies every successor `z`
of `w` directly.

No reflexivity or transitivity premise is used.
-/
theorem t3Plus_of_possible_t2_a5_symmetric
    (M : Semantics World Entity Property) (NE : Property)
    (hSym : Goedel4PEL.Modal.Symmetric M.R)
    (hPossible : PossibleGod M)
    (hT2 : T2Plus M)
    (hA5 : A5Plus M NE)
    (hNESup : NESup M NE)
    (hGSup : GSup M) :
    T3Plus M := by
  intro w z hwz
  rcases hPossible w with ⟨v, hwv, x, hxExists, hGodxV⟩

  have hNExV : M.exPos v x NE := hGodxV NE (hA5 v)
  have hNEV : NEPlus M v x := (hNESup v x).1 hNExV
  have hEssGV : EssPlus M v M.G x := hT2 v x hGodxV

  have hvw : M.R v w := hSym hwv
  rcases hNEV M.G hEssGV w hvw with ⟨y, hyExistsW, hyGW⟩
  have hGodYw : GodPlus M w y := (hGSup w y).1 hyGW

  have hNEyW : M.exPos w y NE := hGodYw NE (hA5 w)
  have hNEW : NEPlus M w y := (hNESup w y).1 hNEyW
  have hEssGW : EssPlus M w M.G y := hT2 w y hGodYw

  rcases hNEW M.G hEssGW z hwz with ⟨q, hqExists, hqG⟩
  exact ⟨q, hqExists, (hGSup z q).1 hqG⟩

/-- The original S5 theorem follows immediately from the symmetry-only result. -/
theorem t3Plus_of_possible_t2_a5_s5_reduced
    (M : Semantics World Entity Property) (NE : Property)
    (hS5 : Goedel4PEL.Modal.S5 M.R)
    (hPossible : PossibleGod M)
    (hT2 : T2Plus M)
    (hA5 : A5Plus M NE)
    (hNESup : NESup M NE)
    (hGSup : GSup M) :
    T3Plus M := by
  exact t3Plus_of_possible_t2_a5_symmetric
    M NE hS5.2.1 hPossible hT2 hA5 hNESup hGSup

end Goedel4PEL.GoedelScott
