# Gate 8 — Modal-frame minimization

## Status

**Gate:** 8 — Comparative variants  
**Version:** `frames-v0.1`  
**Scope:** positive T3 frame dependencies for the Scott-support and bilateral Anderson branches  
**Verification:** general Lean 4.30.0 theorems + executable finite countermodels

This document records the first explicit weakening of the original S5 control-frame assumption.

The result is deliberately local to the T3 stage. It does **not** say that the entire Scott or Anderson theory can be reconstructed over arbitrary symmetric frames from the primitive axioms. In the Scott branch, positive T2 is already assumed by the reduced T3 theorem.

---

## 1. Original control route

Gate 6 reconstructed positive necessary Godlike existence on S5 by deriving a possible necessary-existence statement and using the familiar S5 pattern

```text
Diamond Box theta -> Box theta.
```

That proof is correct but not frame-minimal.

Gate 8 instead reuses the internal necessary-existence structure of the Godlike witness and transports a witness back along a symmetric accessibility edge.

---

## 2. Scott-support branch

The general Lean theorem is:

```text
Symmetric(R)
+ PossibleGod
+ T2+
+ A5+
+ NE-sup
+ G-sup
----------------
T3+
```

No reflexivity or transitivity premise is used.

### Proof spine

Fix `w` and a successor `z` of `w`.

1. `PossibleGod` supplies an accessible world `v` and an actual positive Godlike witness `x` at `v`.
2. `A5+` and Godlikeness give positive `NE(x)` at `v`.
3. `T2+` makes `G` a positive essence of `x` at `v`.
4. `NE-sup` therefore supplies an actual positive `G`-instance at every successor of `v`.
5. Symmetry turns `wRv` into `vRw`, so step 4 supplies an actual Godlike witness at `w`.
6. Running the same local `T2 + A5 + NE` package at `w` supplies an actual Godlike witness at the arbitrary successor `z`.

Thus every successor of every world has an actual positive Godlike witness.

The theorem is machine-checked in:

```text
formal/lean/Goedel4PEL/GoedelScott/ScottFrames.lean
```

### S4 countermodel

The finite oracle contains a two-world frame

```text
w0 -> w0
w0 -> w1
w1 -> w1
```

which is reflexive and transitive but not symmetric.

The model satisfies:

- FDE complement exemplification;
- strong A1;
- `A2+`;
- `R+`;
- bilateral `G-sup` realization;
- `T2+`;
- `A5+`;
- `NE-sup` realization;
- possible actual Godlikeness at every world.

Nevertheless `T3+` fails because `w0` sees itself while `w0` has no actual positive Godlike witness.

Hence reflexivity plus transitivity do not replace symmetry for the current Scott T3 route.

The fixture is implemented in:

```text
formal/finite/gate8_scott_frames.py
```

---

## 3. Anderson branch

For the bilateral Anderson candidate, Lean proves the stronger-looking but structurally analogous theorem:

```text
Symmetric(R)
+ Possible +G_A
+ AndersonGRealization
+ AndersonGPositive
+ A2+
+ AndersonNERealization
+ AndersonNEPositive
--------------------------------
AndersonT3+
```

No reflexivity, transitivity, or separate `R+` premise occurs.

Anderson's necessary-exemplification definition already packages persistence into positive Godlikeness. Symmetry transports the necessary Godlikeness of a possible witness back to the original world, where the Anderson essence/necessary-existence interfaces can be reconstructed locally.

The theorem is machine-checked in:

```text
formal/lean/Goedel4PEL/GoedelScott/AndersonFrames.lean
```

The finite oracle contains a matching S4-style non-symmetric countermodel satisfying the encoded Anderson stack and possible Godlikeness while refuting `AndersonT3+`.

---

## 4. Comparative result

At the T3 stage the two routes therefore share the same currently verified modal bridge:

```text
Scott-support, after T2+     Anderson candidate
          |                        |
          +------ symmetry --------+
                     |
                     v
               necessary actual
               Godlike existence
```

The important difference between the variants is consequently **upstream of T3**.

- Scott-support must first derive `T2+`; this is the glut/gap bottleneck isolated in Gates 6–7.
- `G-exact+` moves local positive reflection into Godlikeness itself.
- Anderson moves the comparison to necessary exemplification and simultaneously changes essence.

Thus the modal-frame analysis reinforces rather than replaces the Gate-6 conclusion: the main structural variation lies in how Godlikeness and essence generate the necessary-existence interface.

---

## 5. What is and is not established

Established generally in Lean:

```text
Symmetry + Scott T3 premises -> T3+
Symmetry + Anderson T3 premises -> AndersonT3+
```

Established by explicit finite countermodels:

```text
Reflexive + Transitive + non-Symmetric
```

can satisfy the remaining encoded premises while T3 fails, for both branches.

Not established:

- that symmetry is the unique or globally weakest relational condition;
- that no non-symmetric frame class with additional structural constraints can validate either theorem;
- that the full primitive Scott theory needs only symmetry, since the reduced Scott theorem assumes `T2+` already.

These distinctions must be preserved in publication claims.
