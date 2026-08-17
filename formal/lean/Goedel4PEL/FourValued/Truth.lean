namespace Goedel4PEL

structure Truth where
  pos : Bool
  neg : Bool
  deriving DecidableEq, Repr

namespace Truth

/-- Truth-only: positive support without negative support. -/
def T : Truth := ⟨true, false⟩

/-- Falsity-only: negative support without positive support. -/
def F : Truth := ⟨false, true⟩

/-- Glut: both positive and negative support. -/
def B : Truth := ⟨true, true⟩

/-- Gap: neither positive nor negative support. -/
def N : Truth := ⟨false, false⟩

/-- FDE negation swaps the two information channels. -/
def negate (v : Truth) : Truth := ⟨v.neg, v.pos⟩

def Pos (v : Truth) : Prop := v.pos = true

def Neg (v : Truth) : Prop := v.neg = true

@[simp] theorem negate_involutive (v : Truth) : negate (negate v) = v := by
  cases v
  rfl

@[simp] theorem pos_negate_iff_neg (v : Truth) : Pos (negate v) ↔ Neg v := by
  rfl

@[simp] theorem neg_negate_iff_pos (v : Truth) : Neg (negate v) ↔ Pos v := by
  rfl

@[simp] theorem negate_T : negate T = F := rfl
@[simp] theorem negate_F : negate F = T := rfl
@[simp] theorem negate_B : negate B = B := rfl
@[simp] theorem negate_N : negate N = N := rfl

end Truth
end Goedel4PEL
