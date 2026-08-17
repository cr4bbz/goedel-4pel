# Research program

## 1. Main question

The project studies how the inferential architecture of the Gödel–Scott ontological argument changes under a four-valued bilateral modal semantics.

The informational values are:

```text
T = (1,0)   positive support only
F = (0,1)   negative support only
B = (1,1)   both positive and negative support
N = (0,0)   neither positive nor negative support
```

The methodological core is to keep `B` and `N` distinct. They represent different structural failures: inconsistency and incompleteness.

## 2. Why Gödel–Scott is a useful test theory

Gödel–Scott is unusually suitable because:

1. it has a compact and well-studied axiom/theorem chain;
2. modal collapse is a known structural phenomenon;
3. positivity is a sensitive higher-order primitive;
4. essence and necessary existence expose modal dependency structure;
5. existing mechanizations provide a classical comparison target;
6. the theory contains several proof steps where classical bivalence may be doing hidden work.

## 3. How the research target changed

The project originally asked whether modal collapse itself decomposes into independent positive and negative persistence principles.

The informative pair is:

```text
MC+ : +φ => +□φ
MC- : -φ => +□¬φ
```

Gate 4 proves:

```text
MC+ <-> MC-
```

under involutive FDE negation, because `-φ` is equivalent to `+¬φ` and the schemata range over all formulas.

The original separation conjecture is therefore falsified for the current semantics and is not rescued by changing the semantics ad hoc.

The research target has moved **upstream**.

## 4. Current strongest structural picture

The reconstructed positive Scott-control branch is now:

```text
A1-R + A2+ + A3-T
          |
          v
      +◇∃ᴱx G(x)

A1-L + R+ + REG_G + G-sup
          |
          v
          T2+

A5+ + T2+ + NE-sup + S5
          |
          v
          T3+
          |
          v
          GW

T2+ + T3+ + CONST
          |
          v
          MC+
          |
      FDE negation
          v
          MC-
```

The two directions of Scott A1 have different proof-theoretic jobs:

```text
A1-R -> truth-only positive-property exemplification / T1
A1-L -> sufficient recovery route for Godlikeness-as-essence / T2
```

A5 behaves differently again: only positive support for `P(NE)` is needed once a positive God-like witness already exists.

## 5. The decisive T2 obstruction

The principal target is now:

```text
T2+ : +G(x) => +Ess(G,x)
```

A natural bilateral essence semantics does not make T2 automatic.

Gate 6 supplies two explicit two-world S5 countermodels satisfying the Gate-5 control stack plus strong A1 and positive rigidity:

- **glut countermodel:** a property is positively and negatively exemplified by one positive God-like witness but is not positively shared by another accessible positive God-like witness;
- **gap countermodel:** a locally positively exemplified property has `P(Z)=P(¬Z)=N` and is not necessarily shared.

Thus the classical proof of T2 contains informational regularity that is not supplied automatically by the four-valued background logic.

A sufficient recovery package is:

```text
COMP_P^G : relevant positivity completeness
CONS_G^G : relevant exemplification consistency
REG_G    : COMP_P^G + CONS_G^G

A1-L + R+ + G-sup-v0.1 + REG_G => T2+
```

The current package is not claimed globally minimal. The main semantic-minimality problem is to replace it with the weakest principled conditions possible.

## 6. Necessary existence is comparatively robust

Gate 6 defines bilateral necessary existence and distinguishes:

```text
A5+ : +P(NE)
A5-T : Pos_T(NE)
```

Only `A5+` is required for the positive T3 branch once a God-like witness exists.

Hence a glut

```text
P(NE)=B
```

can coexist with the positive theorem chain. A positive God-like witness may then satisfy both `+NE` and `-NE`, while the positive component still supports the T3 derivation.

This is a concrete inconsistency-tolerance result.

## 7. Essence compresses the collapse proof

Once positive T2 and positive T3 are available:

```text
T2+ + T3+ + CONST => MC+
```

and Gate 4 gives `MC-` automatically.

This means the earlier Gate-4 reflection package is not a set of globally necessary premises for collapse. It is one lower-level route for deriving the necessary-sharing behavior that T2 packages directly.

The dependency analysis should therefore distinguish:

```text
route-specific sufficient conditions
```

from

```text
globally necessary conditions for theorem validity
```

throughout the rest of the project.

## 8. Strongest candidate contribution

The strongest current paper target is no longer a bilateral separation theorem for modal collapse.

It is a **T2 obstruction/minimality result** of the following form:

1. define a natural four-valued Scott control semantics with classical recovery;
2. prove that natural support-based essence does not yield T2 automatically;
3. provide separate finite glut and gap countermodels;
4. identify a principled sufficient package for recovering T2;
5. prove that conditional T2 reconstructs T3 and modal collapse;
6. mechanize the dependency chain and minimize the sufficient package.

A successful result would explain exactly which information-theoretic content classical bivalence contributes to Scott's proof that Godlikeness is an essence.

## 9. Required results before any novelty claim

A publication-strength result should include:

- precise four-valued semantics;
- classical recovery end-to-end;
- explicit finite countermodels to failed implications;
- machine-checked positive dependency results;
- minimization of the T2 recovery assumptions;
- separation of semantic definitions from additional regularity assumptions;
- comparison with the frozen Scott theory;
- dedicated prior-art search focused on four-valued/paraconsistent ontological arguments, non-classical positivity, and non-classical essence/necessary-existence semantics.

## 10. Current result shapes

### Result A — T2 obstruction theorem
Natural support-based four-valued essence does not make positive Godlikeness an essence under the primitive Scott-control assumptions.

### Result B — Glut/gap separation at T2
There are distinct finite countermodels showing inconsistency and incompleteness obstruct T2 by different mechanisms.

### Result C — Conditional T2 recovery theorem
A targeted consistency/completeness package recovers T2 from `A1-L + R+ + G-sup`.

### Result D — Conditional T3 reconstruction
Possible positive Godlikeness plus positive T2 and `A5+` yields positive necessary God-like existence in S5.

### Result E — Essence-compressed collapse theorem
`T2+ + T3+ + CONST` yields modal collapse.

### Result F — Inconsistency-tolerance theorem
A glutty positivity status for necessary existence can coexist with the positive T3 branch.

### Result G — Minimality refinement
A weaker principled substitute for `REG_G` suffices for T2, or finite search proves that two independent informational controls remain necessary in a precisely stated fragment.

## 11. Design discipline

Every non-classical axiom or semantic definition receives an explicit name/version. Do not write "the four-valued version" when multiple inequivalent liftings exist.

Do not conflate:

```text
-□φ
```

with universal negative persistence. Under the fixed modal semantics `-□φ` means that some accessible world negatively supports `φ`; universal negative persistence is represented by `+□¬φ` or `-◇φ`.

Do not promote route-specific regularity assumptions such as `REG_G` to global metaphysical axioms merely because they recover a classical proof step.

Countermodels are first-class research objects. A failed theorem with a small explanatory countermodel is a positive result.

## 12. Immediate next phase

Gate 7 should mechanize and minimize rather than introduce more semantic machinery.

Priority order:

```text
1. executable finite model checker for current semantics
2. reproduce T1 and T2 countermodels
3. Lean encoding of settled semantic clauses
4. machine-check conditional T2/T3/MC theorems
5. search assumption lattice below REG_G
6. verify end-to-end classical recovery
```

Only after that should the project vary Godlikeness definitions, modal logics, or neighborhood semantics.
