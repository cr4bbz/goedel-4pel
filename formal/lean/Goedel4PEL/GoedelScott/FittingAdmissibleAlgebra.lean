import Goedel4PEL.GoedelScott.FittingAdmissibleStructure

namespace Goedel4PEL.GoedelScott.Fitting

universe u v

variable {World : Type u} {Entity : Type v}

/-- Pointwise FDE conjunction of bilateral rigid extensions. -/
def Extension.fdeConj (X Y : Extension Entity) : Extension Entity :=
  ⟨fun x => X.pos x ∧ Y.pos x, fun x => X.neg x ∨ Y.neg x⟩

/-- Pointwise FDE disjunction of bilateral rigid extensions. -/
def Extension.fdeDisj (X Y : Extension Entity) : Extension Entity :=
  ⟨fun x => X.pos x ∨ Y.pos x, fun x => X.neg x ∧ Y.neg x⟩

/-- Constant top extension in the FDE extension algebra. -/
def Extension.fdeTop : Extension Entity :=
  ⟨fun _ => True, fun _ => False⟩

/-- Constant bottom extension in the FDE extension algebra. -/
def Extension.fdeBot : Extension Entity :=
  ⟨fun _ => False, fun _ => True⟩

/-- One bilateral extension respects one positive-profile quotient at one world. -/
def RespectsProfileAt
    (M : AdmissibleSemantics World Entity)
    (w : World) (Y : Extension Entity) : Prop :=
  ∀ x y,
    PositiveProfileEqAdm M w x y →
    (Y.pos x ↔ Y.pos y) ∧ (Y.neg x ↔ Y.neg y)

end Goedel4PEL.GoedelScott.Fitting
