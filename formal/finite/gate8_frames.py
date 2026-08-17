from checker import FiniteModel, Val
from gate8_anderson import (
    a1_right,
    anderson_g_positive,
    anderson_g_realization_bilateral,
    anderson_ne_positive,
    anderson_ne_realization_bilateral,
    anderson_t3_plus,
    possible_g_everywhere,
)


def is_reflexive(model):
    return all((w, w) in model.access for w in model.worlds)


def is_symmetric(model):
    return all((v, w) in model.access for (w, v) in model.access)


def is_transitive(model):
    return all(
        (w, z) in model.access
        for w in model.worlds
        for v in model.worlds
        for z in model.worlds
        if (w, v) in model.access and (v, z) in model.access
    )


def anderson_s4_countermodel():
    """Reflexive/transitive but non-symmetric Anderson model refuting T3+.

    w0 sees itself and w1; w1 sees only itself. The sole actual entity is
    Godlike at w1 but not at w0. Hence possible actual Godlikeness holds at
    both worlds, while necessary actual Godlikeness fails at w0 because its
    reflexive successor w0 has no positive G witness.
    """
    worlds = ("w0", "w1")
    entities = ("a",)
    props = ("G", "notG", "NEA", "notNEA", "Q", "notQ")
    comp = {
        "G": "notG",
        "notG": "G",
        "NEA": "notNEA",
        "notNEA": "NEA",
        "Q": "notQ",
        "notQ": "Q",
    }
    access = frozenset({("w0", "w0"), ("w0", "w1"), ("w1", "w1")})
    exists = frozenset({("w0", "a"), ("w1", "a")})
    ext = {
        ("w0", "a", "G"): Val.F,
        ("w1", "a", "G"): Val.T,
        ("w0", "a", "notG"): Val.T,
        ("w1", "a", "notG"): Val.F,
        ("w0", "a", "NEA"): Val.T,
        ("w1", "a", "NEA"): Val.T,
        ("w0", "a", "notNEA"): Val.F,
        ("w1", "a", "notNEA"): Val.F,
        ("w0", "a", "Q"): Val.N,
        ("w1", "a", "Q"): Val.N,
        ("w0", "a", "notQ"): Val.N,
        ("w1", "a", "notQ"): Val.N,
    }
    positivity = {}
    for w in worlds:
        positivity[(w, "G")] = Val.T
        positivity[(w, "notG")] = Val.F
        positivity[(w, "NEA")] = Val.T
        positivity[(w, "notNEA")] = Val.F
        positivity[(w, "Q")] = Val.N
        positivity[(w, "notQ")] = Val.N
    return FiniteModel(worlds, entities, props, comp, access, exists, ext, positivity)


def validate_anderson_s4_countermodel():
    model = anderson_s4_countermodel()
    assert is_reflexive(model)
    assert is_transitive(model)
    assert not is_symmetric(model)
    assert model.complement_extensions()
    assert a1_right(model)
    assert model.a2_plus()
    assert model.r_plus()
    assert anderson_g_realization_bilateral(model)
    assert anderson_g_positive(model)
    assert anderson_ne_realization_bilateral(model)
    assert anderson_ne_positive(model)
    assert possible_g_everywhere(model)
    assert not anderson_t3_plus(model)
    return True


if __name__ == "__main__":
    assert validate_anderson_s4_countermodel()
    print("Gate 8 Anderson S4 countermodel to necessary actual Godlikeness: OK")
