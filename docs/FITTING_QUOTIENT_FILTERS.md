# Gate 10 — Four-valued delta-filters on the quotient algebra

**Milestone:** `fitting-quotient-filter-v0.1`

**Status:** Lean-machine-checked core and exhaustive finite algebra audit
**Source boundary:** informed by Font's De Morgan-lattice analysis and Přenosil's filters/upsets; not identified with Fitting's classical ultrafilter without qualification

## Definition

On bilateral quotient extensions, use the FDE truth order:

```text
X <=t Y  iff
  positive_support(X) subset positive_support(Y)
  and negative_support(Y) subset negative_support(X).
```

A positive delta-filter `F` is:

1. proper: `top ∈ F` and `bottom ∉ F`;
2. upward closed in `<=t`;
3. closed under FDE conjunction.

Lean also defines lattice primeness and the weaker non-adjunctive `2`-filter law. Under classical coherence (`-X(x) ↔ not +X(x)`), the truth order reduces exactly to ordinary inclusion of positive extensions. This verifies the intended classical boundary without imposing coherence on the four-valued algebra.

## General separation theorem

For any point `q`, define the evaluation filter

```text
F_q(X) iff +X(q).
```

Lean proves that `F_q` is a proper prime delta-filter. It designates the constant glut extension `B`, while the constant gap extension `N` and its FDE negation remain undesignated. Since `N` is a negation fixed point,

```text
not (forall X, F_q(X) or F_q(neg X)).
```

Therefore primeness of a four-valued delta-filter does not imply the complement-decision condition used by the earlier ultrafilter comparison. Every inhabited positive-profile quotient carries such a non-deciding prime filter.

This is an unbounded Lean theorem about the abstract extension algebra, not merely a finite example.

## Exhaustive two-point audit

`formal/finite/gate10_quotient_delta_filters.py` enumerates all families of the 16 bilateral extensions over two quotient points. It finds:

```text
proper truth-order upsets:       166
ordinary delta-filters:           15
prime delta-filters:               4
proper 2-filters:                112
prime 2-filters:                  10
non-deciding prime delta-filters:  4
```

All four prime ordinary filters fail complement decision because of gaps.

The fixture additionally isolates two structures:

- the union of the two point-evaluation filters is a prime `2`-filter but not an ordinary filter, demonstrating the non-adjunctive branch;
- the intersection filter, requiring positive membership at both quotient points, is an ordinary proper delta-filter with two positive-Godlike points. The extension `(T,N)` is possessed positively at the first point but neither it nor its FDE negation lies in the filter. Hence the local `COMP` interface fails non-vacuously in this bounded model.

## Research conclusion

The quotient algebra admits a genuinely four-valued filter notion with a clean classical limit. Neither ordinary filter closure nor primeness automatically restores complement decision. The next question is no longer whether a filter can preserve gaps and gluts—it can—but which additional filter strength is sufficient for the desired Fitting essence/NE route without reproducing the earlier classification package.

No claim is made that this definition is the unique four-valued analogue of Fitting's `delta`-filter.
