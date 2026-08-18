from itertools import product

from checker import Val


WORLD = "w0"
ENTITIES = ("a", "b")
ACCESS = frozenset({(WORLD, WORLD)})
EXISTS = frozenset({(WORLD, "a"), (WORLD, "b")})

# This is the complete bilateral extension universe on two entities: 4^2 = 16.
ALL_EXTENSIONS = tuple(product(tuple(Val), repeat=len(ENTITIES)))
ADMISSIBLE = ALL_EXTENSIONS


def idx(x):
    return ENTITIES.index(x)


def pos(extension, x):
    return extension[idx(x)].pos


def neg(extension, x):
    return extension[idx(x)].neg


def val(pos_support, neg_support):
    return Val((int(bool(pos_support)), int(bool(neg_support))))


def fde_neg(extension):
    return tuple(v.negate() for v in extension)


def fde_conj(x, y):
    return tuple(
        val(vx.pos and vy.pos, vx.neg or vy.neg)
        for vx, vy in zip(x, y)
    )


def fde_disj(x, y):
    return tuple(
        val(vx.pos or vy.pos, vx.neg and vy.neg)
        for vx, vy in zip(x, y)
    )


def p_pos(extension):
    # Positive support is upward/extensional in the strongest possible simple
    # way here: every positively supported extension contains both entities.
    return all(pos(extension, x) for x in ENTITIES)


def entail_plus(x_extension, y_extension):
    # One reflexive world and both entities actual, so Fitting entailment is
    # ordinary positive-membership inclusion in this fixture.
    return all(
        (not pos(x_extension, x)) or pos(y_extension, x)
        for x in ENTITIES
    )


def a2_plus():
    return all(
        (not p_pos(x_extension))
        or (not entail_plus(x_extension, y_extension))
        or p_pos(y_extension)
        for x_extension in ADMISSIBLE
        for y_extension in ADMISSIBLE
    )


def global_entailment_closed_adm():
    # ADMISSIBLE is the full bilateral extension universe on these entities.
    return all(
        y_extension in ADMISSIBLE
        for x_extension in ADMISSIBLE
        for y_extension in ALL_EXTENSIONS
        if entail_plus(x_extension, y_extension)
    )


def fde_algebra_closed_adm():
    return (
        all(fde_neg(x) in ADMISSIBLE for x in ADMISSIBLE)
        and all(
            fde_conj(x, y) in ADMISSIBLE
            for x in ADMISSIBLE
            for y in ADMISSIBLE
        )
        and all(
            fde_disj(x, y) in ADMISSIBLE
            for x in ADMISSIBLE
            for y in ADMISSIBLE
        )
    )


def positive_profile_eq(x, y):
    return all(
        pos(extension, x) == pos(extension, y)
        for extension in ADMISSIBLE
        if p_pos(extension)
    )


def profile_existence_saturated():
    return all(
        ((WORLD, x) in EXISTS) == ((WORLD, y) in EXISTS)
        for x in ENTITIES
        for y in ENTITIES
        if positive_profile_eq(x, y)
    )


def positive_profile_saturated():
    return all(
        pos(extension, x) == pos(extension, y)
        for x in ENTITIES
        for y in ENTITIES
        if positive_profile_eq(x, y)
        for extension in ADMISSIBLE
    )


def profile_saturate(extension):
    out = []
    for x in ENTITIES:
        pos_support = any(
            positive_profile_eq(x, y) and pos(extension, y)
            for y in ENTITIES
        )
        neg_support = any(
            positive_profile_eq(x, y) and neg(extension, y)
            for y in ENTITIES
        )
        out.append(val(pos_support, neg_support))
    return tuple(out)


def saturation_is_extensive_and_idempotent():
    return all(
        all(
            (not pos(extension, x)) or pos(profile_saturate(extension), x)
            for x in ENTITIES
        )
        and all(
            (not neg(extension, x)) or neg(profile_saturate(extension), x)
            for x in ENTITIES
        )
        and profile_saturate(profile_saturate(extension)) == profile_saturate(extension)
        for extension in ALL_EXTENSIONS
    )


def entailment_survives_profile_saturation():
    return all(
        (not entail_plus(x_extension, y_extension))
        or entail_plus(profile_saturate(x_extension), profile_saturate(y_extension))
        for x_extension in ALL_EXTENSIONS
        for y_extension in ALL_EXTENSIONS
    )


def validate_entailment_closure_does_not_force_profile_saturation():
    assert len(ALL_EXTENSIONS) == 16
    assert fde_algebra_closed_adm()
    assert global_entailment_closed_adm()
    assert a2_plus()
    assert profile_existence_saturated()

    # Positivity cannot distinguish a and b.
    assert positive_profile_eq("a", "b")

    # Yet the full admissible domain contains a positive singleton distinguisher.
    distinguisher = (Val.T, Val.F)
    assert distinguisher in ADMISSIBLE
    assert pos(distinguisher, "a")
    assert not pos(distinguisher, "b")
    assert not positive_profile_saturated()

    # The canonical quotient closure is nevertheless a genuine closure
    # operation here and actualist entailment is compatible with it because
    # existence is constant on the profile class.
    assert saturation_is_extensive_and_idempotent()
    assert entailment_survives_profile_saturation()
    return True


if __name__ == "__main__":
    assert validate_entailment_closure_does_not_force_profile_saturation()
    print("Gate 8 Fitting entailment closure vs profile quotient: OK")
