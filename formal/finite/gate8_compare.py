from checker import FiniteModel, Val, t2_gap_countermodel, t2_glut_countermodel


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


def run_gate8_comparison():
    glut = t2_glut_countermodel()
    gap = t2_gap_countermodel()
    assert glut.god_plus_derived("w0", "a") and not god_exact_plus(glut, "w0", "a")
    assert gap.god_plus_derived("w0", "a") and not god_exact_plus(gap, "w0", "a")

    exact = exact_glut_model()
    assert exact.complement_extensions()
    assert exact.strong_a1()
    assert exact.r_plus()
    assert g_exact_sup(exact)
    assert god_exact_plus(exact, "w0", "a")
    assert exact.val("w0", "a", "Z") == Val.B
    assert exact.pval("w0", "Z") == Val.B
    return True


if __name__ == "__main__":
    assert run_gate8_comparison()
    print("Gate 8 support/exact comparison: OK")
