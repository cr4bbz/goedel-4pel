namespace Goedel4PEL.Actualist

universe u v

/-- Positive support for the actualist existential quantifier. -/
def ExistsPlus {World : Type u} {Entity : Type v}
    (Exists : World → Entity → Prop) (Pos : World → Entity → Prop)
    (w : World) : Prop :=
  ∃ x, Exists w x ∧ Pos w x

/-- Negative support for the actualist existential quantifier. -/
def ExistsNeg {World : Type u} {Entity : Type v}
    (Exists : World → Entity → Prop) (Neg : World → Entity → Prop)
    (w : World) : Prop :=
  ∀ x, Exists w x → Neg w x

/-- Positive support for the actualist universal quantifier. -/
def ForallPlus {World : Type u} {Entity : Type v}
    (Exists : World → Entity → Prop) (Pos : World → Entity → Prop)
    (w : World) : Prop :=
  ∀ x, Exists w x → Pos w x

/-- Negative support for the actualist universal quantifier. -/
def ForallNeg {World : Type u} {Entity : Type v}
    (Exists : World → Entity → Prop) (Neg : World → Entity → Prop)
    (w : World) : Prop :=
  ∃ x, Exists w x ∧ Neg w x

end Goedel4PEL.Actualist
