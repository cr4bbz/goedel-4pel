import Goedel4PEL.GoedelScott.FittingEntailmentQuotient

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- The source-world positive-profile equivalence as an actual Lean setoid. -/
def positiveProfileSetoid
    (M : AdmissibleSemantics World Entity) (w : World) : Setoid Entity where
  r := PositiveProfileEqAdm M w
  iseqv := ⟨
    fun x => positiveProfileEqAdm_refl M w x,
    fun hxy => positiveProfileEqAdm_symm M w _ _ hxy,
    fun hxy hyz => positiveProfileEqAdm_trans M w _ _ _ hxy hyz
  ⟩

/-- Entities observed only up to their positive admissible-property profile. -/
abbrev ProfileQuotient
    (M : AdmissibleSemantics World Entity) (w : World) :=
  Quotient (positiveProfileSetoid M w)

/-- Canonical projection from entities to positive-profile classes. -/
def profileClass
    (M : AdmissibleSemantics World Entity) (w : World) (x : Entity) :
    ProfileQuotient M w :=
  Quotient.mk (positiveProfileSetoid M w) x

/-- Pull a bilateral extension on profile classes back to ordinary entities. -/
def Extension.fromProfileQuotient
    (M : AdmissibleSemantics World Entity) (w : World)
    (Q : Extension (ProfileQuotient M w)) : Extension Entity :=
  ⟨fun x => Q.pos (profileClass M w x), fun x => Q.neg (profileClass M w x)⟩

/-- Every pullback from the entity quotient is profile-respecting. -/
theorem fromProfileQuotient_respectsProfile
    (M : AdmissibleSemantics World Entity) (w : World)
    (Q : Extension (ProfileQuotient M w)) :
    RespectsProfileAt M w (Q.fromProfileQuotient M w) := by
  intro x y hxy
  have hClass : profileClass M w x = profileClass M w y := Quotient.sound hxy
  constructor
  · constructor <;> intro h
    · simpa [Extension.fromProfileQuotient, hClass] using h
    · simpa [Extension.fromProfileQuotient, hClass] using h
  · constructor <;> intro h
    · simpa [Extension.fromProfileQuotient, hClass] using h
    · simpa [Extension.fromProfileQuotient, hClass] using h

/--
Push a profile-respecting bilateral extension to the quotient.  The proof of
profile factorization is exactly what makes both support channels independent
of the chosen representative.
-/
def Extension.toProfileQuotient
    (M : AdmissibleSemantics World Entity) (w : World)
    (Y : Extension Entity) (hY : RespectsProfileAt M w Y) :
    Extension (ProfileQuotient M w) :=
  ⟨
    fun q => Quotient.liftOn q Y.pos
      (fun x y hxy => propext ((hY x y hxy).1)),
    fun q => Quotient.liftOn q Y.neg
      (fun x y hxy => propext ((hY x y hxy).2))
  ⟩

@[simp]
theorem toProfileQuotient_pos_class
    (M : AdmissibleSemantics World Entity) (w : World)
    (Y : Extension Entity) (hY : RespectsProfileAt M w Y) (x : Entity) :
    (Y.toProfileQuotient M w hY).pos (profileClass M w x) ↔ Y.pos x := by
  rfl

@[simp]
theorem toProfileQuotient_neg_class
    (M : AdmissibleSemantics World Entity) (w : World)
    (Y : Extension Entity) (hY : RespectsProfileAt M w Y) (x : Entity) :
    (Y.toProfileQuotient M w hY).neg (profileClass M w x) ↔ Y.neg x := by
  rfl

/-- Quotienting and pulling back recovers every profile-respecting extension. -/
theorem from_toProfileQuotient_equivalent
    (M : AdmissibleSemantics World Entity) (w : World)
    (Y : Extension Entity) (hY : RespectsProfileAt M w Y) :
    ExtensionEquivalent
      ((Y.toProfileQuotient M w hY).fromProfileQuotient M w) Y := by
  intro x
  exact ⟨Iff.rfl, Iff.rfl⟩

/-- Every quotient extension is recovered after pullback and re-quotienting. -/
theorem to_fromProfileQuotient_equivalent
    (M : AdmissibleSemantics World Entity) (w : World)
    (Q : Extension (ProfileQuotient M w)) :
    ExtensionEquivalent
      ((Q.fromProfileQuotient M w).toProfileQuotient M w
        (fromProfileQuotient_respectsProfile M w Q)) Q := by
  intro q
  refine Quotient.inductionOn q ?_
  intro x
  exact ⟨Iff.rfl, Iff.rfl⟩

/-- A profile-respecting extension has an explicit representation on classes. -/
theorem respectingExtension_has_quotientRepresentation
    (M : AdmissibleSemantics World Entity) (w : World)
    (Y : Extension Entity) (hY : RespectsProfileAt M w Y) :
    ∃ Q : Extension (ProfileQuotient M w),
      ExtensionEquivalent (Q.fromProfileQuotient M w) Y := by
  exact ⟨Y.toProfileQuotient M w hY,
    from_toProfileQuotient_equivalent M w Y hY⟩

