# Four-Valued Modal Lift

## Status

**Gate:** 2 — Modal semantics  
**Version:** `modal-v0.1`  
**Role:** modal extension of `kernel-v0.1` and control semantics for the first Gödel–Scott decomposition experiments

This document fixes the modal layer used immediately after the four-valued propositional kernel. It distinguishes two levels:

1. a conservative **relational bilateral Kripke semantics** (`R-MODAL-v0.1`), adopted as the control semantics for Gates 3–4;
2. a more general **paired-neighborhood semantics** (`PN-MODAL-v0.1`), retained as a controlled generalization and as the bridge to the broader 4PEL/NBVN research programme.

The decision to use the relational semantics first is methodological rather than ideological. The first collapse experiment should vary the four-valued treatment of positivity while holding the modal mechanism as close as possible to the classical Scott control theory. Neighborhood generalization becomes a second experimental axis only after the local rigidity/collapse mechanism is understood.

No object-language four-valued conditional is introduced here.

---

## 1. Preliminaries

Let `W` be a nonempty set of worlds. For every formula `φ` and world `w`, the propositional kernel is evaluated bilaterally:

\[
w\models^+\varphi
\]

means that `φ` has positive support at `w`, and

\[
w\models^-\varphi
\]

means that `φ` has negative support at `w`.

Define the positive and negative extensions of a formula by

\[
\llbracket\varphi\rrbracket^+
:=
\{w\in W\mid w\models^+\varphi\},
\]

\[
\llbracket\varphi\rrbracket^-
:=
\{w\in W\mid w\models^-\varphi\}.
\]

Negation remains the Gate-1 FDE negation:

\[
w\models^+\neg\varphi
\iff
w\models^-\varphi,
\]

\[
w\models^-\neg\varphi
\iff
w\models^+\varphi.
\]

Hence

\[
\llbracket\neg\varphi\rrbracket^+
=
\llbracket\varphi\rrbracket^-,
\qquad
\llbracket\neg\varphi\rrbracket^-
=
\llbracket\varphi\rrbracket^+.
\]

---

# Part I — Relational control semantics

## 2. Bilateral Kripke frames

An `R-MODAL-v0.1` frame is a pair

\[
\mathcal F=(W,R),
\]

where

\[
R\subseteq W\times W.
\]

Write

\[
R[w]:=\{v\in W\mid wRv\}.
\]

The Scott control setting will later take `R` to be an S5 relation, i.e. an equivalence relation. The following semantic clauses themselves do not require S5.

---

## 3. Necessity

The positive and negative clauses for necessity are:

\[
\boxed{
w\models^+\Box\varphi
\iff
\forall v\,(wRv\Rightarrow v\models^+\varphi)
}
\tag{Box+}
\]

and

\[
\boxed{
w\models^-\Box\varphi
\iff
\exists v\,(wRv\land v\models^-\varphi).
}
\tag{Box-}
\]

Equivalently:

\[
w\models^+\Box\varphi
\iff
R[w]\subseteq\llbracket\varphi\rrbracket^+,
\]

\[
w\models^-\Box\varphi
\iff
R[w]\cap\llbracket\varphi\rrbracket^-\neq\varnothing.
\]

Intuitively, positive necessity requires positive support throughout the accessible region, while negative necessity requires an accessible counter-support witness.

This is the conservative Belnapian box pattern used as the relational control lift. It preserves the Gate-1 separation between positive and negative satisfaction rather than collapsing modal evaluation to a single Boolean condition.

---

## 4. Possibility

Possibility is fixed by the corresponding existential/universal bilateral clauses:

\[
\boxed{
w\models^+\Diamond\varphi
\iff
\exists v\,(wRv\land v\models^+\varphi)
}
\tag{Diamond+}
\]

and

\[
\boxed{
w\models^-\Diamond\varphi
\iff
\forall v\,(wRv\Rightarrow v\models^-\varphi).
}
\tag{Diamond-}
\]

Equivalently:

\[
w\models^+\Diamond\varphi
\iff
R[w]\cap\llbracket\varphi\rrbracket^+\neq\varnothing,
\]

\[
w\models^-\Diamond\varphi
\iff
R[w]\subseteq\llbracket\varphi\rrbracket^-.
\]

Thus `□` and `◇` interchange the universal and witness roles of the two information channels.

---

## 5. Modal duality survives bilaterally

### Proposition R1 — Full bilateral duality

Under `R-MODAL-v0.1`:

\[
\Diamond\varphi
\equiv
\neg\Box\neg\varphi
\]

and

\[
\Box\varphi
\equiv
\neg\Diamond\neg\varphi
\]

at both positive and negative satisfaction levels.

More explicitly:

\[
w\models^+\Diamond\varphi
\iff
w\models^+\neg\Box\neg\varphi,
\]

