from checker import Val, require


WORLDS = ("w0",)
ENTITIES = ("a", "b", "c")

EMPTY = (Val.F, Val.F, Val.F)
AB = (Val.T, Val.T, Val.F)
C = (Val.F, Val.F, Val.T)
ALL = (Val.T, Val.T, Val.T)
ADMISSIBLE = (EMPTY, AB, C, ALL)

ACCESS = {"w0": ("w0",)}
EXISTS = frozenset({("w0", "a"), ("w0", "b")})

G_EXTENSION = {"w0": AB}
NE_EXTENSION = {"w0": AB}


def ex_index(x):
    return ENTITIES.index(x)


def ext_pos(extension, x):
    return extension[ex_index(x)].pos


def ext_neg(extension, x):
    return extension[ex_index(x)].neg


def negate_extension(extension):
    return tuple(v.negate() for v in extension)


def admissible(extension):
    return extension in ADMISSIBLE


def p_pos(w, extension):
    require(w == "w0")
    require(admissible(extension))
    return extension == AB


def p_neg(w, extension):
    require(w == "w0")
    require(admissible(extension))
    return extension == C


def a1_left_adm():
    return all(
        (not p_neg(w, extension)) or p_pos(w, negate_extension(extension))
        for w in WORLDS
        for extension in ADMISSIBLE
    )


def a1_right_adm():
    return all(
        (not p_pos(w, negate_extension(extension))) or p_neg(w, extension)
        for w in WORLDS
        for extension in ADMISSIBLE
    )


def god_plus_adm(w, x):
    return all(
        (not p_pos(w, extension)) or ext_pos(extension, x)
        for extension in ADMISSIBLE
    )


def g_realization_adm():
    return all(
        ext_pos(G_EXTENSION[w], x) == god_plus_adm(w, x)
        for w in WORLDS
        for x in ENTITIES
    )


def positive_profile_eq(w, x, y):
    return all(
        ext_pos(extension, x) == ext_pos(extension, y)
        for extension in ADMISSIBLE
        if p_pos(w, extension)
    )


def positive_profile_saturated_adm():
    return all(
        ext_pos(extension, x) == ext_pos(extension, y)
        for w in WORLDS
        for x in ENTITIES
        for y in ENTITIES
        if positive_profile_eq(w, x, y)
        for extension in ADMISSIBLE
    )


def godlike_indiscernibility_adm():
    return all(
        ext_pos(extension, x) == ext_pos(extension, y)
        for w in WORLDS
        for x in ENTITIES
        for y in ENTITIES
        if god_plus_adm(w, x) and god_plus_adm(w, y)
        for extension in ADMISSIBLE
    )


def comp_p_g_adm():
    return all(
        (not god_plus_adm(w, x))
        or (not ext_pos(extension, x))
        or p_pos(w, extension)
        or p_neg(w, extension)
        for w in WORLDS
        for x in ENTITIES
        for extension in ADMISSIBLE
    )


def cons_g_g_adm():
    return all(
        (not god_plus_adm(w, x))
        or (not ext_pos(extension, x))
        or (not ext_neg(extension, x))
        for w in WORLDS
        for x in ENTITIES
        for extension in ADMISSIBLE
    )


def entail_plus(w, x_extension, y_extension):
    return all(
        (not ext_pos(x_extension, x)) or ext_pos(y_extension, x)
        for z in ACCESS[w]
        for x in ENTITIES
        if (z, x) in EXISTS
    )


def ess_plus_adm(w, extension, x):
    return (
        admissible(extension)
        and ext_pos(extension, x)
        and all(
            (not ext_pos(y_extension, x))
            or entail_plus(w, extension, y_extension)
            for y_extension in ADMISSIBLE
        )
    )


def box_exists_plus(w, extension):
    return all(
        any(
            (z, x) in EXISTS and ext_pos(extension, x)
            for x in ENTITIES
        )
        for z in ACCESS[w]
    )


def ne_plus_adm(w, x):
    return all(
        (not ess_plus_adm(w, extension, x))
        or box_exists_plus(w, extension)
        for extension in ADMISSIBLE
    )


def ne_realization_adm():
    return all(
        ext_pos(NE_EXTENSION[w], x) == ne_plus_adm(w, x)
        for w in WORLDS
        for x in ENTITIES
    )


def a5_plus_adm():
    return all(p_pos(w, NE_EXTENSION[w]) for w in WORLDS)


def validate_profile_saturation_route_without_comp():
    require(all(admissible(negate_extension(x)) for x in ADMISSIBLE))
    require(a1_left_adm())
    require(a1_right_adm())
    require(g_realization_adm())

    # Two genuinely distinct positive Godlike individuals share the same
    # positive property profile.
    require(god_plus_adm("w0", "a"))
    require(god_plus_adm("w0", "b"))
    require(not god_plus_adm("w0", "c"))
    require(positive_profile_eq("w0", "a", "b"))

    # The selected property domain factors through positive-profile classes.
    require(positive_profile_saturated_adm())
    require(godlike_indiscernibility_adm())
    require(cons_g_g_adm())

    # ALL contains both Godlike individuals but is genuinely positivity-gappy.
    require(ext_pos(ALL, "a") and ext_pos(ALL, "b"))
    require(not p_pos("w0", ALL))
    require(not p_neg("w0", ALL))
    require(not comp_p_g_adm())

    # The current G extension is nevertheless an essence of both Godlike
    # individuals, and the NE realization remains non-vacuous.
    require(ess_plus_adm("w0", G_EXTENSION["w0"], "a"))
    require(ess_plus_adm("w0", G_EXTENSION["w0"], "b"))
    require(ne_realization_adm())
    require(a5_plus_adm())
    return True


if __name__ == "__main__":
    require(validate_profile_saturation_route_without_comp())
    print("Gate 8 Fitting positive-profile saturation without COMP: OK")
