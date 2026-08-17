import Goedel4PEL.GoedelScott.FittingSemantics

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/--
A Fitting model with a selected domain of admissible bilateral extensions.

The selected domain is closed under FDE negation. This avoids identifying the
literature's typed extensional property domain with the unrestricted powerset
of all bilateral support assignments.
-/
structure AdmissibleSemantics (World : Type u) (Entity : Type v) where
  base : Semantics World Entity
  admissible : Extension Entity → Prop
  negate_closed : ∀ X, admissible X → admissible X.negate

/-- Positive Godlikeness quantifies only over the selected extensional domain. -/
def GodPlusAdm
    (M : AdmissibleSemantics World Entity) (w : World) (x : Entity) : Prop :=
  ∀ X : Extension Entity,
    M.admissible X → M.base.pPos w X → X.pos x

/-- The distinguished intensional G realizes admissible-domain Godlikeness. -/
def GRealizationAdm (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w x, IntensionExPos M.base.G w x ↔ GodPlusAdm M w x

/-- Every current extension of G belongs to the selected extensional domain. -/
def GAdmissible (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w, M.admissible (extensionAt M.base.G w)

/-- A1-L restricted to admissible extensional properties. -/
def A1LAdm (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w (X : Extension Entity),
    M.admissible X → M.base.pNeg w X → M.base.pPos w X.negate

/-- A1-R restricted to admissible extensional properties. -/
def A1RAdm (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w (X : Extension Entity),
    M.admissible X → M.base.pPos w X.negate → M.base.pNeg w X

/-- Positive Fitting A2 over admissible extensions. -/
def A2PlusAdm (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w (X Y : Extension Entity),
    M.admissible X → M.admissible Y →
    M.base.pPos w X → EntailPlus M.base w X Y → M.base.pPos w Y

/-- Positive essence in the selected extensional domain. -/
def EssPlusAdm
    (M : AdmissibleSemantics World Entity)
    (w : World) (X : Extension Entity) (x : Entity) : Prop :=
  M.admissible X ∧
  X.pos x ∧
  ∀ Y : Extension Entity,
    M.admissible Y → Y.pos x → EntailPlus M.base w X Y

/-- Explicit negative evidence for admissible-domain Fitting essence. -/
def EssMinusAdm
    (M : AdmissibleSemantics World Entity)
    (w : World) (X : Extension Entity) (x : Entity) : Prop :=
  X.neg x ∨
  ∃ Y : Extension Entity,
    M.admissible Y ∧ Y.pos x ∧ EntailMinus M.base w X Y

/-- Positive necessary existence over admissible extensional essences. -/
def NEPlusAdm
    (M : AdmissibleSemantics World Entity)
    (w : World) (x : Entity) : Prop :=
  ∀ X : Extension Entity,
    EssPlusAdm M w X x → BoxExistsPlus M.base w X

/-- Explicit negative evidence for admissible-domain necessary existence. -/
def NEMinusAdm
    (M : AdmissibleSemantics World Entity)
    (w : World) (x : Entity) : Prop :=
  ∃ X : Extension Entity,
    EssPlusAdm M w X x ∧ BoxExistsMinus M.base w X

/-- Explicit negative evidence against admissible-domain Godlikeness. -/
def GodMinusAdm
    (M : AdmissibleSemantics World Entity) (w : World) (x : Entity) : Prop :=
  ∃ X : Extension Entity,
    M.admissible X ∧ M.base.pPos w X ∧ X.neg x

/-- Relevant positivity completeness, restricted to admissible extensions. -/
def CompPGAdm (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w x (Y : Extension Entity),
    M.admissible Y → GodPlusAdm M w x → Y.pos x →
    M.base.pPos w Y ∨ M.base.pNeg w Y

/-- Relevant exemplification consistency, restricted to admissible extensions. -/
def ConsGGAdm (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ w x (Y : Extension Entity),
    M.admissible Y → GodPlusAdm M w x → Y.pos x → ¬ Y.neg x

/-- Non-vacuous candidate recovery package for the admissible Fitting lift. -/
def RegGAdm (M : AdmissibleSemantics World Entity) : Prop :=
  CompPGAdm M ∧ ConsGGAdm M

/--
Admissible-domain Fitting T2 analogue.

Unlike the unrestricted theorem, this route does not quantify over every
bilateral support assignment. No positivity-rigidity premise is required.
-/
theorem god_has_currentExtension_essence_admissible
    (M : AdmissibleSemantics World Entity)
    (hGAdm : GAdmissible M)
    (hReal : GRealizationAdm M)
    (hA1L : A1LAdm M)
    (hReg : RegGAdm M) :
    ∀ w x, GodPlusAdm M w x →
      EssPlusAdm M w (extensionAt M.base.G w) x := by
  intro w x hGodX
  constructor
  · exact hGAdm w
  constructor
  · exact (hReal w x).2 hGodX
  · intro Y hYAdm hYx
    have hPY : M.base.pPos w Y := by
      rcases hReg.1 w x Y hYAdm hGodX hYx with hPos | hNeg
      · exact hPos
      · have hNotYAdm : M.admissible Y.negate := M.negate_closed Y hYAdm
        have hPNotY : M.base.pPos w Y.negate := hA1L w Y hYAdm hNeg
        have hNotYx : Y.negate.pos x := hGodX Y.negate hNotYAdm hPNotY
        have hNoNegY : ¬ Y.neg x := hReg.2 w x Y hYAdm hGodX hYx
        exact False.elim (hNoNegY hNotYx)
    intro z hwz y hyExists hGy
    have hGodY : GodPlusAdm M w y := (hReal w y).1 hGy
    exact hGodY Y hYAdm hPY

/-- Classical coherence only on the selected extensional property domain. -/
def ExtensionClassicalAdm (M : AdmissibleSemantics World Entity) : Prop :=
  ∀ (X : Extension Entity), M.admissible X →
    ∀ x : Entity, X.neg x ↔ ¬ X.pos x

/-- Classical recovery of admissible-domain Godlikeness. -/
theorem godMinusAdm_iff_not_godPlusAdm
    (M : AdmissibleSemantics World Entity)
    (hExt : ExtensionClassicalAdm M)
    (w : World) (x : Entity) :
    GodMinusAdm M w x ↔ ¬ GodPlusAdm M w x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨X, hAdm, hPX, hXNeg⟩
    have hXPos : X.pos x := hPlus X hAdm hPX
    exact (hExt X hAdm x).1 hXNeg hXPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro X hAdm hPX
    apply Classical.byContradiction
    intro hNoXPos
    have hXNeg : X.neg x := (hExt X hAdm x).2 hNoXPos
    exact hNoMinus ⟨X, hAdm, hPX, hXNeg⟩

/-- Classical recovery of admissible-domain Fitting essence. -/
theorem essMinusAdm_iff_not_essPlusAdm
    (M : AdmissibleSemantics World Entity)
    (hExt : ExtensionClassicalAdm M)
    (w : World) (X : Extension Entity) (x : Entity)
    (hXAdm : M.admissible X) :
    EssMinusAdm M w X x ↔ ¬ EssPlusAdm M w X x := by
  constructor
  · intro hMinus hPlus
    cases hMinus with
    | inl hXNeg =>
        exact (hExt X hXAdm x).1 hXNeg hPlus.2.1
    | inr hBad =>
        rcases hBad with ⟨Y, hYAdm, hYPos, hEntMinus⟩
        have hEntPlus : EntailPlus M.base w X Y := hPlus.2.2 Y hYAdm hYPos
        rcases hEntMinus with ⟨z, hwz, y, hyExists, hXPos, hYNeg⟩
        have hYPos' : Y.pos y := hEntPlus z hwz y hyExists hXPos
        exact (hExt Y hYAdm y).1 hYNeg hYPos'
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    constructor
    · exact hXAdm
    constructor
    · apply Classical.byContradiction
      intro hNoXPos
      have hXNeg : X.neg x := (hExt X hXAdm x).2 hNoXPos
      exact hNoMinus (Or.inl hXNeg)
    · intro Y hYAdm hYPos
      apply Classical.byContradiction
      intro hNoEnt
      have hEntMinus : EntailMinus M.base w X Y := by
        apply Classical.byContradiction
        intro hNoMinusEnt
        apply hNoEnt
        intro z hwz y hyExists hXPos
        apply Classical.byContradiction
        intro hNoYPos
        have hYNeg : Y.neg y := (hExt Y hYAdm y).2 hNoYPos
        exact hNoMinusEnt ⟨z, hwz, y, hyExists, hXPos, hYNeg⟩
      exact hNoMinus (Or.inr ⟨Y, hYAdm, hYPos, hEntMinus⟩)

/-- Classical recovery of admissible-domain necessary existence. -/
theorem neMinusAdm_iff_not_nePlusAdm
    (M : AdmissibleSemantics World Entity)
    (hExt : ExtensionClassicalAdm M)
    (w : World) (x : Entity) :
    NEMinusAdm M w x ↔ ¬ NEPlusAdm M w x := by
  constructor
  · intro hMinus hPlus
    rcases hMinus with ⟨X, hEss, hBoxMinus⟩
    have hBoxPlus : BoxExistsPlus M.base w X := hPlus X hEss
    rcases hBoxMinus with ⟨z, hwz, hAllNeg⟩
    rcases hBoxPlus z hwz with ⟨y, hyExists, hXPos⟩
    have hXNeg : X.neg y := hAllNeg y hyExists
    exact (hExt X hEss.1 y).1 hXNeg hXPos
  · intro hNotPlus
    apply Classical.byContradiction
    intro hNoMinus
    apply hNotPlus
    intro X hEss
    apply Classical.byContradiction
    intro hNoBox
    have hBoxMinus : BoxExistsMinus M.base w X := by
      apply Classical.byContradiction
      intro hNoMinusBox
      apply hNoBox
      intro z hwz
      apply Classical.byContradiction
      intro hNoWitness
      have hAllNeg : ∀ y, M.base.Exists z y → X.neg y := by
        intro y hyExists
        have hNoXPos : ¬ X.pos y := by
          intro hXPos
          exact hNoWitness ⟨y, hyExists, hXPos⟩
        exact (hExt X hEss.1 y).2 hNoXPos
      exact hNoMinusBox ⟨z, hwz, hAllNeg⟩
    exact hNoMinus ⟨X, hEss, hBoxMinus⟩

end Goedel4PEL.GoedelScott.Fitting
