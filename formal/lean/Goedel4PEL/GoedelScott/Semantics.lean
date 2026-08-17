namespace Goedel4PEL.GoedelScott

universe u v e

/--
Raw bilateral higher-order semantic interface for the reconstructed Scott theory.
No Scott axiom is built into the structure.
-/
structure Semantics (World : Type u) (Entity : Type v) (Property : Type e) where
  R : World → World → Prop
  Exists : World → Entity → Prop
  exPos : World → Entity → Property → Prop
  exNeg : World → Entity → Property → Prop
  pPos : World → Property → Prop
  pNeg : World → Property → Prop
  negProp : Property → Property
  G : Property

variable {World : Type u} {Entity : Type v} {Property : Type e}

/-- Positive necessary actualist entailment. -/
def NEntPlus (M : Semantics World Entity Property)
    (w : World) (φ ψ : Property) : Prop :=
  ∀ z, M.R w z → ∀ y, M.Exists z y → M.exPos z y φ → M.exPos z y ψ

/-- Negative evidence against necessary actualist entailment. -/
def NEntMinus (M : Semantics World Entity Property)
    (w : World) (φ ψ : Property) : Prop :=
  ∃ z, M.R w z ∧ ∃ y, M.Exists z y ∧ M.exPos z y φ ∧ M.exNeg z y ψ

/-- Support-based positive Godlikeness from Gate 5. -/
def GodPlus (M : Semantics World Entity Property) (w : World) (x : Entity) : Prop :=
  ∀ φ, M.pPos w φ → M.exPos w x φ

/-- Support-based negative Godlikeness from Gate 5. -/
def GodMinus (M : Semantics World Entity Property) (w : World) (x : Entity) : Prop :=
  ∃ φ, M.pPos w φ ∧ M.exNeg w x φ

/-- The distinguished property `G` realizes the support-based Godlikeness definition. -/
def GSup (M : Semantics World Entity Property) : Prop :=
  ∀ w x, M.exPos w x M.G ↔ GodPlus M w x

/-- Positive exemplification of a negated property is negative exemplification of the original. -/
def NegExemplification (M : Semantics World Entity Property) : Prop :=
  ∀ w x φ, M.exPos w x (M.negProp φ) ↔ M.exNeg w x φ

/-- Scott A1, left information-flow direction. -/
def A1L (M : Semantics World Entity Property) : Prop :=
  ∀ w φ, M.pNeg w φ → M.pPos w (M.negProp φ)

/-- Positive rigidity of positivity. -/
def RPlus (M : Semantics World Entity Property) : Prop :=
  ∀ w φ, M.pPos w φ → ∀ z, M.R w z → M.pPos z φ

/-- Relevant positivity completeness at positive God-like exemplifications. -/
def CompPG (M : Semantics World Entity Property) : Prop :=
  ∀ w x ψ, GodPlus M w x → M.exPos w x ψ →
    M.pPos w ψ ∨ M.pNeg w ψ

/-- Relevant exemplification consistency at positive God-like exemplifications. -/
def ConsGG (M : Semantics World Entity Property) : Prop :=
  ∀ w x ψ, GodPlus M w x → M.exPos w x ψ →
    ¬ M.exNeg w x ψ

/-- Gate-6 regularity package. -/
def RegG (M : Semantics World Entity Property) : Prop :=
  CompPG M ∧ ConsGG M

/-- Positive bilateral essence from `Ess-sup-v0.1`. -/
def EssPlus (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  M.exPos w x φ ∧
  ∀ ψ, M.exPos w x ψ → NEntPlus M w φ ψ

/-- Negative bilateral essence from `Ess-sup-v0.1`. -/
def EssMinus (M : Semantics World Entity Property)
    (w : World) (φ : Property) (x : Entity) : Prop :=
  M.exNeg w x φ ∨
  ∃ ψ, M.exPos w x ψ ∧ NEntMinus M w φ ψ

/-- Positive Scott T2 target. -/
def T2Plus (M : Semantics World Entity Property) : Prop :=
  ∀ w x, GodPlus M w x → EssPlus M w M.G x

/-- `D1+` is immediate once the distinguished property realizes `G-sup-v0.1`. -/
theorem d1Plus_of_gSup
    (M : Semantics World Entity Property) (hG : GSup M)
    {w : World} {x : Entity} {φ : Property}
    (hGx : M.exPos w x M.G) (hPφ : M.pPos w φ) :
    M.exPos w x φ := by
  exact (hG w x).1 hGx φ hPφ

end Goedel4PEL.GoedelScott
