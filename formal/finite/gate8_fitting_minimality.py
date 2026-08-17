from checker import Val


# ---------------------------------------------------------------------------
# Fixture A: the targeted consistency premise is strictly weaker on the
# A1-L-only recovery route.  The single admissible extension is genuinely B.
# ---------------------------------------------------------------------------

A_WORLDS = ("w0",)
A_ENTITIES = ("a",)
A_GLUT = (Val.B,)
A_ADMISSIBLE = (A_GLUT,)
A_ACCESS = {"w0": ("w0",)}
A_EXISTS = frozenset({("w0", "a")})
A_G_EXTENSION = {"w0": A_GLUT}


def _idx(entities, x):
    return entities.index(x)


def _pos(extension, entities, x):
    return extension[_idx(entities, x)].pos


def _neg(extension, entities, x):
    return extension[_idx(entities, x)].neg


def _negate(extension):
    return tuple(v.negate() for v in extension)


def a_admissible(extension):
    return extension in A_ADMISSIBLE


def a_p_pos(_w, extension):
    assert a_admissible(extension)
    return extension == A_GLUT


def a_p_neg(_w, extension):
    assert a_admissible(extension)
    return False


def a_god_plus(w, x):
    return all(
        (not a_p_pos(w, extension)) or _pos(extension, A_ENTITIES, x)
        for extension in A_ADMISSIBLE
    )


def a_a1_left():
    return all(
        (not a_p_neg(w, extension)) or a_p_pos(w, _negate(extension))
        for w in A_WORLDS
        for extension in A_ADMISSIBLE
    )


def a_a1_right():
    return all(
        (not a_p_pos(w, _negate(extension))) or a_p_neg(w, extension)
        for w in A_WORLDS
        for extension in A_ADMISSIBLE
    )


def a_comp_p_g():
    return all(
        (not a_god_plus(w, x))
        or (not _pos(extension, A_ENTITIES, x))
        or a_p_pos(w, extension)
        or a_p_neg(w, extension)
        for w in A_WORLDS
        for x in A_ENTITIES
        for extension in A_ADMISSIBLE
    )


def a_neg_class_consistency():
    return all(
        (not a_god_plus(w, x))
        or (not _pos(extension, A_ENTITIES, x))
        or (not a_p_neg(w, extension))
        or (not _neg(extension, A_ENTITIES, x))
        for w in A_WORLDS
        for x in A_ENTITIES
        for extension in A_ADMISSIBLE
    )


def a_cons_g_g():
    return all(
        (not a_god_plus(w, x))
        or (not _pos(extension, A_ENTITIES, x))
        or (not _neg(extension, A_ENTITIES, x))
        for w in A_WORLDS
        for x in A_ENTITIES
        for extension in A_ADMISSIBLE
    )


def a_entail_plus(w, x_extension, y_extension):
    return all(
        (not _pos(x_extension, A_ENTITIES, x))
        or _pos(y_extension, A_ENTITIES, x)
        for z in A_ACCESS[w]
        for x in A_ENTITIES
        if (z, x) in A_EXISTS
    )


def a_ess_plus(w, extension, x):
    return (
        a_admissible(extension)
        and _pos(extension, A_ENTITIES, x)
        and all(
            (not _pos(y_extension, A_ENTITIES, x))
            or a_entail_plus(w, extension, y_extension)
            for y_extension in A_ADMISSIBLE
        )
    )


def validate_neg_class_consistency_strictness():
    assert all(a_admissible(_negate(x)) for x in A_ADMISSIBLE)
    assert a_a1_left()
    assert not a_a1_right()
    assert a_god_plus("w0", "a")
    assert _pos(A_G_EXTENSION["w0"], A_ENTITIES, "a") == a_god_plus("w0", "a")
    assert a_comp_p_g()
    assert a_neg_class_consistency()
    assert not a_cons_g_g()
    assert a_ess_plus("w0", A_G_EXTENSION["w0"], "a")
    return True


# ---------------------------------------------------------------------------
# Fixture B: positive G-extension stability is strictly weaker than full
# bilateral stability even under A1-L, A1-R and the full old REG_G package.
# Positive membership in G is {a} at both worlds; only negative information
# about b drifts from F to N.
# ---------------------------------------------------------------------------

B_WORLDS = ("w0", "w1")
B_ENTITIES = ("a", "b")

B_G0 = (Val.T, Val.F)
B_NOT_G0 = _negate(B_G0)
B_G1 = (Val.T, Val.N)
B_NOT_G1 = _negate(B_G1)
B_ALL = (Val.T, Val.T)
B_EMPTY = _negate(B_ALL)
B_ADMISSIBLE = (B_G0, B_NOT_G0, B_G1, B_NOT_G1, B_ALL, B_EMPTY)

B_ACCESS = {w: B_WORLDS for w in B_WORLDS}
B_EXISTS = frozenset((w, x) for w in B_WORLDS for x in B_ENTITIES)
B_G_EXTENSION = {"w0": B_G0, "w1": B_G1}
B_NE_EXTENSION = {w: B_ALL for w in B_WORLDS}


def b_admissible(extension):
    return extension in B_ADMISSIBLE


def b_p_pos(_w, extension):
    assert b_admissible(extension)
    return _pos(extension, B_ENTITIES, "a")


def b_p_neg(w, extension):
    return b_p_pos(w, _negate(extension))


