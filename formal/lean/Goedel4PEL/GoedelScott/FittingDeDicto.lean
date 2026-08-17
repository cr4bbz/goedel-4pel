import Goedel4PEL.GoedelScott.FittingNecessaryExistence

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- Positive de-dicto possibility of an actual Fitting-Godlike individual. -/
def PossibleGodDeDicto
    (M : Semantics World Entity) (w : World) : Prop :=
  ∃ z, M.R w z ∧ ∃ x, M.Exists z x ∧ GodPlus M z x

/-- Positive de-dicto necessary actual Fitting-Godlike existence. -/
def NecessaryGodDeDicto
    (M : Semantics World Entity) (w : World) : Prop :=
  ∀ z, M.R w z → ∃ x, M.Exists z x ∧ GodPlus M z x

/--
The distinguished Godlikeness intension keeps the same bilateral extension
along accessibility edges.

This bridge is deliberately explicit. The de-re theorem does not need it;
it is only what allows a frozen current extension to be identified with the
re-evaluated extension occurring in de-dicto claims.
-/
def GExtensionStableAlongR (M : Semantics World Entity) : Prop :=
  ∀ w z, M.R w z →
    ExtensionEquivalent (extensionAt M.G w) (extensionAt M.G z)

/-- Under extension stability, de-dicto possibility yields de-re possibility. -/
theorem possibleGodDeDicto_implies_possibleCurrent
    (M : Semantics World Entity)
    (hGReal : GRealization M)
    (hStable : GExtensionStableAlongR M) :
    ∀ w, PossibleGodDeDicto M w → PossibleCurrentGodExtension M w := by
  intro w hPossible
  rcases hPossible with ⟨z, hwz, x, hxExists, hGodZ⟩
  have hGz : (extensionAt M.G z).pos x := (hGReal z x).2 hGodZ
  have hGw : (extensionAt M.G w).pos x :=
    ((hStable w z hwz x).1).2 hGz
  exact ⟨z, hwz, x, hxExists, hGw⟩

/-- Under extension stability, de-re necessity yields de-dicto necessity. -/
theorem necessaryCurrent_implies_necessaryGodDeDicto
    (M : Semantics World Entity)
    (hGReal : GRealization M)
    (hStable : GExtensionStableAlongR M) :
    ∀ w, NecessaryCurrentGodExtension M w → NecessaryGodDeDicto M w := by
  intro w hNecessary z hwz
  rcases hNecessary z hwz with ⟨x, hxExists, hGw⟩
  have hGz : (extensionAt M.G z).pos x :=
    ((hStable w z hwz x).1).1 hGw
  have hGodZ : GodPlus M z x := (hGReal z x).1 hGz
  exact ⟨x, hxExists, hGodZ⟩

/--
Fitting de-dicto possibility-to-necessity theorem under explicit G-extension
stability.

No frame condition is used. The additional premise is not modal symmetry or
transitivity but stability of the intension/extension interface along R.
-/
theorem possibleGodDeDicto_implies_necessary
    (M : Semantics World Entity)
    (NE : Intension World Entity)
    (hGReal : GRealization M)
    (hA1L : A1L M)
    (hReg : RegG M)
    (hNEReal : NERealization M NE)
    (hA5 : A5Plus M NE)
    (hStable : GExtensionStableAlongR M) :
    ∀ w, PossibleGodDeDicto M w → NecessaryGodDeDicto M w := by
  intro w hPossible
  have hCurrentPossible : PossibleCurrentGodExtension M w :=
    possibleGodDeDicto_implies_possibleCurrent M hGReal hStable w hPossible
  have hCurrentNecessary : NecessaryCurrentGodExtension M w :=
    possibleCurrentGodExtension_implies_necessary
      M NE hGReal hA1L hReg hNEReal hA5 w hCurrentPossible
  exact necessaryCurrent_implies_necessaryGodDeDicto
    M hGReal hStable w hCurrentNecessary

end Goedel4PEL.GoedelScott.Fitting