/--
Actual existence at an accessible target factors through the source profile
quotient when it is represented by one predicate on quotient entities.
-/
def ExistenceFactorsAt
    (M : AdmissibleSemantics World Entity) (w z : World) : Prop :=
  ∃ existsQ : ProfileQuotient M w → Prop,
    ∀ x, existsQ (profileClass M w x) ↔ M.base.Exists z x

/-- The canonical quotient existence predicate supplied by existence saturation. -/
def profileQuotientExists
    (M : AdmissibleSemantics World Entity)
    (hExists : ProfileExistenceSaturatedAdm M)
    (w z : World) (hwz : M.base.R w z) : ProfileQuotient M w → Prop :=
  fun q => Quotient.liftOn q (M.base.Exists z)
    (fun x y hxy => propext (hExists w z x y hwz hxy))

@[simp]
theorem profileQuotientExists_class
    (M : AdmissibleSemantics World Entity)
    (hExists : ProfileExistenceSaturatedAdm M)
    (w z : World) (hwz : M.base.R w z) (x : Entity) :
    profileQuotientExists M hExists w z hwz (profileClass M w x) ↔
      M.base.Exists z x := by
  rfl

/--
The previously primitive existence-saturation condition is exactly the claim
that actual existence factors through every accessible source quotient.
-/
theorem profileExistenceSaturated_iff_factors
    (M : AdmissibleSemantics World Entity) :
    ProfileExistenceSaturatedAdm M ↔
      ∀ w z, M.base.R w z → ExistenceFactorsAt M w z := by
  constructor
  · intro hExists w z hwz
    exact ⟨profileQuotientExists M hExists w z hwz, fun x => Iff.rfl⟩
  · intro hFactor w z x y hwz hxy
    rcases hFactor w z hwz with ⟨existsQ, hRep⟩
    have hClass : profileClass M w x = profileClass M w y := Quotient.sound hxy
    constructor
    · intro hx
      have hQx : existsQ (profileClass M w x) := (hRep x).2 hx
      have hQy : existsQ (profileClass M w y) := by simpa [hClass] using hQx
      exact (hRep y).1 hQy
    · intro hy
      have hQy : existsQ (profileClass M w y) := (hRep y).2 hy
      have hQx : existsQ (profileClass M w x) := by simpa [hClass] using hQy
      exact (hRep x).1 hQx

/-- Positive actualist entailment evaluated directly on source profile classes. -/
def ProfileQuotientEntailPlus
    (M : AdmissibleSemantics World Entity)
    (hExists : ProfileExistenceSaturatedAdm M)
    (w : World) (X Y : Extension (ProfileQuotient M w)) : Prop :=
  ∀ z (hwz : M.base.R w z) (q : ProfileQuotient M w),
    profileQuotientExists M hExists w z hwz q → X.pos q → Y.pos q

/-- Quotient entailment is exactly ordinary entailment between pullbacks. -/
theorem profileQuotientEntailPlus_iff_pullback
    (M : AdmissibleSemantics World Entity)
    (hExists : ProfileExistenceSaturatedAdm M)
    (w : World) (X Y : Extension (ProfileQuotient M w)) :
    ProfileQuotientEntailPlus M hExists w X Y ↔
      EntailPlus M.base w
        (X.fromProfileQuotient M w) (Y.fromProfileQuotient M w) := by
  constructor
  · intro hEnt z hwz x hxExists hX
    exact hEnt z hwz (profileClass M w x) hxExists hX
  · intro hEnt z hwz q
    refine Quotient.inductionOn q ?_
    intro x hxExists hX
    exact hEnt z hwz x hxExists hX

/--
For profile-respecting extensions, the quotient formulation and the original
actualist entailment formulation are equivalent.
-/
theorem entailPlus_iff_profileQuotient
    (M : AdmissibleSemantics World Entity)
    (hExists : ProfileExistenceSaturatedAdm M)
    (w : World) (X Y : Extension Entity)
    (hX : RespectsProfileAt M w X) (hY : RespectsProfileAt M w Y) :
    EntailPlus M.base w X Y ↔
      ProfileQuotientEntailPlus M hExists w
        (X.toProfileQuotient M w hX) (Y.toProfileQuotient M w hY) := by
  constructor
  · intro hEnt z hwz q
    refine Quotient.inductionOn q ?_
    intro x hxExists hXPos
    exact hEnt z hwz x hxExists hXPos
  · intro hEnt z hwz x hxExists hXPos
    exact hEnt z hwz (profileClass M w x) hxExists hXPos

/-- Profile closure is concretely the pullback of an extension on classes. -/
theorem profileSaturateAt_has_quotientRepresentation
    (M : AdmissibleSemantics World Entity) (w : World) (Y : Extension Entity) :
    ∃ Q : Extension (ProfileQuotient M w),
      ExtensionEquivalent (Q.fromProfileQuotient M w)
        (Y.profileSaturateAt M w) := by
  exact respectingExtension_has_quotientRepresentation M w
    (Y.profileSaturateAt M w) (profileSaturateAt_respectsProfile M w Y)

end Goedel4PEL.GoedelScott.Fitting