\[
w\models^-\Diamond\varphi
\iff
w\models^-\neg\Box\neg\varphi,
\]

and symmetrically for `□`.

#### Proof sketch

For the positive diamond clause:

\[
\begin{aligned}
w\models^+\neg\Box\neg\varphi
&\iff w\models^-\Box\neg\varphi\\
&\iff \exists v\,(wRv\land v\models^-\neg\varphi)\\
&\iff \exists v\,(wRv\land v\models^+\varphi)\\
&\iff w\models^+\Diamond\varphi.
\end{aligned}
\]

The other clauses follow analogously.

**Status:** established semantically.

This result matters methodologically: the project does not need to choose between primitive `□` and primitive `◇` in the relational control semantics. Nevertheless, both signed clauses remain written explicitly because later neighborhood generalizations may make the source of the duality important.

---

## 6. How modal aggregation produces the four values

Let a world `w` have multiple accessible worlds. Modal aggregation can preserve or create gluts and gaps even when the local successor values differ.

For `□φ`:

| Value of `□φ` at `w` | Condition over accessible worlds |
|---|---|
| `T=(1,0)` | every successor positively supports `φ`, and no successor negatively supports `φ` |
| `F=(0,1)` | positive support fails somewhere, and negative support occurs somewhere |
| `B=(1,1)` | every successor positively supports `φ`, and negative support occurs somewhere |
| `N=(0,0)` | positive support fails somewhere, and no successor negatively supports `φ` |

For `◇φ`:

| Value of `◇φ` at `w` | Condition over accessible worlds |
|---|---|
| `T=(1,0)` | positive support occurs somewhere, and negative support fails somewhere |
| `F=(0,1)` | no successor positively supports `φ`, and every successor negatively supports `φ` |
| `B=(1,1)` | positive support occurs somewhere, and every successor negatively supports `φ` |
| `N=(0,0)` | no successor positively supports `φ`, and negative support fails somewhere |

### Minimal illustrations

If `w` has one successor `v`, then the modal operators simply reproduce the information value of `φ` at `v`:

\[
v(\varphi,v)=B\Rightarrow v(\Box\varphi,w)=v(\Diamond\varphi,w)=B,
\]

\[
v(\varphi,v)=N\Rightarrow v(\Box\varphi,w)=v(\Diamond\varphi,w)=N.
\]

With two successors, genuinely aggregative patterns appear. For example:

- successor values `T,B` give `□φ=B`;
- successor values `T,N` give `□φ=N`;
- successor values `B,F` give `◇φ=B`;
- successor values `F,N` give `◇φ=N`.

These examples will later become small regression models for mechanization.

---

## 7. Classical recovery of the relational modal fragment

### Proposition R2 — Classical modal recovery

Suppose every atomic formula receives only classical values `T` or `F` at every world. Then every formula generated using

\[
\neg,\land,\lor,\Box,\Diamond
\]

also receives only `T` or `F`, and the bilateral clauses coincide with ordinary Kripke semantics.

#### Reason

Gate 1 already establishes closure of `T/F` under the propositional connectives. For a classical-valued `φ`, at each world exactly one of positive or negative satisfaction holds. Hence:

\[
w\models^+\Box\varphi
\]

holds exactly when `φ` is true at every accessible world, while

\[
w\models^-\Box\varphi
\]

holds exactly when `φ` is false at some accessible world. Exactly one clause holds. The argument for `◇` is dual.

Therefore:

\[
S_{4V}^{\mathrm{modal}}
\restriction_{\{T,F\}}
\cong
S_{\mathrm{Kripke}}.
\]

If `R` is further constrained to an equivalence relation, the classical fragment recovers the Scott S5 control environment.

**Status:** established semantically.

---

# Part II — Paired-neighborhood generalization

## 8. Why two neighborhood families appear naturally

A single ordinary neighborhood family captures the positive universal condition for `□`, but the negative clause has a different shape: it asks whether the negative extension **hits** the accessible region.

This suggests keeping two modal roles explicit rather than immediately calling them positive and negative evidence neighborhoods.

For each world `w`, introduce two families of subsets of `W`:

\[
\mathcal U_w\subseteq\mathcal P(W)
\]

and

\[
\mathcal H_w\subseteq\mathcal P(W).
\]

Read provisionally:

- `U` = universal/core neighborhoods;
- `H` = hit/witness neighborhoods.

These labels describe their **modal role**, not yet an epistemic interpretation.

A `PN-MODAL-v0.1` frame is

\[
\mathcal F_N=(W,\mathcal U,\mathcal H).
\]

---

## 9. Paired-neighborhood clauses

Define:

