"""Finite regression for the Gate-8 actualist positive-profile quotient."""

from itertools import product

from checker import Val


ENTITIES = ("a", "b")
ALL_EXTENSIONS = tuple(product(tuple(Val), repeat=len(ENTITIES)))


def idx(entity):
    return ENTITIES.index(entity)


def pos(extension, entity):
    return extension[idx(entity)].pos


def neg(extension, entity):
    return extension[idx(entity)].neg


def val(pos_support, neg_support):
    return Val((int(bool(pos_support)), int(bool(neg_support))))


def p_pos(extension):
    # The fixture's positive extensions contain both entities positively, so
    # positivity observes a and b as one class while the ambient extension
    # universe can still distinguish them.
    return all(pos(extension, entity) for entity in ENTITIES)


def positive_profile_eq(left, right):
    return all(
        pos(extension, left) == pos(extension, right)
        for extension in ALL_EXTENSIONS
        if p_pos(extension)
    )


def profile_classes():
    remaining = list(ENTITIES)
    classes = []
    while remaining:
        representative = remaining.pop(0)
        block = tuple(
            entity
            for entity in ENTITIES
            if positive_profile_eq(representative, entity)
        )
        classes.append(block)
        remaining = [entity for entity in remaining if entity not in block]
    return tuple(classes)


def profile_saturate(extension):
    return tuple(
        val(
            any(
                positive_profile_eq(entity, witness) and pos(extension, witness)
                for witness in ENTITIES
            ),
            any(
                positive_profile_eq(entity, witness) and neg(extension, witness)
                for witness in ENTITIES
            ),
        )
        for entity in ENTITIES
    )


def respects_profile(extension):
    return all(
        extension[idx(left)] == extension[idx(right)]
        for left in ENTITIES
        for right in ENTITIES
        if positive_profile_eq(left, right)
    )


def to_quotient(extension):
    assert respects_profile(extension)
    return tuple(extension[idx(block[0])] for block in profile_classes())


def from_quotient(quotient_extension):
    classes = profile_classes()
    return tuple(
        quotient_extension[
            next(i for i, block in enumerate(classes) if entity in block)
        ]
        for entity in ENTITIES
    )


def quotient_exists(actual_entities):
    """Return class-level existence, or None when representatives disagree."""
    values = []
    for block in profile_classes():
        block_values = {entity in actual_entities for entity in block}
        if len(block_values) != 1:
            return None
        values.append(block_values.pop())
    return tuple(values)


def entail_entities(source, target, actual_entities):
    return all(
        (not pos(source, entity)) or pos(target, entity)
        for entity in actual_entities
    )


def entail_quotient(source, target, actual_classes):
    return all(
        (not source[index].pos) or target[index].pos
        for index, exists in enumerate(actual_classes)
        if exists
    )


def validate_actualist_profile_quotient():
    classes = profile_classes()
    assert classes == (("a", "b"),)

    actual_entities = frozenset(ENTITIES)
    actual_classes = quotient_exists(actual_entities)
    assert actual_classes == (True,)

    for extension in ALL_EXTENSIONS:
        saturated = profile_saturate(extension)
        assert respects_profile(saturated)
        assert from_quotient(to_quotient(saturated)) == saturated

    for source in ALL_EXTENSIONS:
        for target in ALL_EXTENSIONS:
            saturated_source = profile_saturate(source)
            saturated_target = profile_saturate(target)
            assert entail_entities(
                saturated_source, saturated_target, actual_entities
            ) == entail_quotient(
                to_quotient(saturated_source),
                to_quotient(saturated_target),
                actual_classes,
            )

    # The quotient is not silently classical: both a glut and a gap survive.
    assert to_quotient(profile_saturate((Val.B, Val.N))) == (Val.B,)
    assert to_quotient(profile_saturate((Val.N, Val.N))) == (Val.N,)
    return True


def validate_actualist_quotient_requires_existence_factorization():
    # The sole profile class contains both a and b, but only a exists.  No
    # representative-independent existence predicate can be defined on it.
    split_existence = frozenset({"a"})
    assert quotient_exists(split_existence) is None

    only_b = (Val.F, Val.T)
    empty = (Val.F, Val.F)
    assert entail_entities(only_b, empty, split_existence)
    assert not entail_entities(
        profile_saturate(only_b), profile_saturate(empty), split_existence
    )
    return True


if __name__ == "__main__":
    assert validate_actualist_profile_quotient()
    assert validate_actualist_quotient_requires_existence_factorization()
    print("Gate 8 actualist positive-profile quotient: OK")
