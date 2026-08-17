namespace Goedel4PEL.Analysis

universe u v

/-- Positive modal collapse as a schema over all worlds and formulas. -/
def MCPlus {World : Type u} {Formula : Type v}
    (Pos : World → Formula → Prop) (box : Formula → Formula) : Prop :=
  ∀ w φ, Pos w φ → Pos w (box φ)

/-- Informative negative persistence as a schema over all worlds and formulas. -/
def MCMinus {World : Type u} {Formula : Type v}
    (Pos Neg : World → Formula → Prop)
    (box negF : Formula → Formula) : Prop :=
  ∀ w φ, Neg w φ → Pos w (box (negF φ))

/--
Under bilateral negation and involution, the two informative collapse schemata
are equivalent. The theorem is deliberately schema-level: the reverse direction
uses the instance at `negF φ`.
-/
theorem mcPlus_iff_mcMinus
    {World : Type u} {Formula : Type v}
    (Pos Neg : World → Formula → Prop)
    (box negF : Formula → Formula)
    (hPosNeg : ∀ w φ, Pos w (negF φ) ↔ Neg w φ)
    (hNegNeg : ∀ w φ, Neg w (negF φ) ↔ Pos w φ)
    (hInv : ∀ φ, negF (negF φ) = φ) :
    MCPlus Pos box ↔ MCMinus Pos Neg box negF := by
  constructor
  · intro hPlus w φ hNeg
    have hPosNegφ : Pos w (negF φ) := (hPosNeg w φ).2 hNeg
    exact hPlus w (negF φ) hPosNegφ
  · intro hMinus w φ hPos
    have hNegNegφ : Neg w (negF φ) := (hNegNeg w φ).2 hPos
    have hBoxed : Pos w (box (negF (negF φ))) :=
      hMinus w (negF φ) hNegNegφ
    rw [hInv φ] at hBoxed
    exact hBoxed

end Goedel4PEL.Analysis