\[
\boxed{
w\models^+\Box\varphi
\iff
\llbracket\varphi\rrbracket^+\in\mathcal U_w
}
\tag{NBox+}
\]

\[
\boxed{
w\models^-\Box\varphi
\iff
\llbracket\varphi\rrbracket^-\in\mathcal H_w
}
\tag{NBox-}
\]

and

\[
\boxed{
w\models^+\Diamond\varphi
\iff
\llbracket\varphi\rrbracket^+\in\mathcal H_w
}
\tag{NDiamond+}
\]

\[
\boxed{
w\models^-\Diamond\varphi
\iff
\llbracket\varphi\rrbracket^-\in\mathcal U_w.
}
\tag{NDiamond-}
\]

The same two families are therefore used crosswise by necessity and possibility.

### Proposition N1 — Bilateral duality

With these four clauses and Gate-1 negation:

\[
\Diamond\varphi\equiv\neg\Box\neg\varphi
\]

and

\[
\Box\varphi\equiv\neg\Diamond\neg\varphi
\]

hold at both signed satisfaction levels for arbitrary `U` and `H`.

**Status:** established semantically.

This is a useful design fact: duality does not force `U` and `H` to collapse into one family.

---

## 10. Every relational frame induces a paired-neighborhood frame

Given a Kripke frame `(W,R)`, define:

\[
\mathcal U^R_w
:=
\{X\subseteq W\mid R[w]\subseteq X\},
\]

\[
\mathcal H^R_w
:=
\{X\subseteq W\mid R[w]\cap X\neq\varnothing\}.
\]

Thus `U^R_w` contains the sets that cover the entire accessible region, while `H^R_w` contains the sets that hit it.

### Proposition N2 — Relational representation

For every bilateral valuation and every formula `φ`, the `PN-MODAL-v0.1` model induced by `(W,R)` via `U^R,H^R` agrees exactly with `R-MODAL-v0.1` on

\[
\Box\varphi
\quad\text{and}\quad
\Diamond\varphi
\]

at both positive and negative satisfaction levels.

#### Proof

Immediate from the definitions:

\[
\llbracket\varphi\rrbracket^+\in\mathcal U^R_w
\iff
R[w]\subseteq\llbracket\varphi\rrbracket^+,
\]

and

\[
\llbracket\varphi\rrbracket^-\in\mathcal H^R_w
\iff
R[w]\cap\llbracket\varphi\rrbracket^-\neq\varnothing,
\]

with the analogous clauses for `◇`.

**Status:** established semantically.

This proposition is the key bridge for the project: the relational control semantics is a special case of the paired-neighborhood semantics rather than a rival framework.

---

## 11. Complement duality and classical recovery

For arbitrary independent `U` and `H`, even a classically valued subformula may acquire `B` or `N` after modalization. That is a feature available to the general neighborhood semantics, but it would confound the first Gödel–Scott experiment.

Define the **complement-duality condition** `CD` by:

\[
\boxed{
X\in\mathcal U_w
\iff
W\setminus X\notin\mathcal H_w
}
\tag{CD}
\]

for every `w` and `X⊆W`.

Equivalently:

\[
\mathcal H_w
=
\{Y\subseteq W\mid W\setminus Y\notin\mathcal U_w\}.
\]

### Proposition N3 — Classical modal recovery under CD

If all atomic valuations are classical and `CD` holds at every world, then modal formulas remain classical-valued under `PN-MODAL-v0.1`.

#### Reason

For a classical-valued `φ`:

\[
\llbracket\varphi\rrbracket^-
=
W\setminus\llbracket\varphi\rrbracket^+.
\]

Hence `CD` guarantees that exactly one of

\[
\llbracket\varphi\rrbracket^+\in\mathcal U_w
\]

and

\[
\llbracket\varphi\rrbracket^-\in\mathcal H_w
\]

holds, so `□φ` is exactly `T` or `F`. The same argument applies to `◇`.

**Status:** established semantically.

Every relationally induced pair `(U^R,H^R)` satisfies `CD`, because

\[
R[w]\cap Y\neq\varnothing
\iff
R[w]\nsubseteq W\setminus Y.
\]

---

## 12. Principal paired neighborhoods recover Kripke frames

A paired-neighborhood frame is **principal-relational** at `w` when there is a set `S_w⊆W` such that

\[
\mathcal U_w
=
\{X\subseteq W\mid S_w\subseteq X\}
\]

and

\[
\mathcal H_w
=
\{X\subseteq W\mid S_w\cap X\neq\varnothing\}.
\]

Define

\[
wRv
\iff
v\in S_w.
\]

Then the paired-neighborhood model is exactly the relational model induced by `R`.

This gives the hierarchy:

```text
S5 relational control
        ⊂
relational / principal paired neighborhoods
        ⊂
CD paired neighborhoods
        ⊂
arbitrary paired neighborhoods
```

