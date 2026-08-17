namespace Goedel4PEL.GoedelScott.Fitting

universe u v

/--
A bilateral extension is world-independent support information about which
entities fall under a property extension.

This type corresponds to the extensional side of the Fitting comparison. It is
kept distinct from an intension at the Lean type level so that later Fitting
proofs cannot silently identify the two notions.
-/
structure Extension (Entity : Type v) where
  pos : Entity → Prop
  neg : Entity → Prop

/--
An intensional property maps each world to its extension at that world.
-/
abbrev Intension (World : Type u) (Entity : Type v) :=
  World → Extension Entity

variable {World : Type u} {Entity : Type v}

/-- Evaluate an intensional property at a world to obtain its extension. -/
def extensionAt
    (φ : Intension World Entity) (w : World) : Extension Entity :=
  φ w

/-- Rigidly intensionalize one extension by keeping it fixed at every world. -/
def rigidify
    (X : Extension Entity) : Intension World Entity :=
  fun _ => X

@[simp]
theorem extensionAt_rigidify
    (X : Extension Entity) (w : World) :
    extensionAt (rigidify (World := World) X) w = X := by
  rfl

/-- Positive exemplification of an intensional property at one world. -/
def IntensionExPos
    (φ : Intension World Entity) (w : World) (x : Entity) : Prop :=
  (extensionAt φ w).pos x

/-- Negative exemplification of an intensional property at one world. -/
def IntensionExNeg
    (φ : Intension World Entity) (w : World) (x : Entity) : Prop :=
  (extensionAt φ w).neg x

/-- Extensional equivalence of bilateral extensions. -/
def ExtensionEquivalent
    (X Y : Extension Entity) : Prop :=
  ∀ x, (X.pos x ↔ Y.pos x) ∧ (X.neg x ↔ Y.neg x)

/-- Two intensions have the same bilateral extension at one selected world. -/
def SameExtensionAt
    (w : World) (φ ψ : Intension World Entity) : Prop :=
  ExtensionEquivalent (extensionAt φ w) (extensionAt ψ w)

/-- Bilateral equivalence of intensions at every world. -/
def IntensionEquivalent
    (φ ψ : Intension World Entity) : Prop :=
  ∀ w, SameExtensionAt w φ ψ

/-- Intensional equivalence entails extensional equivalence at each world. -/
theorem intensionEquivalent_sameExtensionAt
    {φ ψ : Intension World Entity}
    (h : IntensionEquivalent φ ψ) (w : World) :
    SameExtensionAt w φ ψ := by
  exact h w

/--
Minimal semantic shell for the Fitting comparison.

The critical typing choice is that positivity consumes an `Extension Entity`,
not an `Intension World Entity`. World-indexing remains on the positivity
support predicate itself, matching the existing bilateral project style while
preserving the literature's intension/extension distinction.
-/
structure Semantics (World : Type u) (Entity : Type v) where
  R : World → World → Prop
  Exists : World → Entity → Prop
  pPos : World → Extension Entity → Prop
  pNeg : World → Extension Entity → Prop
  G : Intension World Entity

/-- Positive support for the current extension of an intensional property. -/
def PositiveCurrentExtension
    (M : Semantics World Entity)
    (w : World) (φ : Intension World Entity) : Prop :=
  M.pPos w (extensionAt φ w)

/--
Fitting-style positive Godlikeness at the extension level: every positively
supported extension contains the individual positively.

This is only the positive Godlikeness interface. Essence, necessary existence,
and a bilateral negative clause are deliberately deferred until their exact
extension-level interfaces are frozen.
-/
def GodPlus
    (M : Semantics World Entity) (w : World) (x : Entity) : Prop :=
  ∀ X : Extension Entity, M.pPos w X → X.pos x

/-- The distinguished intensional property `G` realizes extension-level Godlikeness. -/
def GRealization (M : Semantics World Entity) : Prop :=
  ∀ w x, IntensionExPos M.G w x ↔ GodPlus M w x

/--
The Fitting positivity interface cannot distinguish two intensions whose
current extensions are literally identical.
-/
theorem positiveCurrentExtension_congr
    (M : Semantics World Entity)
    {w : World} {φ ψ : Intension World Entity}
    (h : extensionAt φ w = extensionAt ψ w) :
    PositiveCurrentExtension M w φ ↔ PositiveCurrentExtension M w ψ := by
  simp [PositiveCurrentExtension, h]

/--
Likewise, positive exemplification at a world depends only on the extension at
that world, not on the intension's values elsewhere.
-/
theorem intensionExPos_congr
    {w : World} {x : Entity} {φ ψ : Intension World Entity}
    (h : extensionAt φ w = extensionAt ψ w) :
    IntensionExPos φ w x ↔ IntensionExPos ψ w x := by
  simp [IntensionExPos, h]

end Goedel4PEL.GoedelScott.Fitting
