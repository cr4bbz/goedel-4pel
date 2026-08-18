from checker import Val, require


WORLDS = ("w0", "w1", "w2")
ENTITIES = ("a", "b")

# Bilateral rigid extensions over (a,b).  The selected domain is classical but
# explicitly chosen; unrestricted bilateral comprehension is not assumed.
EMPTY = (Val.F, Val.F)
ONLY_A = (Val.T, Val.F)
ONLY_B = (Val.F, Val.T)
ALL = (Val.T, Val.T)
ADMISSIBLE = (EMPTY, ONLY_A, ONLY_B, ALL)

ACCESS = {
    "w0": ("w1", "w2"),
    "w1": ("w1",),
    "w2": ("w2",),
}

# Both entities are actual everywhere.  This keeps the finite witness focused
# on the intension/extension distinction rather than varying-domain effects.
EXISTS = frozenset((w, x) for w in WORLDS for x in ENTITIES)

G_EXTENSION = {
    "w0": ONLY_A,
    "w1": ONLY_A,
    "w2": EMPTY,
}

# Necessary existence is realized by the universal admissible extension.
NE_EXTENSION = {w: ALL for w in WORLDS}


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


def admissible_negation_closed():
    return all(admissible(negate_extension(x)) for x in ADMISSIBLE)


def p_pos(w, extension):
    """World-indexed positivity support over admissible extensions.

    At w0/w1, positive extensions are exactly those containing a.  At w2,
    every nonempty extension is positively supported; their intersection is
    empty, so no individual is Godlike there.
    """
    require(admissible(extension))
    if w in ("w0", "w1"):
        return ext_pos(extension, "a")
    return any(ext_pos(extension, x) for x in ENTITIES)


def p_neg(w, extension):
    """FDE A1-compatible negative positivity support."""
    return p_pos(w, negate_extension(extension))


def a1_left_adm():
    return all(
        (not p_neg(w, extension)) or p_pos(w, negate_extension(extension))
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


def g_admissible():
    return all(admissible(G_EXTENSION[w]) for w in WORLDS)


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


def ne_admissible():
    return all(admissible(NE_EXTENSION[w]) for w in WORLDS)


def a5_plus_adm():
    return all(p_pos(w, NE_EXTENSION[w]) for w in WORLDS)


def possible_current_g_extension(w):
    frozen = G_EXTENSION[w]
    return any(
        (z, x) in EXISTS and ext_pos(frozen, x)
        for z in ACCESS[w]
        for x in ENTITIES
    )


def necessary_current_g_extension(w):
    frozen = G_EXTENSION[w]
    return all(
        any(
            (z, x) in EXISTS and ext_pos(frozen, x)
            for x in ENTITIES
        )
        for z in ACCESS[w]
    )


def possible_g_de_dicto(w):
    return any(
        (z, x) in EXISTS and god_plus_adm(z, x)
        for z in ACCESS[w]
        for x in ENTITIES
    )


def necessary_g_de_dicto(w):
    return all(
        any(
            (z, x) in EXISTS and god_plus_adm(z, x)
            for x in ENTITIES
        )
        for z in ACCESS[w]
    )


def g_extension_stable_along_r():
    return all(
        G_EXTENSION[w] == G_EXTENSION[z]
        for w in WORLDS
        for z in ACCESS[w]
    )


def validate_fitting_admissible_de_re_de_dicto_model():
    require(admissible_negation_closed())
    require(a1_left_adm())
    require(g_admissible())
    require(g_realization_adm())
    require(comp_p_g_adm())
    require(cons_g_g_adm())
    require(ne_admissible())
    require(ne_realization_adm())
    require(a5_plus_adm())

    # Non-vacuity: a is genuinely Godlike at w0 and w1.
    require(god_plus_adm("w0", "a"))
    require(god_plus_adm("w1", "a"))
    require(not god_plus_adm("w2", "a"))
    require(not god_plus_adm("w2", "b"))

    # The frozen current G extension is both possible and necessary de re.
    require(possible_current_g_extension("w0"))
    require(necessary_current_g_extension("w0"))

    # De dicto possibility survives via w1, but necessity fails at w2.
    require(possible_g_de_dicto("w0"))
    require(not necessary_g_de_dicto("w0"))
    require(not g_extension_stable_along_r())
    return True


if __name__ == "__main__":
    require(validate_fitting_admissible_de_re_de_dicto_model())
    print("Gate 8 admissible Fitting de-re/de-dicto separation: OK")
