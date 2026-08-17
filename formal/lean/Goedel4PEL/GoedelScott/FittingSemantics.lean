import Goedel4PEL.GoedelScott.FittingTypes

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- FDE negation of a bilateral extension swaps positive and negative support. -/
def Extension.negate (X : Extension Entity) : Extension Entity :=
  ⟨X.neg, X.pos⟩

@[simp]
theorem Extension.negate_pos (X : Extension Entity) (x : Entity) :
    X.negate.pos x ↔ X.neg x := by
  rfl

@[simp]
theorem Extension.negate_neg (X : Extension Entity) (x : Entity) :
    X.negate.neg x ↔ X.pos x := by
  rfl

@[simp]
theorem Extension.negate_involutive (X : Extension Entity) :
    X.negate.negate = X := by
  cases X
  rfl

/--
Positive Fitting entailment between rigid extensions.

This is the bilateral positive-support reconstruction of Fitting's extensional
relation `X V Y := Box (forall^E z. X z -> Y z)`.
-/
def EntailPlus
    (M : Semantics World Entity)
    (w : World) (X Y : Extension Entity) : Prop :=
  ∀ z, M.R w z → ∀ x, M.Exists z x → X.pos x → Y.pos x

/-- Explicit negative evidence against Fitting extensional entailment. -/
def EntailMinus
    (M : Semantics World Entity)
    (w : World) (X Y : Extension Entity) : Prop :=
  ∃ z, M.R w z ∧ ∃ x, M.Exists z x ∧ X.pos x ∧ Y.neg x

/-- Fitting A1, left information-flow direction, now typed over extensions. -/
def A1L (M : Semantics World Entity) : Prop :=
  ∀ w (X : Extension Entity), M.pNeg w X → M.pPos w X.negate

/-- Fitting A1, right information-flow direction. -/
def A1R (M : Semantics World Entity) : Prop :=
  ∀ w (X : Extension Entity), M.pPos w X.negate → M.pNeg w X

/-- Positive Fitting A2 over extensional necessary entailment. -/
def A2Plus (M : Semantics World Entity) : Prop :=
  ∀ w (X Y : Extension Entity),
    M.pPos w X → EntailPlus M w X Y → M.pPos w Y

/--
Positive Fitting essence of an individual by a rigid extension.

The extension itself contains the individual positively, and necessarily
entails every rigid extension that also contains the individual positively.
-/
def EssPlus
    (M : Semantics World Entity)
    (w : World) (X : Extension Entity) (x : Entity) : Prop :=
  X.pos x ∧
  ∀ Y : Extension Entity, Y.pos x → EntailPlus M w X Y

/-- Explicit negative evidence for Fitting essence. -/
def EssMinus
    (M : Semantics World Entity)
    (w : World) (X : Extension Entity) (x : Entity) : Prop :=
  X.neg x ∨
  ∃ Y : Extension Entity, Y.pos x ∧ EntailMinus M w X Y

/-- Positive necessary actual exemplification of one rigid extension. -/
def BoxExistsPlus
    (M : Semantics World Entity)
    (w : World) (X : Extension Entity) : Prop :=
  ∀ z, M.R w z → ∃ x, M.Exists z x ∧ X.pos x

/-- Negative support for necessary actual exemplification of one extension. -/
def BoxExistsMinus
    (M : Semantics World Entity)
    (w : World) (X : Extension Entity) : Prop :=
  ∃ z, M.R w z ∧ ∀ x, M.Exists z x → X.neg x

/-- Fitting-style positive necessary existence. -/
def NEPlus
    (M : Semantics World Entity)
    (w : World) (x : Entity) : Prop :=
  ∀ X : Extension Entity, EssPlus M w X x → BoxExistsPlus M w X

/-- Explicit negative evidence for Fitting-style necessary existence. -/
def NEMinus
    (M : Semantics World Entity)
    (w : World) (x : Entity) : Prop :=
  ∃ X : Extension Entity, EssPlus M w X x ∧ BoxExistsMinus M w X

/-- Relevant positivity completeness at positive Fitting-Godlike witnesses. -/
def CompPG (M : Semantics World Entity) : Prop :=
  ∀ w x (Y : Extension Entity), GodPlus M w x → Y.pos x →
    M.pPos w Y ∨ M.pNeg w Y

/-- Relevant extension-membership consistency at positive Fitting-Godlike witnesses. -/
def ConsGG (M : Semantics World Entity) : Prop :=
  ∀ w x (Y : Extension Entity), GodPlus M w x → Y.pos x → ¬ Y.neg x

/-- Gate-8 regularity package for the unrestricted Fitting comparison. -/
def RegG (M : Semantics World Entity) : Prop :=
  CompPG M ∧ ConsGG M

/-- The everywhere-glutty bilateral extension. -/
def universalGlutExtension : Extension Entity :=
  ⟨fun _ => True, fun _ => True⟩

/--
Unrestricted bilateral comprehension makes `ConsGG` incompatible with any
positive Fitting-Godlike individual.

The witness is the admissible-by-type universal glut extension itself: it
contains every individual both positively and negatively. This theorem exposes
a genuine obstruction in the naive unrestricted extension lift, not a Lean
elaboration artifact.
-/
theorem consGG_excludes_god
    (M : Semantics World Entity)
    (hCons : ConsGG M) :
    ∀ w x, ¬ GodPlus M w x := by
  intro w x hGod
  let B : Extension Entity := universalGlutExtension
  have hNoNeg : ¬ B.neg x := hCons w x B hGod (by trivial)
  exact hNoNeg (by trivial)

/-- Consequently the unrestricted `RegG` recovery package excludes Godlikeness. -/
theorem regG_excludes_god
    (M : Semantics World Entity)
    (hReg : RegG M) :
    ∀ w x, ¬ GodPlus M w x := by
  exact consGG_excludes_god M hReg.2

/--
The current extension of the distinguished intensional `G` is a positive
Fitting essence of every positive Fitting-Godlike individual.

This theorem remains logically valid for the unrestricted lift, but the
`regG_excludes_god` result above shows that its current `RegG` antecedent makes
it unsuitable as a non-vacuous Fitting recovery theorem. Gate 8 therefore
moves the substantive comparison to a selected admissible extension domain.
-/
theorem god_has_currentExtension_essence
    (M : Semantics World Entity)
    (hReal : GRealization M)
    (hA1L : A1L M)
    (hReg : RegG M) :
    ∀ w x, GodPlus M w x → EssPlus M w (extensionAt M.G w) x := by
  intro w x hGodX
  constructor
  · exact (hReal w x).2 hGodX
  · intro Y hYx
    have hPY : M.pPos w Y := by
      rcases hReg.1 w x Y hGodX hYx with hPos | hNeg
      · exact hPos
      · have hPNotY : M.pPos w Y.negate := hA1L w Y hNeg
        have hNotYx : Y.negate.pos x := hGodX Y.negate hPNotY
        have hNoNegY : ¬ Y.neg x := hReg.2 w x Y hGodX hYx
        exact False.elim (hNoNegY hNotYx)
    intro z hwz y hyExists hGy
    have hGodY : GodPlus M w y := (hReal w y).1 hGy
    exact hGodY Y hPY

end Goedel4PEL.GoedelScott.Fitting
