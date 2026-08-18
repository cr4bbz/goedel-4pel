from checker import FiniteModel, Val, require
from gate8_anderson import box_exists_plus
from gate8_frames import is_reflexive, is_symmetric, is_transitive


def scott_ne_plus(model, w, x):
    """Positive Scott necessary existence for the finite oracle."""
    return all(
        (not model.essence_plus(w, p, x)) or box_exists_plus(model, w, p)
        for p in model.properties
    )


def scott_ne_realization(model, ne="NE"):
    return all(
        model.val(w, x, ne).pos == scott_ne_plus(model, w, x)
        for w in model.worlds
        for x in model.entities
    )


def scott_a5_plus(model, ne="NE"):
    return all(model.pval(w, ne).pos for w in model.worlds)


def scott_possible_god(model):
    return all(
        any(
            (v, x) in model.exists and model.god_plus_derived(v, x)
            for v in model.accessible(w)
            for x in model.entities
        )
        for w in model.worlds
    )


def scott_t3_plus(model):
    return all(
        any(
            (z, x) in model.exists and model.god_plus_derived(z, x)
            for x in model.entities
        )
        for w in model.worlds
        for z in model.accessible(w)
    )


def scott_s4_countermodel():
    """Reflexive/transitive but non-symmetric Scott-support model refuting T3+.

    The entity is not Godlike at w0 and is Godlike at w1. The Scott T2, A5,
    NE-sup, and G-sup interfaces all hold, and possible actual Godlikeness is
    available from every world. T3+ nevertheless fails at w0 because w0 sees
    itself and has no actual Godlike witness. This is the finite counterpoint to
    the general symmetry-only Scott T3 theorem in `ScottFrames.lean`.
    """
    worlds = ("w0", "w1")
    entities = ("a",)
    props = ("G", "notG", "NE", "notNE")
    comp = {
        "G": "notG",
        "notG": "G",
        "NE": "notNE",
        "notNE": "NE",
    }
    access = frozenset({("w0", "w0"), ("w0", "w1"), ("w1", "w1")})
    exists = frozenset({("w0", "a"), ("w1", "a")})
    ext = {
        ("w0", "a", "G"): Val.F,
        ("w1", "a", "G"): Val.T,
        ("w0", "a", "notG"): Val.T,
        ("w1", "a", "notG"): Val.F,
        ("w0", "a", "NE"): Val.F,
        ("w1", "a", "NE"): Val.T,
        ("w0", "a", "notNE"): Val.T,
        ("w1", "a", "notNE"): Val.F,
    }
    positivity = {}
    for w in worlds:
        positivity[(w, "G")] = Val.T
        positivity[(w, "notG")] = Val.F
        positivity[(w, "NE")] = Val.T
        positivity[(w, "notNE")] = Val.F
    return FiniteModel(worlds, entities, props, comp, access, exists, ext, positivity)


def validate_scott_s4_countermodel():
    model = scott_s4_countermodel()
    require(is_reflexive(model))
    require(is_transitive(model))
    require(not is_symmetric(model))

    # The countermodel keeps a richer Scott-control context than the reduced
    # theorem itself requires.
    require(model.complement_extensions())
    require(model.strong_a1())
    require(model.a2_plus())
    require(model.r_plus())

    # All premises of the symmetry-only Scott T3 theorem except symmetry.
    require(model.g_sup_definition())
    require(model.t2_plus())
    require(scott_a5_plus(model))
    require(scott_ne_realization(model))
    require(scott_possible_god(model))

    require(not scott_t3_plus(model))
    return True


if __name__ == "__main__":
    require(validate_scott_s4_countermodel())
    print("Gate 8 Scott S4 countermodel to T3+: OK")
