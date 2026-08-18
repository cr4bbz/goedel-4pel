from __future__ import annotations

from dataclasses import dataclass
from enum import Enum
from itertools import product
from typing import Any, Dict, Iterable, Tuple


class CheckFailed(Exception):
    """Raised when a finite-model check fails."""


def require(condition: object, detail: Any = "") -> None:
    """Assert a verification condition without using ``assert``.

    The finite layer is evidence, not documentation, so its checks must not be
    removable. ``python -O`` strips ``assert`` statements, which would let every
    gate script report success while checking nothing.
    """

    if not condition:
        raise CheckFailed(str(detail) if detail else "check failed")


class Val(Enum):
    T = (1, 0)
    F = (0, 1)
    B = (1, 1)
    N = (0, 0)

    @property
    def pos(self) -> bool:
        return bool(self.value[0])

    @property
    def neg(self) -> bool:
        return bool(self.value[1])

    def negate(self) -> "Val":
        return Val((self.value[1], self.value[0]))


World = str
Entity = str
Prop = str


@dataclass(frozen=True)
class FiniteModel:
    worlds: Tuple[World, ...]
    entities: Tuple[Entity, ...]
    properties: Tuple[Prop, ...]
    complement: Dict[Prop, Prop]
    access: frozenset[tuple[World, World]]
    exists: frozenset[tuple[World, Entity]]
    extension: Dict[tuple[World, Entity, Prop], Val]
    positivity: Dict[tuple[World, Prop], Val]

    def accessible(self, w: World) -> Iterable[World]:
        return (v for v in self.worlds if (w, v) in self.access)

    def val(self, w: World, x: Entity, p: Prop) -> Val:
        return self.extension[(w, x, p)]

    def pval(self, w: World, p: Prop) -> Val:
        return self.positivity[(w, p)]

    def nent_plus(self, w: World, p: Prop, q: Prop) -> bool:
        return all(
            not (self.val(v, x, p).pos and not self.val(v, x, q).pos)
            for v in self.accessible(w)
            for x in self.entities
            if (v, x) in self.exists
        )

    def nent_minus(self, w: World, p: Prop, q: Prop) -> bool:
        return any(
            self.val(v, x, p).pos and self.val(v, x, q).neg
            for v in self.accessible(w)
            for x in self.entities
            if (v, x) in self.exists
        )

    def god_plus_derived(self, w: World, x: Entity) -> bool:
        return all(
            (not self.pval(w, p).pos) or self.val(w, x, p).pos
            for p in self.properties
        )

    def god_minus_derived(self, w: World, x: Entity) -> bool:
        return any(
            self.pval(w, p).pos and self.val(w, x, p).neg
            for p in self.properties
        )

    def essence_plus(self, w: World, essence: Prop, x: Entity) -> bool:
        if not self.val(w, x, essence).pos:
            return False
        return all(
            (not self.val(w, x, q).pos) or self.nent_plus(w, essence, q)
            for q in self.properties
        )

    def strong_a1(self) -> bool:
        return all(
            self.pval(w, self.complement[p]) == self.pval(w, p).negate()
            for w in self.worlds
            for p in self.properties
        )

    def r_plus(self) -> bool:
        return all(
            (not self.pval(w, p).pos)
            or all(self.pval(v, p).pos for v in self.accessible(w))
            for w in self.worlds
            for p in self.properties
        )

    def a2_plus(self) -> bool:
        return all(
            (not (self.pval(w, p).pos and self.nent_plus(w, p, q)))
            or self.pval(w, q).pos
            for w in self.worlds
            for p in self.properties
            for q in self.properties
        )

    def a3_t(self) -> bool:
        return all(self.pval(w, "G") == Val.T for w in self.worlds)

    def complement_extensions(self) -> bool:
        return all(
            self.val(w, x, self.complement[p]) == self.val(w, x, p).negate()
            for w in self.worlds
            for x in self.entities
            for p in self.properties
        )

    def g_sup_definition(self) -> bool:
        return all(
            self.val(w, x, "G").pos == self.god_plus_derived(w, x)
            and self.val(w, x, "G").neg == self.god_minus_derived(w, x)
            for w in self.worlds
            for x in self.entities
        )

    def t2_plus(self) -> bool:
        return all(
            (not self.val(w, x, "G").pos) or self.essence_plus(w, "G", x)
            for w in self.worlds
            for x in self.entities
        )

    def comp_p_g(self) -> bool:
        return all(
            (not (self.val(w, x, "G").pos and self.val(w, x, p).pos))
            or self.pval(w, p).pos
            or self.pval(w, p).neg
            for w in self.worlds
            for x in self.entities
            for p in self.properties
        )

    def cons_g_g(self) -> bool:
        return all(
            (not (self.val(w, x, "G").pos and self.val(w, x, p).pos))
            or not self.val(w, x, p).neg
            for w in self.worlds
            for x in self.entities
            for p in self.properties
        )

    def reg_g(self) -> bool:
        return self.comp_p_g() and self.cons_g_g()

    def control_stack(self) -> bool:
        return (
            self.complement_extensions()
            and self.strong_a1()
            and self.r_plus()
            and self.a2_plus()
            and self.a3_t()
            and self.g_sup_definition()
        )


