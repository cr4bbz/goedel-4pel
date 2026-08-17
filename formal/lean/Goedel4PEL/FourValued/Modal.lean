namespace Goedel4PEL.Modal

universe u v

/-- Positive support for necessity: every accessible world positively supports the formula. -/
def BoxPlus {World : Type u} {Formula : Type v}
    (R : World → World → Prop) (Pos : World → Formula → Prop)
    (w : World) (φ : Formula) : Prop :=
  ∀ v, R w v → Pos v φ

/-- Negative support for necessity: some accessible world negatively supports the formula. -/
def BoxNeg {World : Type u} {Formula : Type v}
    (R : World → World → Prop) (Neg : World → Formula → Prop)
    (w : World) (φ : Formula) : Prop :=
  ∃ v, R w v ∧ Neg v φ

/-- Positive support for possibility: some accessible world positively supports the formula. -/
def DiamondPlus {World : Type u} {Formula : Type v}
    (R : World → World → Prop) (Pos : World → Formula → Prop)
    (w : World) (φ : Formula) : Prop :=
  ∃ v, R w v ∧ Pos v φ

/-- Negative support for possibility: every accessible world negatively supports the formula. -/
def DiamondNeg {World : Type u} {Formula : Type v}
    (R : World → World → Prop) (Neg : World → Formula → Prop)
    (w : World) (φ : Formula) : Prop :=
  ∀ v, R w v → Neg v φ

def Reflexive {World : Type u} (R : World → World → Prop) : Prop :=
  ∀ w, R w w

def Symmetric {World : Type u} (R : World → World → Prop) : Prop :=
  ∀ ⦃w v⦄, R w v → R v w

def Transitive {World : Type u} (R : World → World → Prop) : Prop :=
  ∀ ⦃w v z⦄, R w v → R v z → R w z

/-- The fixed S5 control-frame condition. -/
def S5 {World : Type u} (R : World → World → Prop) : Prop :=
  Reflexive R ∧ Symmetric R ∧ Transitive R

/-- Positive `◇□φ → □φ` on an S5 frame. -/
theorem diamondBoxPlus_implies_boxPlus
    {World : Type u} {Formula : Type v}
    {R : World → World → Prop} {Pos : World → Formula → Prop}
    (hS5 : S5 R) (w : World) (φ : Formula)
    (h : DiamondPlus R (fun v ψ => BoxPlus R Pos v ψ) w φ) :
    BoxPlus R Pos w φ := by
  rcases h with ⟨v, hwv, hvBox⟩
  intro z hwz
  have hvw : R v w := hS5.2.1 hwv
  have hvz : R v z := hS5.2.2 hvw hwz
  exact hvBox z hvz

end Goedel4PEL.Modal
