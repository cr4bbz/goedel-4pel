from checker import FiniteModel, Val, require, t2_gap_countermodel, t2_glut_countermodel


def god_exact_plus(model, w, x):
    return all(
        model.val(w, x, p).pos == model.pval(w, p).pos
        for p in model.properties
    )


def g_exact_sup(model):
    return all(
        model.val(w, x, "G").pos == god_exact_plus(model, w, x)
        for w in model.worlds for x in model.entities
    )


def anderson_nec_ex_plus(model, w, x, p):
    return all(
        model.val(v, x, p).pos
        for v in model.accessible(w)
    )


def anderson_god_plus(model, w, x):
    """Positive Anderson interface: +P(p) iff x necessarily +exemplifies p."""
    return all(
        model.pval(w, p).pos == anderson_nec_ex_plus(model, w, x, p)
        for p in model.properties
    )


def exact_glut_model():
    worlds = ("w0",)
    entities = ("a",)
    props = ("G", "notG", "Z", "notZ")
    comp = {"G": "notG", "notG": "G", "Z": "notZ", "notZ": "Z"}
    return FiniteModel(
        worlds,
        entities,
        props,
        comp,
        frozenset({("w0", "w0")}),
        frozenset({("w0", "a")}),
        {
            ("w0", "a", "G"): Val.T,
            ("w0", "a", "notG"): Val.F,
            ("w0", "a", "Z"): Val.B,
            ("w0", "a", "notZ"): Val.B,
        },
        {
            ("w0", "G"): Val.T,
            ("w0", "notG"): Val.F,
            ("w0", "Z"): Val.B,
            ("w0", "notZ"): Val.B,
        },
    )


def anderson_not_exact_model():
    """A contingent property may be Anderson-indifferent but currently exemplified."""
    worlds = ("w0", "w1")
    entities = ("a",)
    props = ("G", "notG", "Z", "notZ")
    comp = {"G": "notG", "notG": "G", "Z": "notZ", "notZ": "Z"}
    access = frozenset((w, v) for w in worlds for v in worlds)
    exists = frozenset((w, "a") for w in worlds)
    ext = {
        ("w0", "a", "G"): Val.T,
        ("w1", "a", "G"): Val.T,
        ("w0", "a", "notG"): Val.F,
        ("w1", "a", "notG"): Val.F,
        ("w0", "a", "Z"): Val.T,
        ("w1", "a", "Z"): Val.F,
        ("w0", "a", "notZ"): Val.F,
        ("w1", "a", "notZ"): Val.T,
    }
    positivity = {}
    for w in worlds:
        positivity[(w, "G")] = Val.T
        positivity[(w, "notG")] = Val.F
        # Anderson permits indifferent properties after dropping Scott's A1b.
        positivity[(w, "Z")] = Val.F
        positivity[(w, "notZ")] = Val.F
    return FiniteModel(worlds, entities, props, comp, access, exists, ext, positivity)


def exact_not_anderson_model():
    """Local exactness does not by itself force necessary exemplification."""
    worlds = ("w0", "w1")
    entities = ("a",)
    props = ("G", "notG", "Z", "notZ")
    comp = {"G": "notG", "notG": "G", "Z": "notZ", "notZ": "Z"}
    access = frozenset((w, v) for w in worlds for v in worlds)
    exists = frozenset((w, "a") for w in worlds)
    ext = {
        ("w0", "a", "G"): Val.T,
        ("w1", "a", "G"): Val.T,
        ("w0", "a", "notG"): Val.F,
        ("w1", "a", "notG"): Val.F,
        ("w0", "a", "Z"): Val.T,
        ("w1", "a", "Z"): Val.F,
        ("w0", "a", "notZ"): Val.F,
        ("w1", "a", "notZ"): Val.T,
    }
    positivity = {
        ("w0", "G"): Val.T,
        ("w0", "notG"): Val.F,
        ("w0", "Z"): Val.T,
        ("w0", "notZ"): Val.F,
        ("w1", "G"): Val.T,
        ("w1", "notG"): Val.F,
        ("w1", "Z"): Val.T,
        ("w1", "notZ"): Val.F,
    }
    return FiniteModel(worlds, entities, props, comp, access, exists, ext, positivity)


def run_gate8_comparison():
    glut = t2_glut_countermodel()
    gap = t2_gap_countermodel()
    require(glut.god_plus_derived("w0", "a") and not god_exact_plus(glut, "w0", "a"))
    require(gap.god_plus_derived("w0", "a") and not god_exact_plus(gap, "w0", "a"))

    exact = exact_glut_model()
    require(exact.complement_extensions())
    require(exact.strong_a1())
    require(exact.r_plus())
    require(g_exact_sup(exact))
    require(god_exact_plus(exact, "w0", "a"))
    require(exact.val("w0", "a", "Z") == Val.B)
    require(exact.pval("w0", "Z") == Val.B)

    anderson = anderson_not_exact_model()
    require(anderson_god_plus(anderson, "w0", "a"))
    require(anderson.god_plus_derived("w0", "a"))
    require(not god_exact_plus(anderson, "w0", "a"))

    local_exact = exact_not_anderson_model()
    require(god_exact_plus(local_exact, "w0", "a"))
    require(local_exact.god_plus_derived("w0", "a"))
    require(not anderson_god_plus(local_exact, "w0", "a"))
    return True


if __name__ == "__main__":
    require(run_gate8_comparison())
    print("Gate 8 support/exact/Anderson comparison: OK")
