from itertools import product

from checker import Val


WORLDS = ("w0", "w1")
ENTITIES = ("a",)

TRUE_EXTENSION = (Val.T,)
FALSE_EXTENSION = (Val.F,)
ADMISSIBLE = (TRUE_EXTENSION, FALSE_EXTENSION)
ALL_EDGES = tuple(product(WORLDS, repeat=2))


def _pos(extension, x):
    return extension[ENTITIES.index(x)].pos


def _negate(extension):
    return tuple(value.negate() for value in extension)


def _god_plus(positivity, w, x):
    return all(
        (not positivity[(w, extension)]) or _pos(extension, x)
        for extension in ADMISSIBLE
    )


def _realized_g_extensions(positivity):
    return {
        w: TRUE_EXTENSION if _god_plus(positivity, w, "a") else FALSE_EXTENSION
        for w in WORLDS
    }


def _g_realization(positivity, g_extension):
    return all(
        _pos(g_extension[w], x) == _god_plus(positivity, w, x)
        for w in WORLDS
        for x in ENTITIES
    )


def _symmetric(access):
    return all((z, w) in access for w, z in access)


def _r_plus_adm(access, positivity):
    return all(
        (not positivity[(w, extension)]) or positivity[(z, extension)]
        for w, z in access
        for extension in ADMISSIBLE
    )


def _g_pos_reflects(access, g_extension):
    return all(
        (not _pos(g_extension[z], x)) or _pos(g_extension[w], x)
        for w, z in access
        for x in ENTITIES
    )


def _g_pos_persists(access, g_extension):
    return all(
        (not _pos(g_extension[w], x)) or _pos(g_extension[z], x)
        for w, z in access
        for x in ENTITIES
    )


def _positivity_assignment(bits):
    keys = tuple(product(WORLDS, ADMISSIBLE))
    return dict(zip(keys, bits))


def _access_assignment(bits):
    return frozenset(edge for edge, enabled in zip(ALL_EDGES, bits) if enabled)


def validate_rigidity_bridge_exhaustive():
    """Exhaust the two-world/one-entity classical admissible fragment.

    The distinguished G extension is constructed to realize admissible-domain
    Godlikeness. Every retained RPlusAdm model must reflect positive G
    membership; every retained symmetric RPlusAdm model must also preserve it.
    """

    assert all(_negate(extension) in ADMISSIBLE for extension in ADMISSIBLE)

    checked = 0
    r_plus_models = 0
    symmetric_r_plus_models = 0

    for access_bits in product((False, True), repeat=len(ALL_EDGES)):
        access = _access_assignment(access_bits)
        for positivity_bits in product((False, True), repeat=4):
            positivity = _positivity_assignment(positivity_bits)
            g_extension = _realized_g_extensions(positivity)

            assert _g_realization(positivity, g_extension)
            checked += 1

            if _r_plus_adm(access, positivity):
                r_plus_models += 1
                assert _g_pos_reflects(access, g_extension)

                if _symmetric(access):
                    symmetric_r_plus_models += 1
                    assert _g_pos_persists(access, g_extension)

    assert checked == 256
    assert r_plus_models > 0
    assert symmetric_r_plus_models > 0
    return checked, r_plus_models, symmetric_r_plus_models


def validate_rplus_without_symmetry_does_not_force_persistence():
    """RPlusAdm alone reflects G but need not preserve it forward."""

    access = frozenset({("w0", "w1")})
    positivity = {
        ("w0", TRUE_EXTENSION): False,
        ("w0", FALSE_EXTENSION): False,
        ("w1", TRUE_EXTENSION): False,
        ("w1", FALSE_EXTENSION): True,
    }
    g_extension = _realized_g_extensions(positivity)

    assert _g_realization(positivity, g_extension)
    assert _r_plus_adm(access, positivity)
    assert not _symmetric(access)
    assert _g_pos_reflects(access, g_extension)
    assert not _g_pos_persists(access, g_extension)
    return True


def validate_symmetry_without_rplus_does_not_force_reflection():
    """Symmetry alone does not reflect or preserve positive G membership."""

    access = frozenset({("w0", "w1"), ("w1", "w0")})
    positivity = {
        ("w0", TRUE_EXTENSION): False,
        ("w0", FALSE_EXTENSION): True,
        ("w1", TRUE_EXTENSION): False,
        ("w1", FALSE_EXTENSION): False,
    }
    g_extension = _realized_g_extensions(positivity)

    assert _g_realization(positivity, g_extension)
    assert _symmetric(access)
    assert not _r_plus_adm(access, positivity)
    assert not _g_pos_reflects(access, g_extension)
    assert not _g_pos_persists(access, g_extension)
    return True


if __name__ == "__main__":
    counts = validate_rigidity_bridge_exhaustive()
    assert validate_rplus_without_symmetry_does_not_force_persistence()
    assert validate_symmetry_without_rplus_does_not_force_reflection()
    print("Gate 8 Fitting rigidity bridge: OK")
    print(
        "  exhaustive models: "
        f"{counts[0]} total, {counts[1]} RPlusAdm, "
        f"{counts[2]} symmetric RPlusAdm"
    )
