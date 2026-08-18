import Goedel4PEL.GoedelScott.FittingActualistQuotient

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- Truth-order comparison on bilateral extensions. -/
def Extension.TruthLE (X Y : Extension Entity) : Prop :=
  (∀ x, X.pos x → Y.pos x) ∧ (∀ x, Y.neg x → X.neg x)

/-- The constant glut extension, carrying both support channels everywhere. -/
def Extension.fdeBoth : Extension Entity :=
  ⟨fun _ => True, fun _ => True⟩

/-- The constant gap extension, carrying neither support channel anywhere. -/
def Extension.fdeNeither : Extension Entity :=
  ⟨fun _ => False, fun _ => False⟩

/--
A four-valued delta-filter on an extension algebra: proper, upward closed in
the FDE truth order, and closed under FDE conjunction.
-/
def PositiveDeltaFilter
    (F : Extension Entity → Prop) : Prop :=
  F Extension.fdeTop ∧
  ¬ F Extension.fdeBot ∧
  (∀ X Y, F X → X.TruthLE Y → F Y) ∧
  (∀ X Y, F X → F Y → F (X.fdeConj Y))

/-- Lattice primeness added to the four-valued delta-filter conditions. -/
def PositivePrimeDeltaFilter
    (F : Extension Entity → Prop) : Prop :=
  PositiveDeltaFilter F ∧
  ∀ X Y, F (X.fdeDisj Y) → F X ∨ F Y

/--
The non-adjunctive two-filter law: pairwise conjunctions of three extensions
being positive forces their triple conjunction to be positive.
-/
def PositiveTwoFilter
    (F : Extension Entity → Prop) : Prop :=
  F Extension.fdeTop ∧
  ¬ F Extension.fdeBot ∧
  (∀ X Y, F X → X.TruthLE Y → F Y) ∧
  (∀ X Y Z : Extension Entity,
    F (X.fdeConj Y) → F (X.fdeConj Z) → F (Y.fdeConj Z) →
    F ((X.fdeConj Y).fdeConj Z))

/-- Prime non-adjunctive two-filter. -/
def PositivePrimeTwoFilter
    (F : Extension Entity → Prop) : Prop :=
  PositiveTwoFilter F ∧
  ∀ X Y, F (X.fdeDisj Y) → F X ∨ F Y

/-- Classical-style decision between each extension and its FDE negation. -/
def PositiveComplementDeciding
    (F : Extension Entity → Prop) : Prop :=
  ∀ X, F X ∨ F X.negate

/-- Every ordinary delta-filter satisfies the weaker two-filter law. -/
theorem positiveDeltaFilter_implies_twoFilter
    (F : Extension Entity → Prop)
    (hF : PositiveDeltaFilter F) : PositiveTwoFilter F := by
  refine ⟨hF.1, hF.2.1, hF.2.2.1, ?_⟩
  intro X Y Z hXY hXZ hYZ
  have hMeetLEZ : (X.fdeConj Z).TruthLE Z := by
    constructor
    · intro x hx
      exact hx.2
    · intro x hz
      exact Or.inr hz
  have hZ : F Z := hF.2.2.1 (X.fdeConj Z) Z hXZ hMeetLEZ
  exact hF.2.2.2 (X.fdeConj Y) Z hXY hZ

/-- Classical coherence identifies negative support with absent positive support. -/
def Extension.ClassicallyCoherent (X : Extension Entity) : Prop :=
  ∀ x, X.neg x ↔ ¬ X.pos x

/-- On coherent extensions the FDE truth order reduces to positive-set inclusion. -/
theorem truthLE_iff_posSupportLE_of_classical
    (X Y : Extension Entity)
    (hX : X.ClassicallyCoherent) (hY : Y.ClassicallyCoherent) :
    X.TruthLE Y ↔ ∀ x, X.pos x → Y.pos x := by
  constructor
  · intro h
    exact h.1
  · intro hPos
    constructor
    · exact hPos
    · intro x hYNeg
      have hNotY : ¬ Y.pos x := (hY x).1 hYNeg
      have hNotX : ¬ X.pos x := fun hXPos => hNotY (hPos x hXPos)
      exact (hX x).2 hNotX

/-- Evaluation at one quotient point designates exactly positive support there. -/
def evaluationFilter (q : Entity) : Extension Entity → Prop :=
  fun X => X.pos q

/-- Point evaluation is a proper prime delta-filter in the FDE truth order. -/
theorem evaluationFilter_primeDeltaFilter (q : Entity) :
    PositivePrimeDeltaFilter (evaluationFilter q) := by
  constructor
  · constructor
    · trivial
    constructor
    · simp [evaluationFilter, Extension.fdeBot]
    constructor
    · intro X Y hX hLE
      exact hLE.1 q hX
    · intro X Y hX hY
      exact ⟨hX, hY⟩
  · intro X Y hDisj
    exact hDisj

/-- The canonical prime filter designates the glut value. -/
theorem evaluationFilter_designates_both (q : Entity) :
    evaluationFilter q (Extension.fdeBoth (Entity := Entity)) := by
  trivial

/-- Neither the gap nor its FDE negation is designated at a point. -/
theorem evaluationFilter_neither_undecided (q : Entity) :
    ¬ evaluationFilter q (Extension.fdeNeither (Entity := Entity)) ∧
    ¬ evaluationFilter q (Extension.fdeNeither (Entity := Entity)).negate := by
  constructor <;> simp [evaluationFilter, Extension.fdeNeither, Extension.negate]

/--
Prime four-valued delta-filters need not decide complements.  The obstruction
is the FDE gap, which is a negation fixed point with no positive support.
-/
theorem evaluationFilter_not_complementDeciding (q : Entity) :
    ¬ PositiveComplementDeciding (evaluationFilter q) := by
  intro hDecision
  rcases hDecision (Extension.fdeNeither (Entity := Entity)) with hGap | hNegGap
  · exact (evaluationFilter_neither_undecided q).1 hGap
  · exact (evaluationFilter_neither_undecided q).2 hNegGap

/-- Every inhabited positive-profile quotient carries this non-deciding prime filter. -/
theorem profileQuotient_has_nondeciding_primeDeltaFilter
    (M : AdmissibleSemantics World Entity) (w : World) (x : Entity) :
    ∃ F : Extension (ProfileQuotient M w) → Prop,
      PositivePrimeDeltaFilter F ∧ ¬ PositiveComplementDeciding F := by
  let q : ProfileQuotient M w := profileClass M w x
  exact ⟨evaluationFilter q,
    evaluationFilter_primeDeltaFilter q,
    evaluationFilter_not_complementDeciding q⟩

end Goedel4PEL.GoedelScott.Fitting
