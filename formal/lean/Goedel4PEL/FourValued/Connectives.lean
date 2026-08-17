import Goedel4PEL.FourValued.Truth

namespace Goedel4PEL.Truth

/-- FDE conjunction: positive support intersects, negative support unions. -/
def conj (a b : Truth) : Truth :=
  ⟨a.pos && b.pos, a.neg || b.neg⟩

/-- FDE disjunction: positive support unions, negative support intersects. -/
def disj (a b : Truth) : Truth :=
  ⟨a.pos || b.pos, a.neg && b.neg⟩

@[simp] theorem conj_T_T : conj T T = T := rfl
@[simp] theorem conj_T_F : conj T F = F := rfl
@[simp] theorem conj_F_T : conj F T = F := rfl
@[simp] theorem conj_F_F : conj F F = F := rfl

@[simp] theorem disj_T_T : disj T T = T := rfl
@[simp] theorem disj_T_F : disj T F = T := rfl
@[simp] theorem disj_F_T : disj F T = T := rfl
@[simp] theorem disj_F_F : disj F F = F := rfl

end Goedel4PEL.Truth
