from __future__ import annotations

from itertools import product
from typing import Dict, Iterator

from checker import FiniteModel, Val


T2_RECOVERY_ASSUMPTIONS = ("A1-L", "R+", "COMP_P^G", "CONS_G^G")


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


def iter_t2_minimality_models() -> Iterator[FiniteModel]:
    """Expose the matrix family used by the Gate-7 minimality oracle."""

    yield from _t2_minimality_models()


def is_t2_minimality_baseline(model: FiniteModel) -> bool:
    """Return whether the model satisfies the fixed, non-dropped interfaces."""

    return model.complement_extensions() and model.g_sup_definition()


def t2_recovery_assumption_values(model: FiniteModel) -> Dict[str, bool]:
    """Evaluate the four independently dropped T2 recovery assumptions."""

    return {
        "A1-L": a1_l(model),
        "R+": model.r_plus(),
        "COMP_P^G": model.comp_p_g(),
        "CONS_G^G": model.cons_g_g(),
    }


def iter_t2_regular_models() -> Iterator[FiniteModel]:
    """Yield the 873 models satisfying the complete current recovery package."""

    for model in iter_t2_minimality_models():
        if not is_t2_minimality_baseline(model):
            continue
        if all(t2_recovery_assumption_values(model).values()):
            assert model.t2_plus(), _signature(model)
            yield model


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
    witnesses: Dict[str, Dict[str, str]] = {}
    retained = 0

    for m in iter_t2_minimality_models():
        if not is_t2_minimality_baseline(m):
            continue

        values = t2_recovery_assumption_values(m)

        if all(values.values()):
            retained += 1
            assert m.t2_plus(), _signature(m)

        if not m.t2_plus():
            for dropped in T2_RECOVERY_ASSUMPTIONS:
                if dropped in witnesses:
                    continue
                if all(
                    values[name]
                    for name in T2_RECOVERY_ASSUMPTIONS
                    if name != dropped
                ):
                    witnesses[dropped] = _signature(m)

    assert set(witnesses) == set(T2_RECOVERY_ASSUMPTIONS), witnesses
    return retained, witnesses


if __name__ == "__main__":
    assert validate_t1_glut_countermodel()
    retained, witnesses = exhaustive_t2_assumption_minimality()
    print("Gate 7 extended finite checks: OK")
    print("  T1 unrestricted +P glut countermodel: validated")
    print(f"  T2 full-antecedent models checked: {retained}")
    for dropped, witness in witnesses.items():
        print(f"  drop {dropped}: T2 countermodel {witness}")
