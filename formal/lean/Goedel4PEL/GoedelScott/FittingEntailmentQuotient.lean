import Goedel4PEL.GoedelScott.FittingAdmissibleAlgebra

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/--
A strong domain-level entailment closure condition.

If an admissible rigid extension globally entails another rigid extension,
the latter is also admitted. This is deliberately stronger than the usual
filter-style A2 closure of *positive support* under entailment.
-/
def GlobalEntailmentClosedAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ (X Y : Extension Entity),
    M.admissible X →
    (∀ w, EntailPlus M.base w X Y) →
    M.admissible Y

/--
Actual existence respects the source-world positive-profile quotient throughout
that source world's accessible region.

This is the extra condition needed for actualist entailment itself to descend
cleanly through the entity quotient: profile-equivalent representatives cannot
split merely because only one of them exists at an accessible world.
-/
def ProfileExistenceSaturatedAdm
    (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w z x y,
    M.base.R w z →
    PositiveProfileEqAdm M w x y →
    (M.base.Exists z x ↔ M.base.Exists z y)

/--
Canonical bilateral saturation of an extension by positive-profile classes at
one world. Positive and negative support are each closed under the same entity
equivalence relation.
-/
def Extension.profileSaturateAt
    (M : AdmissibleSemantics World Entity)
    (w : World) (Y : Extension Entity) : Extension Entity :=
  ⟨
    fun x => ∃ y, PositiveProfileEqAdm M w x y ∧ Y.pos y,
    fun x => ∃ y, PositiveProfileEqAdm M w x y ∧ Y.neg y
  ⟩

/-- Bilateral support inclusion between rigid extensions. -/
def ExtensionSupportLe (X Y : Extension Entity) : Prop :=
  (∀ x, X.pos x → Y.pos x) ∧
  (∀ x, X.neg x → Y.neg x)

/-- Profile saturation is extensive in both support channels. -/
theorem profileSaturateAt_extensive
    (M : AdmissibleSemantics World Entity)
    (w : World) (Y : Extension Entity) :
    ExtensionSupportLe Y (Y.profileSaturateAt M w) := by
  constructor
  · intro x hx
    exact ⟨x, positiveProfileEqAdm_refl M w x, hx⟩
  · intro x hx
    exact ⟨x, positiveProfileEqAdm_refl M w x, hx⟩

/-- The canonical saturation operation is monotone. -/
theorem profileSaturateAt_mono
    (M : AdmissibleSemantics World Entity)
    (w : World) (X Y : Extension Entity)
    (hXY : ExtensionSupportLe X Y) :
    ExtensionSupportLe (X.profileSaturateAt M w) (Y.profileSaturateAt M w) := by
  constructor
  · intro x hx
    rcases hx with ⟨y, hxy, hXy⟩
    exact ⟨y, hxy, hXY.1 y hXy⟩
  · intro x hx
    rcases hx with ⟨y, hxy, hXy⟩
    exact ⟨y, hxy, hXY.2 y hXy⟩

/-- Every saturated extension respects the positive-profile quotient. -/
theorem profileSaturateAt_respectsProfile
    (M : AdmissibleSemantics World Entity)
    (w : World) (Y : Extension Entity) :
    RespectsProfileAt M w (Y.profileSaturateAt M w) := by
  intro x y hxy
  constructor
  · constructor
    · intro hx
      rcases hx with ⟨u, hxu, hYu⟩
      have hyu : PositiveProfileEqAdm M w y u :=
        positiveProfileEqAdm_trans M w y x u
          (positiveProfileEqAdm_symm M w x y hxy) hxu
      exact ⟨u, hyu, hYu⟩
    · intro hy
      rcases hy with ⟨u, hyu, hYu⟩
      have hxu : PositiveProfileEqAdm M w x u :=
        positiveProfileEqAdm_trans M w x y u hxy hyu
      exact ⟨u, hxu, hYu⟩
  · constructor
    · intro hx
      rcases hx with ⟨u, hxu, hYu⟩
      have hyu : PositiveProfileEqAdm M w y u :=
        positiveProfileEqAdm_trans M w y x u
          (positiveProfileEqAdm_symm M w x y hxy) hxu
      exact ⟨u, hyu, hYu⟩
    · intro hy
      rcases hy with ⟨u, hyu, hYu⟩
      have hxu : PositiveProfileEqAdm M w x u :=
        positiveProfileEqAdm_trans M w x y u hxy hyu
      exact ⟨u, hxu, hYu⟩

/-- A quotient-respecting extension is a fixed point of profile saturation. -/
theorem profileSaturateAt_equivalent_of_respects
    (M : AdmissibleSemantics World Entity)
    (w : World) (Y : Extension Entity)
    (hY : RespectsProfileAt M w Y) :
    ExtensionEquivalent (Y.profileSaturateAt M w) Y := by
  intro x
  constructor
  · constructor
    · intro hx
      rcases hx with ⟨y, hxy, hy⟩
      exact (hY x y hxy).1.2 hy
    · intro hx
      exact ⟨x, positiveProfileEqAdm_refl M w x, hx⟩
  · constructor
    · intro hx
      rcases hx with ⟨y, hxy, hy⟩
      exact (hY x y hxy).2.2 hy
    · intro hx
      exact ⟨x, positiveProfileEqAdm_refl M w x, hx⟩

/-- Profile saturation is idempotent up to bilateral extensional equivalence. -/
theorem profileSaturateAt_idempotent
    (M : AdmissibleSemantics World Entity)
    (w : World) (Y : Extension Entity) :
    ExtensionEquivalent
      ((Y.profileSaturateAt M w).profileSaturateAt M w)
      (Y.profileSaturateAt M w) := by
  exact profileSaturateAt_equivalent_of_respects M w
    (Y.profileSaturateAt M w)
    (profileSaturateAt_respectsProfile M w Y)

/--
The earlier profile-saturation axiom is exactly the statement that every
admissible extension is a fixed point of the canonical saturation closure.
Negation closure supplies the negative-channel half automatically.
-/
theorem positiveProfileSaturated_iff_fixedByProfileClosure
    (M : AdmissibleSemantics World Entity) :
    PositiveProfileSaturatedAdm M ↔
      (∀ w (Y : Extension Entity), M.admissible Y →
        ExtensionEquivalent (Y.profileSaturateAt M w) Y) := by
  constructor
  · intro hSat w Y hYAdm
    have hBilat : BilateralProfileSaturatedAdm M :=
      positiveProfileSaturated_implies_bilateralProfileSaturated M hSat
    have hRes : RespectsProfileAt M w Y := by
      intro x y hxy
      exact hBilat w x y Y hYAdm hxy
    exact profileSaturateAt_equivalent_of_respects M w Y hRes
  · intro hFixed w x y Y hYAdm hxy
    have hEq := hFixed w Y hYAdm
    have hSatRes := profileSaturateAt_respectsProfile M w Y
    constructor
    · intro hYx
      have hSX : (Y.profileSaturateAt M w).pos x := (hEq x).1.2 hYx
      have hSY : (Y.profileSaturateAt M w).pos y :=
        (hSatRes x y hxy).1.1 hSX
      exact (hEq y).1.1 hSY
    · intro hYy
      have hSY : (Y.profileSaturateAt M w).pos y := (hEq y).1.2 hYy
      have hSX : (Y.profileSaturateAt M w).pos x :=
        (hSatRes x y hxy).1.2 hSY
      exact (hEq x).1.1 hSX

/--
Actualist positive entailment is compatible with profile saturation provided
actual existence itself is constant on the relevant profile classes.
-/
theorem entailPlus_profileSaturateAt
    (M : AdmissibleSemantics World Entity)
    (hExists : ProfileExistenceSaturatedAdm M)
    (w : World) (X Y : Extension Entity)
    (hEnt : EntailPlus M.base w X Y) :
    EntailPlus M.base w
      (X.profileSaturateAt M w)
      (Y.profileSaturateAt M w) := by
  intro z hwz x hxExists hSX
  rcases hSX with ⟨y, hxy, hXy⟩
  have hyExists : M.base.Exists z y :=
    (hExists w z x y hwz hxy).1 hxExists
  have hYy : Y.pos y := hEnt z hwz y hyExists hXy
  exact ⟨y, hxy, hYy⟩

end Goedel4PEL.GoedelScott.Fitting
