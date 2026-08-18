# Gate 11 — machine-checked paired-neighborhood bridge

**Milestone:** `paired-neighborhood-bridge-v0.1`

## Question

Can the bilateral Kripke control semantics be embedded exactly into the paired-neighborhood semantics already specified in `MODAL_LIFT.md`, while keeping the effects of non-principality and failure of complement duality separately observable?

## Formal interface

For each world `w`, a paired frame contains two predicates on world sets:

```text
U(w, X)  universal/core membership
H(w, X)  hit/witness membership
```

The four signed clauses use them crosswise:

```text
+Box phi      iff U(w, |phi|+)
-Box phi      iff H(w, |phi|-)
+Diamond phi  iff H(w, |phi|+)
-Diamond phi  iff U(w, |phi|-)
```

`formal/lean/Goedel4PEL/FourValued/PairedNeighborhood.lean` now machine-checks:

1. bilateral box/diamond duality for every paired frame when negation exchanges positive and negative support;
2. the canonical relational construction

   ```text
   U_R(w,X) iff every R-successor of w lies in X
   H_R(w,X) iff some R-successor of w lies in X;
   ```

3. exact agreement of all four paired clauses with the existing relational clauses;
4. complement duality for every relationally generated pair;
5. classical box and diamond recovery for every complement-dual paired frame.

The representation theorem is definitional at the four modal interfaces: it does not depend on finiteness, S5, or a particular formula language.

## Exhaustive two-world audit

`formal/finite/gate11_paired_neighborhoods.py` encodes the four subsets of a two-world carrier and exhausts every local pair of neighborhood families.

```text
all local (U,H) pairs                 256
complement-dual pairs                  16
principal relational pairs              4
non-principal complement-dual pairs     12
relational operator comparisons       1024
```

The 1024 comparisons range over all 16 two-world relations, both source worlds, all 16 bilateral valuations, and box/diamond. Every paired result agrees with its relational counterpart.

On classically valued inputs, all 16 complement-dual local pairs return only `T` or `F`. Across arbitrary local pairs, the same classically valued inputs realize all four values `T`, `F`, `B`, and `N`. The retained first witnesses show separately that failure of complement duality can create a modal glut or a modal gap without any non-classical atomic input.

## Interpretation

The bounded hierarchy is strict already on two worlds:

```text
principal relational
        proper subset of
complement-dual paired neighborhoods
        proper subset of
arbitrary paired neighborhoods
```

This separates two experimental axes:

- dropping principality adds genuinely non-Kripke modal structure while preserving classical modal bivalence;
- dropping complement duality lets modalization itself generate inconsistency or incompleteness.

The result is a representation bridge, not yet a rerun of the Scott, Anderson, or Fitting theorem stacks. Those stacks quantify over richer predicates and actualist interfaces, so their transport requires theorem-specific neighborhood conditions rather than a blind replacement of `R`.

## Verification

From the repository root:

```powershell
cd formal/lean
lake build
cd ../..
python -m unittest discover -s formal/finite -p test_checker.py
```

The frozen Gate-11 checkpoint is Lean 4.30.0 with 36 build jobs and 30 Python regression tests.

## Next questions

1. Which neighborhood closure conditions replace symmetry in the Scott and Anderson T3 return step?
2. Which paired conditions express the forward and converse positivity transports used by Fitting?
3. Does positive modal collapse remain separable from necessary Godlike existence on non-principal complement-dual frames?
4. What changes when complement duality is deliberately dropped and modal operators may introduce `B` or `N` from classical inputs?