Each step relaxes modal structure while preserving the four-valued propositional kernel.

---

## 13. Why the first collapse experiment stays relational

The project now has two independent sources of non-classical behavior:

1. **four-valued information** (`T,F,B,N` and the signed channels);
2. **non-Kripke neighborhood behavior** (non-principal and potentially non-CD `U/H`).

Varying both at once would make a separation result hard to interpret. If `MC+` failed, we would not know whether the failure came from bilateral positivity or from a non-normal modal environment.

Therefore the frozen methodological decision for Gates 3–4 is:

> **Use `R-MODAL-v0.1` over the Scott S5 control frame while decomposing A1, A4, MC+, and MC-.**

Only after the local rigidity/collapse map is known will the same configurations be re-run in progressively more general paired-neighborhood classes.

This is the central control-variable decision of Gate 2.

---

## 14. Relation to the broader NBVN idea

The paired-neighborhood construction is deliberately compatible with a future NBVN-style interpretation, but `U` and `H` are **not yet identified** with positive and negative evidential neighborhoods.

Why not?

Because in the relational representation their roles are asymmetric:

- `U` represents universal coverage of the accessible region;
- `H` represents nonempty intersection with that region.

Calling these immediately `N+` and `N-` would risk conflating informational polarity with modal quantifier role.

A later gate may introduce genuinely evidential neighborhood structures on top of, or instead of, `U/H`. That extension should be justified by an explicit representation or non-representation result.

---

## 15. Research opportunities created by the neighborhood layer

Once the relational collapse experiment is complete, several controlled variations become available:

### Q2.1 — Drop principality but retain CD

Does bilateral collapse separation survive in non-principal neighborhood frames that still preserve classical modal bivalence?

### Q2.2 — Drop CD

Can modalization itself generate `B` or `N` from classically valued inputs, and does that create new kinds of rigidity/collapse behavior?

### Q2.3 — Separate `U` and `H` structurally

Which closure conditions on `U` or `H` correspond to positive versus negative modal principles?

### Q2.4 — Compare frame classes

After the first S5 experiment, repeat the relational analysis over K, KB, S4, and S5, then compare those results with their paired-neighborhood generalizations.

These questions are deliberately deferred. They should not contaminate the first A1/A4 experiment.

---

## 16. Gate 2 exit criteria

The semantic design portion of Gate 2 is complete when:

- [x] positive and negative clauses for `□` are explicit;
- [x] positive and negative clauses for `◇` are explicit;
- [x] bilateral `□/◇` duality is proved semantically;
- [x] classical modal recovery for the relational fragment is stated and proved semantically;
- [x] `B` and `N` propagation through the modal operators is illustrated by small models;
- [x] a paired-neighborhood generalization is explicit;
- [x] the exact relational-to-neighborhood representation is proved semantically;
- [x] the complement-duality condition needed for classical neighborhood recovery is isolated;
- [x] the modal control semantics for Gates 3–4 is fixed as relational S5;
- [x] modal clauses are machine checked;
- [x] regression models for all four modal values are machine checked.

The final two checks were discharged by Gate 11 in
`FourValued/PairedNeighborhood.lean` and
`formal/finite/gate11_paired_neighborhoods.py`.  The bounded audit also
separates principal relational, non-principal complement-dual, and arbitrary
paired frames.

---

## 17. Literature position

The relational clauses are intentionally conservative. Belnap–Dunn/FDE-based modal systems with Kripke semantics are established in the literature, including Odintsov and Wansing's work on modal logics with Belnapian truth values and Rivieccio, Jung, and Jansana's four-valued Kripke semantics and duality results. Recent work by Petrukhin develops a four-valued S5-based setting for essence and accident modalities and embeds those systems into a four-valued S5 with necessity and possibility.

The paired-neighborhood formulation in this document is used as a project-level structural bridge and experimental parameterization. No novelty claim is made for the general idea of neighborhood semantics for non-classical modal logics.

### References

- S. P. Odintsov and H. Wansing, *Modal Logics with Belnapian Truth Values*, Journal of Applied Non-Classical Logics 20 (2010), 279–301.
- U. Rivieccio, A. Jung, and R. Jansana, *Four-Valued Modal Logic: Kripke Semantics and Duality*, Journal of Logic and Computation 27 (2017), 155–199.
- Y. Petrukhin, *Essence and Accident Modalities Meet Belnapian Truth Values*, Studia Logica (2026), DOI `10.1007/s11225-026-10250-z`.

### Version note

`modal-v0.1` fixes the modal control layer but does not yet lift any Gödel–Scott positivity axiom. Any later change to the signed modal clauses must trigger a re-check of Gate 2 recovery and all downstream Gate 3–4 results.
