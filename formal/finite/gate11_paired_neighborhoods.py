"""Finite Gate-11 audit of paired neighborhoods on two worlds.

A local paired frame consists of a universal family U and a hit family H,
each a family of subsets of the two-world carrier.  Families and subsets are
encoded as bit masks, so the entire local frame space has only 16 * 16 cases.
"""

from itertools import product

from checker import Val


WORLD_COUNT = 2
FULL_SET = (1 << WORLD_COUNT) - 1
SUBSETS = tuple(range(FULL_SET + 1))
FAMILIES = tuple(range(1 << len(SUBSETS)))


def contains(family, subset):
    return bool(family & (1 << subset))


def complement(subset):
    return FULL_SET ^ subset


def universal_family(successors):
    return sum(
        1 << subset
        for subset in SUBSETS
        if successors & complement(subset) == 0
    )


def hit_family(successors):
    return sum(
        1 << subset for subset in SUBSETS if successors & subset
    )


def is_complement_dual(universal, hit):
    return all(
        contains(universal, subset)
        == (not contains(hit, complement(subset)))
        for subset in SUBSETS
    )


def is_principal_relational(universal, hit):
    return any(
        universal == universal_family(successors)
        and hit == hit_family(successors)
        for successors in SUBSETS
    )


def support_masks(valuation):
    positive = sum(1 << world for world, value in enumerate(valuation) if value.pos)
    negative = sum(1 << world for world, value in enumerate(valuation) if value.neg)
    return positive, negative


def neighborhood_box(universal, hit, valuation):
    positive, negative = support_masks(valuation)
    return Val((contains(universal, positive), contains(hit, negative)))


def neighborhood_diamond(universal, hit, valuation):
    positive, negative = support_masks(valuation)
    return Val((contains(hit, positive), contains(universal, negative)))


def relational_box(successors, valuation):
    positive, negative = support_masks(valuation)
    return Val(
        (
            successors & complement(positive) == 0,
            bool(successors & negative),
        )
    )


def relational_diamond(successors, valuation):
    positive, negative = support_masks(valuation)
    return Val(
        (
            bool(successors & positive),
            successors & complement(negative) == 0,
        )
    )


def validate_paired_neighborhoods():
    """Exhaust the bounded bridge and return structural counts."""

    local_frames = tuple(product(FAMILIES, repeat=2))
    complement_dual = tuple(
        frame for frame in local_frames if is_complement_dual(*frame)
    )
    principal = tuple(
        frame for frame in local_frames if is_principal_relational(*frame)
    )

    assert len(local_frames) == 256
    assert len(complement_dual) == 16
    assert len(principal) == 4
    assert set(principal) <= set(complement_dual)

    valuations = tuple(product(tuple(Val), repeat=WORLD_COUNT))
    relational_checks = 0
    for relation in range(1 << (WORLD_COUNT * WORLD_COUNT)):
        for world in range(WORLD_COUNT):
            successors = (relation >> (world * WORLD_COUNT)) & FULL_SET
            universal = universal_family(successors)
            hit = hit_family(successors)
            for valuation in valuations:
                assert neighborhood_box(universal, hit, valuation) == relational_box(
                    successors, valuation
                )
                assert neighborhood_diamond(
                    universal, hit, valuation
                ) == relational_diamond(successors, valuation)
                relational_checks += 2

    classical_outputs = set()
    for universal, hit in complement_dual:
        for positive in SUBSETS:
            valuation = tuple(
                Val.T if positive & (1 << world) else Val.F
                for world in range(WORLD_COUNT)
            )
            classical_outputs.add(neighborhood_box(universal, hit, valuation))
            classical_outputs.add(neighborhood_diamond(universal, hit, valuation))
    assert classical_outputs == {Val.T, Val.F}

    arbitrary_classical_outputs = set()
    witnesses = {}
    for universal, hit in local_frames:
        for positive in SUBSETS:
            valuation = tuple(
                Val.T if positive & (1 << world) else Val.F
                for world in range(WORLD_COUNT)
            )
            for operator, output in (
                ("box", neighborhood_box(universal, hit, valuation)),
                ("diamond", neighborhood_diamond(universal, hit, valuation)),
            ):
                arbitrary_classical_outputs.add(output)
                witnesses.setdefault(output, (universal, hit, positive, operator))
    assert arbitrary_classical_outputs == set(Val)
    assert not is_complement_dual(*witnesses[Val.B][:2])
    assert not is_complement_dual(*witnesses[Val.N][:2])

    return {
        "local_frames": len(local_frames),
        "complement_dual_frames": len(complement_dual),
        "principal_relational_frames": len(principal),
        "nonprincipal_complement_dual_frames": len(complement_dual) - len(principal),
        "relational_operator_checks": relational_checks,
        "classical_outputs_under_cd": len(classical_outputs),
        "arbitrary_classical_outputs": len(arbitrary_classical_outputs),
        "both_witness": witnesses[Val.B],
        "neither_witness": witnesses[Val.N],
    }


if __name__ == "__main__":
    for key, value in validate_paired_neighborhoods().items():
        print(f"{key}: {value}")