def _base_model(z0: Val, z1: Val, pz: Val) -> FiniteModel:
    worlds = ("w0", "w1")
    entities = ("a",)
    props = ("G", "notG", "Z", "notZ")
    comp = {"G": "notG", "notG": "G", "Z": "notZ", "notZ": "Z"}
    access = frozenset((w, v) for w in worlds for v in worlds)
    exists = frozenset((w, "a") for w in worlds)

    # G is supplied as part of the valuation and checked against G-sup-v0.1.
    g0 = Val.B if z0 == Val.B and pz == Val.F else Val.T
    g1 = Val.T
    ext = {
        ("w0", "a", "G"): g0,
        ("w1", "a", "G"): g1,
        ("w0", "a", "notG"): g0.negate(),
        ("w1", "a", "notG"): g1.negate(),
        ("w0", "a", "Z"): z0,
        ("w1", "a", "Z"): z1,
        ("w0", "a", "notZ"): z0.negate(),
        ("w1", "a", "notZ"): z1.negate(),
    }
    positivity = {}
    for w in worlds:
        positivity[(w, "G")] = Val.T
        positivity[(w, "notG")] = Val.F
        positivity[(w, "Z")] = pz
        positivity[(w, "notZ")] = pz.negate()
    return FiniteModel(worlds, entities, props, comp, access, exists, ext, positivity)


def t2_glut_countermodel() -> FiniteModel:
    return _base_model(Val.B, Val.F, Val.F)


def t2_gap_countermodel() -> FiniteModel:
    return _base_model(Val.T, Val.N, Val.N)


def mc_plus_formula(vals: Dict[World, Val], access: frozenset[tuple[World, World]]) -> bool:
    worlds = tuple(vals)
    return all(
        (not vals[w].pos)
        or all(vals[v].pos for v in worlds if (w, v) in access)
        for w in worlds
    )


def mc_minus_formula(vals: Dict[World, Val], access: frozenset[tuple[World, World]]) -> bool:
    worlds = tuple(vals)
    return all(
        (not vals[w].neg)
        or all(vals[v].neg for v in worlds if (w, v) in access)
        for w in worlds
    )


def exhaustive_mc_schema_equivalence_two_world_s5() -> int:
    """Check the schemata on a negation-closed formula family {p, not p}.

    MC+ and MC- are not pointwise identical for one isolated formula. Their
    equivalence uses substitution chi := not phi, so the finite regression must
    carry the negated formula as part of the formula domain.
    """
    worlds = ("w0", "w1")
    access = frozenset((w, v) for w in worlds for v in worlds)
    checked = 0
    for pair in product(Val, repeat=2):
        pvals = dict(zip(worlds, pair))
        npvals = {w: v.negate() for w, v in pvals.items()}
        mc_plus_schema = all(
            mc_plus_formula(vals, access) for vals in (pvals, npvals)
        )
        mc_minus_schema = all(
            mc_minus_formula(vals, access) for vals in (pvals, npvals)
        )
        require(mc_plus_schema == mc_minus_schema)
        checked += 1
    return checked


def exhaustive_reg_g_implies_t2() -> int:
    """Exhaust the small two-world/one-entity G,Z fragment.

    We enforce complement extensions and Scott-control positivity of G, then
    retain only models satisfying strong A1, R+, G-sup-v0.1 and REG_G. Every
    retained model must satisfy T2+.
    """
    checked = 0
    worlds = ("w0", "w1")
    for g0, g1, z0, z1, pz0, pz1 in product(Val, repeat=6):
        props = ("G", "notG", "Z", "notZ")
        comp = {"G": "notG", "notG": "G", "Z": "notZ", "notZ": "Z"}
        access = frozenset((w, v) for w in worlds for v in worlds)
        exists = frozenset((w, "a") for w in worlds)
        ext = {
            ("w0", "a", "G"): g0,
            ("w1", "a", "G"): g1,
            ("w0", "a", "notG"): g0.negate(),
            ("w1", "a", "notG"): g1.negate(),
            ("w0", "a", "Z"): z0,
            ("w1", "a", "Z"): z1,
            ("w0", "a", "notZ"): z0.negate(),
            ("w1", "a", "notZ"): z1.negate(),
        }
        positivity = {
            ("w0", "G"): Val.T,
            ("w1", "G"): Val.T,
            ("w0", "notG"): Val.F,
            ("w1", "notG"): Val.F,
            ("w0", "Z"): pz0,
            ("w1", "Z"): pz1,
            ("w0", "notZ"): pz0.negate(),
            ("w1", "notZ"): pz1.negate(),
        }
        m = FiniteModel(worlds, ("a",), props, comp, access, exists, ext, positivity)
        if m.strong_a1() and m.r_plus() and m.g_sup_definition() and m.reg_g():
            checked += 1
            require(m.t2_plus(), (g0, g1, z0, z1, pz0, pz1))
    return checked


if __name__ == "__main__":
    glut = t2_glut_countermodel()
    gap = t2_gap_countermodel()
    require(glut.control_stack() and not glut.t2_plus())
    require(gap.control_stack() and not gap.t2_plus())
    mc_cases = exhaustive_mc_schema_equivalence_two_world_s5()
    reg_models = exhaustive_reg_g_implies_t2()
    print("Gate 7 finite checks: OK")
    print(
        "  T2 glut countermodel: validated "
        f"(CONS_G^G={glut.cons_g_g()}, COMP_P^G={glut.comp_p_g()})"
    )
    print(
        "  T2 gap countermodel:  validated "
        f"(CONS_G^G={gap.cons_g_g()}, COMP_P^G={gap.comp_p_g()})"
    )
    print(f"  MC schema-equivalence assignments checked: {mc_cases}")
    print(f"  REG_G models satisfying antecedent and checked for T2+: {reg_models}")
