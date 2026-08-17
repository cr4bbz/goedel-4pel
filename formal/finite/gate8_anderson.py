from checker import FiniteModel, Val
from gate8_compare import anderson_god_plus, anderson_nec_ex_plus


def a1_right(model):
    """Anderson-retained A1a in the project's signed orientation.

    +P(not p) => -P(p)
    """
    return all(
        (not model.pval(w, model.complement[p]).pos) or model.pval(w, p).neg
        for w in model.worlds
        for p in model.properties
    )


def anderson_g_realization(model):
    return all(
        model.val(w, x, "G").pos == anderson_god_plus(model, w, x)
        for w in model.worlds
        for x in model.entities
    )


def anderson_g_positive(model):
    return all(model.pval(w, "G").pos for w in model.worlds)


def anderson_ess_plus(model, w, essence, x):
    return all(
        anderson_nec_ex_plus(model, w, x, p) == model.nent_plus(w, essence, p)
        for p in model.properties
    )


def box_exists_plus(model, w, p):
    return all(
        any(
            (v, x) in model.exists and model.val(v, x, p).pos
            for x in model.entities
        )
        for v in model.accessible(w)
    )


def anderson_ne_plus(model, w, x):
    return all(
        (not anderson_ess_plus(model, w, p, x)) or box_exists_plus(model, w, p)
        for p in model.properties
    )


def anderson_ne_realization(model):
    return all(
        model.val(w, x, "NEA").pos == anderson_ne_plus(model, w, x)
        for w in model.worlds
        for x in model.entities
    )


def anderson_ne_positive(model):
    return all(model.pval(w, "NEA").pos for w in model.worlds)


def possible_g_everywhere(model):
    return all(
        any(
            (v, x) in model.exists and model.val(v, x, "G").pos
            for v in model.accessible(w)
            for x in model.entities
        )
        for w in model.worlds
    )


def anderson_t3_plus(model):
    return all(box_exists_plus(model, w, "G") for w in model.worlds)


def q_application_modal_collapse_fails(model):
    """Witness failure of +Q(a) => +Box Q(a)."""
    return any(
        model.val(w, x, "Q").pos
        and any(
            not model.val(v, x, "Q").pos
            for v in model.accessible(w)
        )
        for w in model.worlds
        for x in model.entities
    )


def anderson_no_collapse_model():
    """Two-world positive-interface Anderson fixture with an indifferent Q.

    `G` and `NEA` are necessarily exemplified and positively supported.
    `Q` is true only at w0; both Q and notQ are positivity gaps (N), matching
    Anderson's room for indifferent properties after Scott's A1b is dropped.
    """
    worlds = ("w0", "w1")
    entities = ("a",)
    props = ("G", "notG", "NEA", "notNEA", "Q", "notQ")
    comp = {
        "G": "notG",
        "notG": "G",
        "NEA": "notNEA",
        "notNEA": "NEA",
        "Q": "notQ",
        "notQ": "Q",
    }
    access = frozenset((w, v) for w in worlds for v in worlds)
    exists = frozenset((w, "a") for w in worlds)
    ext = {
        ("w0", "a", "G"): Val.T,
        ("w1", "a", "G"): Val.T,
        ("w0", "a", "notG"): Val.F,
        ("w1", "a", "notG"): Val.F,
        ("w0", "a", "NEA"): Val.T,
        ("w1", "a", "NEA"): Val.T,
        ("w0", "a", "notNEA"): Val.F,
        ("w1", "a", "notNEA"): Val.F,
        ("w0", "a", "Q"): Val.T,
        ("w1", "a", "Q"): Val.F,
        ("w0", "a", "notQ"): Val.F,
        ("w1", "a", "notQ"): Val.T,
    }
    positivity = {}
    for w in worlds:
        positivity[(w, "G")] = Val.T
        positivity[(w, "notG")] = Val.F
        positivity[(w, "NEA")] = Val.T
        positivity[(w, "notNEA")] = Val.F
        positivity[(w, "Q")] = Val.N
        positivity[(w, "notQ")] = Val.N
    return FiniteModel(worlds, entities, props, comp, access, exists, ext, positivity)


def validate_anderson_no_collapse_model():
    model = anderson_no_collapse_model()
    assert model.complement_extensions()
    assert a1_right(model)
    assert model.a2_plus()
    assert model.r_plus()
    assert anderson_g_realization(model)
    assert anderson_g_positive(model)
    assert anderson_ne_realization(model)
    assert anderson_ne_positive(model)
    assert possible_g_everywhere(model)
    assert anderson_t3_plus(model)
    assert anderson_ess_plus(model, "w0", "G", "a")
    assert anderson_ess_plus(model, "w1", "G", "a")
    assert model.pval("w0", "Q") == Val.N
    assert model.pval("w0", "notQ") == Val.N
    assert q_application_modal_collapse_fails(model)
    return True


if __name__ == "__main__":
    assert validate_anderson_no_collapse_model()
    print("Gate 8 Anderson positive-chain / no-collapse fixture: OK")