def b_god_plus(w, x):
    return all(
        (not b_p_pos(w, extension)) or _pos(extension, B_ENTITIES, x)
        for extension in B_ADMISSIBLE
    )


def b_a1_left():
    return all(
        (not b_p_neg(w, extension)) or b_p_pos(w, _negate(extension))
        for w in B_WORLDS
        for extension in B_ADMISSIBLE
    )


def b_a1_right():
    return all(
        (not b_p_pos(w, _negate(extension))) or b_p_neg(w, extension)
        for w in B_WORLDS
        for extension in B_ADMISSIBLE
    )


def b_g_realization():
    return all(
        _pos(B_G_EXTENSION[w], B_ENTITIES, x) == b_god_plus(w, x)
        for w in B_WORLDS
        for x in B_ENTITIES
    )


def b_comp_p_g():
    return all(
        (not b_god_plus(w, x))
        or (not _pos(extension, B_ENTITIES, x))
        or b_p_pos(w, extension)
        or b_p_neg(w, extension)
        for w in B_WORLDS
        for x in B_ENTITIES
        for extension in B_ADMISSIBLE
    )


def b_cons_g_g():
    return all(
        (not b_god_plus(w, x))
        or (not _pos(extension, B_ENTITIES, x))
        or (not _neg(extension, B_ENTITIES, x))
        for w in B_WORLDS
        for x in B_ENTITIES
        for extension in B_ADMISSIBLE
    )


def b_neg_class_consistency():
    return all(
        (not b_god_plus(w, x))
        or (not _pos(extension, B_ENTITIES, x))
        or (not b_p_neg(w, extension))
        or (not _neg(extension, B_ENTITIES, x))
        for w in B_WORLDS
        for x in B_ENTITIES
        for extension in B_ADMISSIBLE
    )


def b_entail_plus(w, x_extension, y_extension):
    return all(
        (not _pos(x_extension, B_ENTITIES, x))
        or _pos(y_extension, B_ENTITIES, x)
        for z in B_ACCESS[w]
        for x in B_ENTITIES
        if (z, x) in B_EXISTS
    )


def b_ess_plus(w, extension, x):
    return (
        b_admissible(extension)
        and _pos(extension, B_ENTITIES, x)
        and all(
            (not _pos(y_extension, B_ENTITIES, x))
            or b_entail_plus(w, extension, y_extension)
            for y_extension in B_ADMISSIBLE
        )
    )


def b_box_exists_plus(w, extension):
    return all(
        any(
            (z, x) in B_EXISTS and _pos(extension, B_ENTITIES, x)
            for x in B_ENTITIES
        )
        for z in B_ACCESS[w]
    )


def b_ne_plus(w, x):
    return all(
        (not b_ess_plus(w, extension, x)) or b_box_exists_plus(w, extension)
        for extension in B_ADMISSIBLE
    )


def b_ne_realization():
    return all(
        _pos(B_NE_EXTENSION[w], B_ENTITIES, x) == b_ne_plus(w, x)
        for w in B_WORLDS
        for x in B_ENTITIES
    )


def b_a5_plus():
    return all(b_p_pos(w, B_NE_EXTENSION[w]) for w in B_WORLDS)


def b_g_pos_stable():
    return all(
        _pos(B_G_EXTENSION[w], B_ENTITIES, x)
        == _pos(B_G_EXTENSION[z], B_ENTITIES, x)
        for w in B_WORLDS
        for z in B_ACCESS[w]
        for x in B_ENTITIES
    )


def b_g_bilateral_stable():
    return all(
        (
            _pos(B_G_EXTENSION[w], B_ENTITIES, x)
            == _pos(B_G_EXTENSION[z], B_ENTITIES, x)
        )
        and (
            _neg(B_G_EXTENSION[w], B_ENTITIES, x)
            == _neg(B_G_EXTENSION[z], B_ENTITIES, x)
        )
        for w in B_WORLDS
        for z in B_ACCESS[w]
        for x in B_ENTITIES
    )


def b_possible_g_de_dicto(w):
    return any(
        (z, x) in B_EXISTS and b_god_plus(z, x)
        for z in B_ACCESS[w]
        for x in B_ENTITIES
    )


def b_necessary_g_de_dicto(w):
    return all(
        any(
            (z, x) in B_EXISTS and b_god_plus(z, x)
            for x in B_ENTITIES
        )
        for z in B_ACCESS[w]
    )


def validate_positive_stability_strictness():
    assert all(b_admissible(_negate(x)) for x in B_ADMISSIBLE)
    assert b_a1_left()
    assert b_a1_right()
    assert b_g_realization()
    assert b_comp_p_g()
    assert b_cons_g_g()
    assert b_neg_class_consistency()
    assert b_ne_realization()
    assert b_a5_plus()

    assert b_god_plus("w0", "a")
    assert b_god_plus("w1", "a")
    assert not b_god_plus("w0", "b")
    assert not b_god_plus("w1", "b")

    assert b_g_pos_stable()
    assert not b_g_bilateral_stable()

    assert b_possible_g_de_dicto("w0")
    assert b_necessary_g_de_dicto("w0")
    assert b_necessary_g_de_dicto("w1")
    return True


if __name__ == "__main__":
    assert validate_neg_class_consistency_strictness()
    assert validate_positive_stability_strictness()
    print("Gate 8 Fitting minimality fixtures: OK")
