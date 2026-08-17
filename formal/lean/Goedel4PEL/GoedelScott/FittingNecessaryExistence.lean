import Goedel4PEL.GoedelScott.FittingSemantics

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- The distinguished intensional `NE` property realizes Fitting positive NE. -/
def NERealization
    (M : Semantics World Entity)
    (NE : Intension World Entity) : Prop :=
  ∀ w x, IntensionExPos NE w x ↔ NEPlus M w x

/-- Positive Fitting A5 is positivity of the current extension of `NE`. -/
def A5Plus
    (M : Semantics World Entity)
    (NE : Intension World Entity) : Prop :=
  ∀ w, M.pPos w (extensionAt NE w)

/-- Possibilist positive Fitting Godlikeness at one world. -/
def GodPossibilistAt
    (M : Semantics World Entity) (w : World) : Prop :=
  ∃ x, GodPlus M w x

/--
De-re positive possibility of an actual member of the current `G` extension.

The extension is frozen at the evaluation world `w` and then tested at an
accessible world. This mirrors the de-re reading highlighted in the Fitting
formalization and is intentionally distinct from de-dicto possible Godlikeness,
which would re-evaluate `G` at the accessible world.
-/
def PossibleCurrentGodExtension
    (M : Semantics World Entity) (w : World) : Prop :=
  ∃ z, M.R w z ∧ ∃ x, M.Exists z x ∧ (extensionAt M.G w).pos x

/--
De-re positive necessary actual exemplification of the current `G` extension.
-/
def NecessaryCurrentGodExtension
    (M : Semantics World Entity) (w : World) : Prop :=
  BoxExistsPlus M w (extensionAt M.G w)

/--
Every positive Fitting-Godlike individual positively exemplifies the realized
necessary-existence intension when its current extension is positive.
-/
theorem god_has_ne
    (M : Semantics World Entity)
    (NE : Intension World Entity)
    (hA5 : A5Plus M NE) :
    ∀ w x, GodPlus M w x → IntensionExPos NE w x := by
  intro w x hGodX
  exact hGodX (extensionAt NE w) (hA5 w)

/--
A possibilist positive Godlike individual already suffices for de-re necessary
actual exemplification of the current `G` extension.

No modal frame property and no positivity-rigidity premise is used. The proof
combines the Gate-8 Fitting essence theorem with positive A5 and realization of
Fitting necessary existence.
-/
theorem possibilistGod_implies_necessaryCurrentGodExtension
    (M : Semantics World Entity)
    (NE : Intension World Entity)
    (hGReal : GRealization M)
    (hA1L : A1L M)
    (hReg : RegG M)
    (hNEReal : NERealization M NE)
    (hA5 : A5Plus M NE) :
    ∀ w, GodPossibilistAt M w → NecessaryCurrentGodExtension M w := by
  intro w hGod
  rcases hGod with ⟨x, hGodX⟩
  have hNEEx : IntensionExPos NE w x := god_has_ne M NE hA5 w x hGodX
  have hNE : NEPlus M w x := (hNEReal w x).1 hNEEx
  have hEss : EssPlus M w (extensionAt M.G w) x :=
    god_has_currentExtension_essence M hGReal hA1L hReg w x hGodX
  exact hNE (extensionAt M.G w) hEss

/--
De-re possible actual exemplification of the current `G` extension entails
possibilist Godlikeness at the current world.

The actual witness may live only at the accessible world; membership in the
frozen extension itself is world-independent.
-/
theorem possibleCurrentGodExtension_implies_possibilistGod
    (M : Semantics World Entity)
    (hGReal : GRealization M) :
    ∀ w, PossibleCurrentGodExtension M w → GodPossibilistAt M w := by
  intro w hPossible
  rcases hPossible with ⟨z, hwz, x, hxExists, hxG⟩
  exact ⟨x, (hGReal w x).1 hxG⟩

/--
Gate-8 Fitting de-re K-style theorem.

Positive de-re possibility of an actual member of the current Godlikeness
extension entails positive de-re necessary actual exemplification of that same
frozen extension. No reflexivity, symmetry, transitivity, seriality, or other
frame condition is a premise.
-/
theorem possibleCurrentGodExtension_implies_necessary
    (M : Semantics World Entity)
    (NE : Intension World Entity)
    (hGReal : GRealization M)
    (hA1L : A1L M)
    (hReg : RegG M)
    (hNEReal : NERealization M NE)
    (hA5 : A5Plus M NE) :
    ∀ w, PossibleCurrentGodExtension M w → NecessaryCurrentGodExtension M w := by
  intro w hPossible
  have hGod : GodPossibilistAt M w :=
    possibleCurrentGodExtension_implies_possibilistGod M hGReal w hPossible
  exact possibilistGod_implies_necessaryCurrentGodExtension
    M NE hGReal hA1L hReg hNEReal hA5 w hGod

end Goedel4PEL.GoedelScott.Fitting
