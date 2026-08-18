from itertools import product

from checker import Val, require


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
    require(len(ALL_EXTENSIONS) == 16)
    require(fde_algebra_closed_adm())
    require(global_entailment_closed_adm())
    require(a2_plus())
    require(profile_existence_saturated())

    # Positivity cannot distinguish a and b.
    require(positive_profile_eq("a", "b"))

    # Yet the full admissible domain contains a positive singleton distinguisher.
    distinguisher = (Val.T, Val.F)
    require(distinguisher in ADMISSIBLE)
    require(pos(distinguisher, "a"))
    require(not pos(distinguisher, "b"))
    require(not positive_profile_saturated())

    # The canonical quotient closure is nevertheless a genuine closure
    # operation here and actualist entailment is compatible with it because
    # existence is constant on the profile class.
    require(saturation_is_extensive_and_idempotent())
    require(entailment_survives_profile_saturation())
    return True


def validate_existence_saturation_is_needed_for_entailment_descent():
    source = "u0"
    target = "u1"
    access = frozenset({(source, target)})
    exists = frozenset({(target, "a")})

    def entail_at_source(x_extension, y_extension):
        return all(
            (not pos(x_extension, x)) or pos(y_extension, x)
            for z in (target,)
            if (source, z) in access
            for x in ENTITIES
            if (z, x) in exists
        )

    # a and b still have the same positive-property profile, but actual
    # existence splits the class at the accessible world.
    require(positive_profile_eq("a", "b"))
    require((target, "a") in exists)
    require((target, "b") not in exists)

    only_b = (Val.F, Val.T)
    empty = (Val.F, Val.F)

    # The premise holds vacuously because b, the only positive member of X,
    # is not actual at u1.
    require(entail_at_source(only_b, empty))

    # Saturation copies b's positive membership to the profile-equivalent a.
    # Since a is actual at u1, the saturated entailment now fails.
    require(pos(profile_saturate(only_b), "a"))
    require(not pos(profile_saturate(empty), "a"))
    require(not entail_at_source(profile_saturate(only_b), profile_saturate(empty)))
    return True


if __name__ == "__main__":
    require(validate_entailment_closure_does_not_force_profile_saturation())
    require(validate_existence_saturation_is_needed_for_entailment_descent())
    print("Gate 8 Fitting entailment closure vs profile quotient: OK")
