from itertools import product

from gate8_fitting_rigidity_bridge import (
    ADMISSIBLE,
    ALL_EDGES,
    FALSE_EXTENSION,
    TRUE_EXTENSION,
    _access_assignment,
    _g_pos_persists,
    _g_pos_reflects,
    _g_realization,
    _positivity_assignment,
    _realized_g_extensions,
    _r_plus_adm,
    _symmetric,
)


def _r_plus_converse_adm(access, positivity):
    """Transport target positivity back to the source of each access edge."""

    return all(
        (not positivity[(z, extension)]) or positivity[(w, extension)]
        for w, z in access
        for extension in ADMISSIBLE
    )


def validate_converse_rigidity_exhaustive():
    """Check the converse bridge and its strictness in the 256-case fragment."""

    checked = 0
    converse_models = 0
    bidirectional_models = 0
    symmetric_bidirectional_models = 0
    asymmetric_bidirectional_models = 0

    for access_bits in product((False, True), repeat=len(ALL_EDGES)):
        access = _access_assignment(access_bits)
        for positivity_bits in product((False, True), repeat=4):
            positivity = _positivity_assignment(positivity_bits)
            g_extension = _realized_g_extensions(positivity)

            assert _g_realization(positivity, g_extension)
            checked += 1

            r_plus = _r_plus_adm(access, positivity)
            converse = _r_plus_converse_adm(access, positivity)
            symmetric = _symmetric(access)

            if r_plus and symmetric:
                assert converse

            if converse:
                converse_models += 1
                assert _g_pos_persists(access, g_extension)

            if r_plus and converse:
                bidirectional_models += 1
                assert _g_pos_reflects(access, g_extension)
                assert _g_pos_persists(access, g_extension)

                if symmetric:
                    symmetric_bidirectional_models += 1
                else:
                    asymmetric_bidirectional_models += 1

    counts = (
        checked,
        converse_models,
        bidirectional_models,
        symmetric_bidirectional_models,
        asymmetric_bidirectional_models,
    )
    assert counts == (256, 152, 112, 80, 32)
    return counts


def validate_bidirectional_rigidity_without_symmetry():
    """Both positivity transports can hold on a genuinely asymmetric frame."""

    access = frozenset({("w0", "w1")})
    positivity = {
        ("w0", TRUE_EXTENSION): True,
        ("w0", FALSE_EXTENSION): False,
        ("w1", TRUE_EXTENSION): True,
        ("w1", FALSE_EXTENSION): False,
    }
    g_extension = _realized_g_extensions(positivity)

    assert _g_realization(positivity, g_extension)
    assert _r_plus_adm(access, positivity)
    assert _r_plus_converse_adm(access, positivity)
    assert not _symmetric(access)
    assert _g_pos_reflects(access, g_extension)
    assert _g_pos_persists(access, g_extension)
    return True


def validate_converse_without_forward_does_not_force_reflection():
    """Converse transport yields persistence but not the reflection half."""

    access = frozenset({("w0", "w1")})
    positivity = {
        ("w0", TRUE_EXTENSION): False,
        ("w0", FALSE_EXTENSION): True,
        ("w1", TRUE_EXTENSION): False,
        ("w1", FALSE_EXTENSION): False,
    }
    g_extension = _realized_g_extensions(positivity)

    assert _g_realization(positivity, g_extension)
    assert _r_plus_converse_adm(access, positivity)
    assert not _r_plus_adm(access, positivity)
    assert _g_pos_persists(access, g_extension)
    assert not _g_pos_reflects(access, g_extension)
    return True


if __name__ == "__main__":
    counts = validate_converse_rigidity_exhaustive()
    assert validate_bidirectional_rigidity_without_symmetry()
    assert validate_converse_without_forward_does_not_force_reflection()
    print("Gate 8 Fitting converse rigidity: OK")
    print(
        "  exhaustive models: "
        f"{counts[0]} total, {counts[1]} converse, "
        f"{counts[2]} bidirectional, "
        f"{counts[4]} asymmetric bidirectional"
    )
