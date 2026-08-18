"""Finite Gate-10 audit of filters on a two-point quotient FDE algebra."""

from itertools import product

from checker import Val


POINTS = ("a", "b")
EXTENSIONS = tuple(product(tuple(Val), repeat=len(POINTS)))
INDEX = {extension: index for index, extension in enumerate(EXTENSIONS)}


def fde_neg(extension):
    return tuple(Val((value.neg, value.pos)) for value in extension)


def fde_meet(left, right):
    return tuple(
        Val((lvalue.pos and rvalue.pos, lvalue.neg or rvalue.neg))
        for lvalue, rvalue in zip(left, right)
    )


def fde_join(left, right):
    return tuple(
        Val((lvalue.pos or rvalue.pos, lvalue.neg and rvalue.neg))
        for lvalue, rvalue in zip(left, right)
    )


def truth_le(left, right):
    return all(
        (not lvalue.pos or rvalue.pos) and (not rvalue.neg or lvalue.neg)
        for lvalue, rvalue in zip(left, right)
    )


TOP = (Val.T, Val.T)
BOTTOM = (Val.F, Val.F)
NEITHER = (Val.N, Val.N)
BOTH = (Val.B, Val.B)


def is_upset(family):
    return all(
        not truth_le(left, right) or right in family
        for left in family
        for right in EXTENSIONS
    )


def is_delta_filter(family):
    return (
        TOP in family
        and BOTTOM not in family
        and is_upset(family)
        and all(fde_meet(left, right) in family for left in family for right in family)
    )


def is_prime(family):
    return all(
        fde_join(left, right) not in family or left in family or right in family
        for left in EXTENSIONS
        for right in EXTENSIONS
    )


def is_two_filter(family):
    """Non-adjunctive 2-filter law: three pairwise meets force the triple meet."""
    if TOP not in family or BOTTOM in family or not is_upset(family):
        return False
    for left, middle, right in product(EXTENSIONS, repeat=3):
        pair_meets = (
            fde_meet(left, middle),
            fde_meet(left, right),
            fde_meet(middle, right),
        )
        if all(pair_meet in family for pair_meet in pair_meets):
            if fde_meet(fde_meet(left, middle), right) not in family:
                return False
    return True


def complement_deciding(family):
    return all(extension in family or fde_neg(extension) in family for extension in EXTENSIONS)


def all_proper_upsets():
    for bits in range(1 << len(EXTENSIONS)):
        if not bits & (1 << INDEX[TOP]) or bits & (1 << INDEX[BOTTOM]):
            continue
        family = frozenset(
            extension
            for index, extension in enumerate(EXTENSIONS)
            if bits & (1 << index)
        )
        if is_upset(family):
            yield family


def validate_quotient_delta_filters():
    upsets = tuple(all_proper_upsets())
    delta_filters = tuple(family for family in upsets if is_delta_filter(family))
    prime_delta_filters = tuple(family for family in delta_filters if is_prime(family))
    two_filters = tuple(family for family in upsets if is_two_filter(family))
    prime_two_filters = tuple(family for family in two_filters if is_prime(family))

    evaluation_a = frozenset(
        extension for extension in EXTENSIONS if extension[0].pos
    )
    evaluation_union = frozenset(
        extension for extension in EXTENSIONS if extension[0].pos or extension[1].pos
    )
    joint_truth = frozenset(
        extension for extension in EXTENSIONS if extension[0].pos and extension[1].pos
    )

    # Lean's canonical point-evaluation example: prime, glut-designating,
    # and non-deciding because N is fixed by negation.
    assert evaluation_a in prime_delta_filters
    assert BOTH in evaluation_a
    assert NEITHER not in evaluation_a
    assert fde_neg(NEITHER) not in evaluation_a
    assert not complement_deciding(evaluation_a)

    # The non-adjunctive union is a prime 2-filter but not an ordinary filter.
    assert evaluation_union in prime_two_filters
    assert not is_delta_filter(evaluation_union)

    # An ordinary proper filter can be non-vacuous for Godlikeness and still
    # fail the local COMP interface when positivity gaps are allowed.
    assert joint_truth in delta_filters
    godlike_points = tuple(
        point_index
        for point_index in range(len(POINTS))
        if all(extension[point_index].pos for extension in joint_truth)
    )
    assert godlike_points == (0, 1)
    possessed_gap = (Val.T, Val.N)
    assert possessed_gap[0].pos
    assert possessed_gap not in joint_truth
    assert fde_neg(possessed_gap) not in joint_truth

    assert any(not complement_deciding(family) for family in prime_delta_filters)
    assert any(not complement_deciding(family) for family in delta_filters)

    return {
        "proper_upsets": len(upsets),
        "delta_filters": len(delta_filters),
        "prime_delta_filters": len(prime_delta_filters),
        "two_filters": len(two_filters),
        "prime_two_filters": len(prime_two_filters),
        "nondeciding_prime_delta_filters": sum(
            not complement_deciding(family) for family in prime_delta_filters
        ),
    }


if __name__ == "__main__":
    counts = validate_quotient_delta_filters()
    print("Gate 10 quotient delta-filter audit: OK")
    for label, count in counts.items():
        print(f"  {label}: {count}")
