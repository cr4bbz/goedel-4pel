from __future__ import annotations

from itertools import product
from typing import Dict, Iterator

from checker import FiniteModel, Val


def a1_l(model: FiniteModel) -> bool:
    return all(
        (not model.pval(w, p).neg)
        or model.pval(w, model.complement[p]).pos
        for w in model.worlds
        for p in model.properties
    )


def possible_exemplification(model: FiniteModel, w: str, p: str) -> bool:
    return any(
        model.val(v, x, p).pos
        for v in model.accessible(w)
        for x in model.entities
        if (v, x) in model.exists
    )


def t1_glut_countermodel() -> FiniteModel:
    worlds = ("w0",)
    properties = ("A", "notA")
    complement = {"A": "notA", "notA": "A"}
    access = frozenset({("w0", "w0")})
    positivity = {
        ("w0", "A"): Val.B,
        ("w0", "notA"): Val.B,
    }
    return FiniteModel(
        worlds=worlds,
        entities=(),
        properties=properties,
        complement=complement,
        access=access,
        exists=frozenset(),
        extension={},
        positivity=positivity,
    )


def validate_t1_glut_countermodel() -> bool:
    m = t1_glut_countermodel()
    return (
        m.strong_a1()
        and m.a2_plus()
        and m.pval("w0", "A").pos
        and m.pval("w0", "A").neg
        and not possible_exemplification(m, "w0", "A")
    )


def _t2_minimality_models() -> Iterator[FiniteModel]:
    worlds = ("w0", "w1")
    properties = ("G", "notG", "Z", "notZ")
    complement = {"G": "notG", "notG": "G", "Z": "notZ", "notZ": "Z"}
    access = frozenset((w, v) for w in worlds for v in worlds)
    exists = frozenset((w, "a") for w in worlds)

    for g0, g1, z0, z1 in product(Val, repeat=4):
        extension = {
            ("w0", "a", "G"): g0,
            ("w1", "a", "G"): g1,
            ("w0", "a", "notG"): g0.negate(),
            ("w1", "a", "notG"): g1.negate(),
            ("w0", "a", "Z"): z0,
            ("w1", "a", "Z"): z1,
            ("w0", "a", "notZ"): z0.negate(),
            ("w1", "a", "notZ"): z1.negate(),
        }
        for pz0, pnz0, pz1, pnz1 in product(Val, repeat=4):
            positivity = {
                ("w0", "G"): Val.T,
                ("w1", "G"): Val.T,
                ("w0", "notG"): Val.F,
                ("w1", "notG"): Val.F,
                ("w0", "Z"): pz0,
                ("w0", "notZ"): pnz0,
                ("w1", "Z"): pz1,
                ("w1", "notZ"): pnz1,
            }
            yield FiniteModel(
                worlds,
                ("a",),
                properties,
                complement,
                access,
                exists,
                extension,
                positivity,
            )


def _signature(m: FiniteModel) -> Dict[str, str]:
    return {
        "G@w0": m.val("w0", "a", "G").name,
        "G@w1": m.val("w1", "a", "G").name,
        "Z@w0": m.val("w0", "a", "Z").name,
        "Z@w1": m.val("w1", "a", "Z").name,
        "PZ@w0": m.pval("w0", "Z").name,
        "PnotZ@w0": m.pval("w0", "notZ").name,
        "PZ@w1": m.pval("w1", "Z").name,
        "PnotZ@w1": m.pval("w1", "notZ").name,
    }


def exhaustive_t2_assumption_minimality() -> tuple[int, Dict[str, Dict[str, str]]]:
    assumption_names = ("A1-L", "R+", "COMP_P^G", "CONS_G^G")
    witnesses: Dict[str, Dict[str, str]] = {}
    retained = 0

    for m in _t2_minimality_models():
        if not m.complement_extensions() or not m.g_sup_definition():
            continue

        values = {
            "A1-L": a1_l(m),
            "R+": m.r_plus(),
            "COMP_P^G": m.comp_p_g(),
            "CONS_G^G": m.cons_g_g(),
        }

        if all(values.values()):
            retained += 1
            assert m.t2_plus(), _signature(m)

        if not m.t2_plus():
            for dropped in assumption_names:
                if dropped in witnesses:
                    continue
                if all(values[name] for name in assumption_names if name != dropped):
                    witnesses[dropped] = _signature(m)

    assert set(witnesses) == set(assumption_names), witnesses
    return retained, witnesses


if __name__ == "__main__":
    assert validate_t1_glut_countermodel()
    retained, witnesses = exhaustive_t2_assumption_minimality()
    print("Gate 7 extended finite checks: OK")
    print("  T1 unrestricted +P glut countermodel: validated")
    print(f"  T2 full-antecedent models checked: {retained}")
    for dropped, witness in witnesses.items():
        print(f"  drop {dropped}: T2 countermodel {witness}")
