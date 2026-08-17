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


def _common_properties():
    props = ("G", "notG", "NEA", "notNEA", "Q", "notQ")
    comp = {
        "G": "notG",
        "notG": "G",
        "NEA": "notNEA",
        "notNEA": "NEA",
        "Q": "notQ",
        "notQ": "Q",
    }
    return props, comp


def _common_positivity(worlds):
    positivity = {}
    for w in worlds:
        positivity[(w, "G")] = Val.T
        positivity[(w, "notG")] = Val.F
        positivity[(w, "NEA")] = Val.T
        positivity[(w, "notNEA")] = Val.F
        positivity[(w, "Q")] = Val.N
        positivity[(w, "notQ")] = Val.N
    return positivity


def _assert_anderson_stack(model):
    assert model.complement_extensions()
    assert a1_right(model)
    assert model.a2_plus()
    assert model.r_plus()
    assert anderson_g_realization_bilateral(model)
    assert anderson_g_positive(model)
    assert anderson_ne_realization_bilateral(model)
    assert anderson_ne_positive(model)
    assert possible_g_everywhere(model)


def anderson_s4_countermodel():
    """Reflexive/transitive but non-symmetric Anderson model refuting T3+.

    w0 sees itself and w1; w1 sees only itself. The sole actual entity is
    Godlike at w1 but not at w0. Hence possible actual Godlikeness holds at
    both worlds, while necessary actual Godlikeness fails at w0 because its
    reflexive successor w0 has no positive G witness.
    """
    worlds = ("w0", "w1")
    entities = ("a",)
    props, comp = _common_properties()
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
    return FiniteModel(
        worlds,
        entities,
        props,
        comp,
        access,
        exists,
        ext,
        _common_positivity(worlds),
    )


def anderson_symmetric_nonreflexive_countermodel():
    """Symmetric but non-reflexive Anderson model refuting T3+.

    The frame is a three-world star. `a` positively exemplifies G and NEA at
    every world, but is not actual at w2. At w0, Q is neither supported nor
    opposed; Q is positive only at actual w1 and absent at non-actual w2. This
    prevents G from becoming an Anderson essence at w0, so the positive NEA
    realization remains coherent even though actual G-existence fails at w2.

    Possible actual Godlikeness still holds everywhere: w0 sees actual Godlike
    a at w1, while w1 and w2 see actual Godlike a at w0.
    """
    worlds = ("w0", "w1", "w2")
    entities = ("a",)
    props, comp = _common_properties()
    access = frozenset({
        ("w0", "w1"), ("w1", "w0"),
        ("w0", "w2"), ("w2", "w0"),
    })
    exists = frozenset({("w0", "a"), ("w1", "a")})
    ext = {
        ("w0", "a", "G"): Val.T,
        ("w1", "a", "G"): Val.T,
        ("w2", "a", "G"): Val.T,
        ("w0", "a", "notG"): Val.F,
        ("w1", "a", "notG"): Val.F,
        ("w2", "a", "notG"): Val.F,
        ("w0", "a", "NEA"): Val.T,
        ("w1", "a", "NEA"): Val.T,
        ("w2", "a", "NEA"): Val.T,
        ("w0", "a", "notNEA"): Val.F,
        ("w1", "a", "notNEA"): Val.F,
        ("w2", "a", "notNEA"): Val.F,
        # Q is deliberately neither at w0, true at actual w1, false at
        # non-actual w2. Its complement follows FDE negation.
        ("w0", "a", "Q"): Val.N,
        ("w1", "a", "Q"): Val.T,
        ("w2", "a", "Q"): Val.F,
        ("w0", "a", "notQ"): Val.N,
        ("w1", "a", "notQ"): Val.F,
        ("w2", "a", "notQ"): Val.T,
    }
    return FiniteModel(
        worlds,
        entities,
        props,
        comp,
        access,
        exists,
        ext,
        _common_positivity(worlds),
    )


def validate_anderson_s4_countermodel():
    model = anderson_s4_countermodel()
    assert is_reflexive(model)
    assert is_transitive(model)
    assert not is_symmetric(model)
    _assert_anderson_stack(model)
    assert not anderson_t3_plus(model)
    return True


def validate_anderson_symmetric_nonreflexive_countermodel():
    model = anderson_symmetric_nonreflexive_countermodel()
    assert is_symmetric(model)
    assert not is_reflexive(model)
    assert not is_transitive(model)
    _assert_anderson_stack(model)
    assert not anderson_t3_plus(model)
    return True


if __name__ == "__main__":
    assert validate_anderson_s4_countermodel()
    assert validate_anderson_symmetric_nonreflexive_countermodel()
    print("Gate 8 Anderson frame countermodels: OK")
