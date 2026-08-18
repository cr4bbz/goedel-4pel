from checker import Val, require


WORLDS = ("w0", "w1")
ENTITIES = ("a", "b")

EMPTY = (Val.F, Val.F)
ONLY_A = (Val.T, Val.F)
ONLY_B = (Val.F, Val.T)
ALL = (Val.T, Val.T)

# A genuine bilateral glut on b.  Its negation is also retained, preserving
# closure without forcing the Godlike witness a itself to be glutty.
GLUT_B = (Val.F, Val.B)
NEG_GLUT_B = (Val.T, Val.B)

ADMISSIBLE = (EMPTY, ONLY_A, ONLY_B, ALL, GLUT_B, NEG_GLUT_B)
ACCESS = {w: WORLDS for w in WORLDS}  # complete two-world S5 control frame
EXISTS = frozenset((w, x) for w in WORLDS for x in ENTITIES)

# Stable Godlikeness extension and universal necessary-existence extension.
G_EXTENSION = {w: ONLY_A for w in WORLDS}
NE_EXTENSION = {w: ALL for w in WORLDS}

# A contingent intension used only as a modal-collapse witness.
Q_EXTENSION = {
    "w0": ONLY_A,
    "w1": EMPTY,
}


def idx(x):
    return ENTITIES.index(x)


def ext_pos(extension, x):
    return extension[idx(x)].pos


def ext_neg(extension, x):
    return extension[idx(x)].neg


def neg_ext(extension):
    return tuple(v.negate() for v in extension)


def admissible(extension):
    return extension in ADMISSIBLE


def p_pos(w, extension):
    require(w in WORLDS and admissible(extension))
    return ext_pos(extension, "a")


def p_neg(w, extension):
    return p_pos(w, neg_ext(extension))


def a1_left():
    return all(
        (not p_neg(w, x)) or p_pos(w, neg_ext(x))
        for w in WORLDS
        for x in ADMISSIBLE
    )


def a1_right():
    return all(
        (not p_pos(w, neg_ext(x))) or p_neg(w, x)
        for w in WORLDS
        for x in ADMISSIBLE
    )


def entail_plus(w, x_ext, y_ext):
    return all(
        (not ext_pos(x_ext, x)) or ext_pos(y_ext, x)
        for z in ACCESS[w]
        for x in ENTITIES
        if (z, x) in EXISTS
    )


def a2_plus():
    return all(
        (not p_pos(w, x_ext))
        or (not entail_plus(w, x_ext, y_ext))
        or p_pos(w, y_ext)
        for w in WORLDS
        for x_ext in ADMISSIBLE
        for y_ext in ADMISSIBLE
    )


def god_plus(w, x):
    return all(
        (not p_pos(w, extension)) or ext_pos(extension, x)
        for extension in ADMISSIBLE
    )


def g_realization():
    return all(
        ext_pos(G_EXTENSION[w], x) == god_plus(w, x)
        for w in WORLDS
        for x in ENTITIES
    )


def comp_p_g():
    return all(
        (not god_plus(w, x))
        or (not ext_pos(extension, x))
        or p_pos(w, extension)
        or p_neg(w, extension)
        for w in WORLDS
        for x in ENTITIES
        for extension in ADMISSIBLE
    )


def cons_g_g():
    return all(
        (not god_plus(w, x))
        or (not ext_pos(extension, x))
        or (not ext_neg(extension, x))
        for w in WORLDS
        for x in ENTITIES
        for extension in ADMISSIBLE
    )


def ess_plus(w, extension, x):
    return (
        admissible(extension)
        and ext_pos(extension, x)
        and all(
            (not ext_pos(y_ext, x)) or entail_plus(w, extension, y_ext)
            for y_ext in ADMISSIBLE
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


def ne_plus(w, x):
    return all(
        (not ess_plus(w, extension, x)) or box_exists_plus(w, extension)
        for extension in ADMISSIBLE
    )


def ne_realization():
    return all(
        ext_pos(NE_EXTENSION[w], x) == ne_plus(w, x)
        for w in WORLDS
        for x in ENTITIES
    )


def a5_plus():
    return all(p_pos(w, NE_EXTENSION[w]) for w in WORLDS)


def necessary_g_de_dicto():
    return all(
        any(
            (z, x) in EXISTS and god_plus(z, x)
            for x in ENTITIES
        )
        for w in WORLDS
        for z in ACCESS[w]
    )


def g_extension_stable():
    return all(
        G_EXTENSION[w] == G_EXTENSION[z]
        for w in WORLDS
        for z in ACCESS[w]
    )


def positive_modal_collapse_fails_for_q_a():
    # +Q(a) at w0, but accessible w1 lacks +Q(a).
    return (
        ext_pos(Q_EXTENSION["w0"], "a")
        and any(
            not ext_pos(Q_EXTENSION[z], "a")
            for z in ACCESS["w0"]
        )
    )


def validate_fitting_necessary_god_no_collapse_model():
    require(all(admissible(neg_ext(x)) for x in ADMISSIBLE))
    require(a1_left())
    require(a1_right())
    require(a2_plus())
    require(g_realization())
    require(comp_p_g())
    require(cons_g_g())
    require(ne_realization())
    require(a5_plus())
    require(g_extension_stable())
    require(necessary_g_de_dicto())

    # The selected extensional domain still contains genuine inconsistent
    # information; admissibility is not a global consistency restriction.
    require(ext_pos(GLUT_B, "b") and ext_neg(GLUT_B, "b"))

    # Nevertheless necessary actual Godlikeness coexists with contingent truth.
    require(positive_modal_collapse_fails_for_q_a())
    return True


if __name__ == "__main__":
    require(validate_fitting_necessary_god_no_collapse_model())
    print("Gate 8 admissible Fitting necessary-God / no-collapse fixture: OK")
