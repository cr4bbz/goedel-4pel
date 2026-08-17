import Goedel4PEL.GoedelScott.Semantics

namespace Goedel4PEL.GoedelScott

universe u v e

variable {World : Type u} {Entity : Type v} {Property : Type e}

/--
Gate-6 recovery theorem.

The proof uses exactly the advertised resources:
- bilateral negation at exemplification;
- `G-sup-v0.1`;
- `A1-L`;
- positive rigidity `R+`;
- relevant completeness and consistency `REG_G`.
-/
theorem t2Plus_of_regG
    (M : Semantics World Entity Property)
    (hNeg : NegExemplification M)
    (hGSup : GSup M)
    (hA1L : A1L M)
    (hRPlus : RPlus M)
    (hRegG : RegG M) :
    T2Plus M := by
  intro w x hGod
  constructor
  · exact (hGSup w x).2 hGod
  · intro ψ hψ
    intro z hwz y hyExists hGy
    have hPosOrNeg : M.pPos w ψ ∨ M.pNeg w ψ :=
      hRegG.1 w x ψ hGod hψ
    have hPψ : M.pPos w ψ := by
      cases hPosOrNeg with
      | inl hPos =>
          exact hPos
      | inr hNegP =>
          have hPNotψ : M.pPos w (M.negProp ψ) := hA1L w ψ hNegP
          have hNotψx : M.exPos w x (M.negProp ψ) :=
            hGod (M.negProp ψ) hPNotψ
          have hNegψx : M.exNeg w x ψ := (hNeg w x ψ).1 hNotψx
          exact False.elim (hRegG.2 w x ψ hGod hψ hNegψx)
    have hPψz : M.pPos z ψ := hRPlus w ψ hPψ z hwz
    have hGodz : GodPlus M z y := (hGSup z y).1 hGy
    exact hGodz ψ hPψz

end Goedel4PEL.GoedelScott
