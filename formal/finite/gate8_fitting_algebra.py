from checker import Val, require


ENTITIES = ("a", "b")

EMPTY = (Val.F, Val.F)
A = (Val.T, Val.F)
B = (Val.F, Val.T)
ALL = (Val.T, Val.T)
ADMISSIBLE = (EMPTY, A, B, ALL)


def idx(x):
    return ENTITIES.index(x)


def pos(extension, x):
    return extension[idx(x)].pos


def fde_neg(extension):
    return tuple(v.negate() for v in extension)


def val(pos_support, neg_support):
    return Val((int(bool(pos_support)), int(bool(neg_support))))


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
    # Only the universal extension is positively supported. Thus a and b have
    # exactly the same positive-property profile.
    return extension == ALL


def positive_profile_eq(x, y):
    return all(
        pos(extension, x) == pos(extension, y)
        for extension in ADMISSIBLE
        if p_pos(extension)
    )


def fde_algebra_closed():
    require(EMPTY in ADMISSIBLE)
    require(ALL in ADMISSIBLE)
    return (
        all(fde_neg(x) in ADMISSIBLE for x in ADMISSIBLE)
        and all(fde_conj(x, y) in ADMISSIBLE for x in ADMISSIBLE for y in ADMISSIBLE)
        and all(fde_disj(x, y) in ADMISSIBLE for x in ADMISSIBLE for y in ADMISSIBLE)
    )


def positive_profile_saturated():
    return all(
        pos(extension, x) == pos(extension, y)
        for x in ENTITIES
        for y in ENTITIES
        if positive_profile_eq(x, y)
        for extension in ADMISSIBLE
    )


def validate_fde_algebra_does_not_force_profile_saturation():
    require(fde_algebra_closed())
    require(positive_profile_eq("a", "b"))

    # The singleton A distinguishes a and b even though positivity does not.
    require(pos(A, "a"))
    require(not pos(A, "b"))
    require(not positive_profile_saturated())
    return True


if __name__ == "__main__":
    require(validate_fde_algebra_does_not_force_profile_saturation())
    print("Gate 8 Fitting algebra closure does not force profile saturation: OK")
