# Bilateral Collapse Experiment

## Status

**Gate:** 4 — Collapse experiment and minimality analysis  
**Version:** `collapse-v0.1`  
**Control semantics:** `kernel-v0.1` + `R-MODAL-v0.1` + `positivity-v0.1` on Scott S5 frames  
**Role:** determine which bilateral distinctions are genuine, which collapse under FDE negation, and which upstream assumptions reconstruct the classical modal-collapse spine

This gate does not introduce the full higher-order Gödel–Scott theory. It works at the semantic interfaces already isolated in Gates 0–3. In particular, quantification, the final definition of Godlikeness, and the four-valued versions of essence and necessary existence remain deferred.

The main result is negative in a productive sense: the corrected positive and negative modal-collapse schemata are **not independent** under the current FDE negation. The decomposition therefore lives upstream, in the positivity and reflection mechanisms that generate collapse.

---

# Part I — The collapse channels do not separate

## 1. Correct bilateral collapse schemata

Gate 3 fixed the informative pair

\[
MC^+:\qquad +\chi\Rightarrow+\Box\chi
\]

and

\[
MC^-:\qquad -\chi\Rightarrow+\Box\neg\chi.
\]

The earlier candidate

\[
-\chi\Rightarrow-\Box\chi
\]

is not used because it is automatic on reflexive frames.

---

## 2. Collapse-equivalence theorem

### Theorem — `MC+` and `MC-` are equivalent

Under the Gate-1 FDE negation, treated schematically over all formulas,

\[
\boxed{MC^+\iff MC^-}.
\]

### Proof: `MC+` implies `MC-`

Assume `MC+` and suppose

\[
-\chi.
\]

By FDE negation,

\[
+\neg\chi.
\]

Apply `MC+` to the formula `¬χ`:

\[
+\neg\chi\Rightarrow+\Box\neg\chi.
\]

Hence `MC-`.

### Proof: `MC-` implies `MC+`

Assume `MC-` and suppose

\[
+\chi.
\]

FDE negation gives

\[
-\neg\chi.
\]

Apply `MC-` to `¬χ`:

\[
-\neg\chi\Rightarrow+\Box\neg\neg\chi.
\]

Since FDE negation is involutive,

\[
\neg\neg\chi\equiv\chi,
\]

so

\[
+\Box\chi.
\]

Thus `MC+`.

### Consequence

The original project conjecture that informative positive and negative modal collapse might be independent is **falsified for the present symmetric FDE setting**.

This does not trivialize the project. It identifies the wrong level at which to seek decomposition:

```text
collapse itself:        coupled by involutive negation
positivity rigidity:    independent without A1, coupled by strong A1
reflection G+Z -> P(Z): sensitive to glut/gap structure
```

A future semantics with a non-involutive negation, asymmetric modal operators, or restricted collapse schemata could reopen the separation question, but those are different theories and are not introduced to rescue the conjecture.

---

# Part II — Rigidity does separate before A1 couples it

## 3. Rigidity schemata

The informative rigidity principles are

\[
R^+:\qquad
+P(\varphi)\Rightarrow+\Box P(\varphi)
\]

and

\[
R^-_{\mathrm{nec}}:\qquad
-P(\varphi)\Rightarrow+\Box\neg P(\varphi).
\]

For brevity this document writes the second principle as `R-` when no confusion with the retired weak candidate is possible.

---

## 4. Independence without A1

Let the S5 control frame have two worlds

\[
W=\{w_0,w_1\}
\]

with universal accessibility.

### Countermodel: `R+` does not entail `R-`

Choose a property `ψ` with

\[
v_{w_0}(P(\psi))=N,
\qquad
v_{w_1}(P(\psi))=F,
\]

and assign `N` to all other positivity statements relevant to the toy model.

Then `R+` holds vacuously because no positivity statement has positive support. But at `w_1`,

\[
-P(\psi)
\]

while `w_0` is accessible and does not negatively support `P(ψ)`. Therefore

\[
+\Box\neg P(\psi)
\]

fails at `w_1`, so `R-` fails.

Hence

\[
\boxed{R^+\not\models R^-_{\mathrm{nec}}}
\]

without A1 constraints.

### Countermodel: `R-` does not entail `R+`

Choose instead

\[
v_{w_0}(P(\psi))=N,
\qquad
v_{w_1}(P(\psi))=T,
\]

with all other relevant positivity statements `N`.

`R-` holds vacuously because no positivity statement has negative support. But `+P(ψ)` holds at `w_1` while the accessible world `w_0` lacks positive support. Therefore

\[
+\Box P(\psi)
\]

fails at `w_1`.

Thus

\[
\boxed{R^-_{\mathrm{nec}}\not\models R^+}
\]

without A1 constraints.

So the two rigidity channels are genuinely independent before positivity-negation structure is imposed.

---

## 5. Strong A1 couples the rigidity channels completely

Gate 3 already established

\[
A1_L+A1_R+R^+\models R^-_{\mathrm{nec}}.
\]

The converse also holds.

### Proposition — strong A1 plus negative rigidity yields positive rigidity

Assume globally

\[
A1_L,
\qquad
A1_R,
\qquad
R^-_{\mathrm{nec}}.
\]

Suppose at `w`

\[
+P(\varphi).
\]

By `A1_R` with the substitution `φ := ¬φ`,

\[
-P(\neg\varphi).
\]

Apply `R-` to the property `¬φ`:

\[
+\Box\neg P(\neg\varphi).
\]

Hence every accessible world `v` satisfies

\[
-P(\neg\varphi).
\]

By `A1_L`, again using the schema on `¬φ`, every such `v` satisfies

\[
+P(\varphi).
\]

Therefore

\[
+\Box P(\varphi).
\]

and hence `R+`.

Consequently:

\[
\boxed{
A1_L+A1_R\models
\bigl(R^+\leftrightarrow R^-_{\mathrm{nec}}\bigr).
}
\]

This sharpens the Gate-3 channel-coupling result: **strong A1 destroys the independence of positive and negative positivity rigidity in both directions.**

Neither A1 direction alone suffices for this coupling. Two-world assignments can satisfy `A1-L + R+` while failing `R-`, or `A1-R + R+` while failing `R-`, and analogously in the converse direction.

---

# Part III — Minimal reconstruction of the classical reflection bridge

## 6. Target bridge

The classical modal-collapse proof uses

\[
G(x),Z(x)\Rightarrow P(Z).
\]

The signed target is

\[
REF^+:\qquad
+G(x)\land+Z(x)\Rightarrow+P(Z).
\]

Gate 3 showed that strong A1 plus the minimal Godlikeness support interface does not imply this bridge in FDE.

---

## 7. Four assumptions sufficient for `REF+`

Use the following local interfaces.

### A1-L

\[
-P(Z)\Rightarrow+P(\neg Z).
\]

### D1+

\[
+G(x)\land+P(\varphi)\Rightarrow+\varphi(x).
\]

### `CONS_G` — consistency of relevant God-like exemplification

For the relevant witness and property,

\[
+G(x)\land+Z(x)
\Rightarrow
\text{not }-Z(x),
\]

where `not` is metalanguage denial, not an object-language connective.

### `COMP_P` — completeness of relevant positivity information

For the relevant property,

\[
+P(Z)\quad\text{or}\quad-P(Z).
\]

### Proposition — local reflection recovery

\[
\boxed{
A1_L+D1^++CONS_G+COMP_P\models REF^+.
}
\]

### Proof

Assume

\[
+G(x),
\qquad
+Z(x).
\]

By `COMP_P`, either `+P(Z)` or `-P(Z)`.

If `-P(Z)`, then `A1-L` yields

\[
+P(\neg Z).
\]

Together with `+G(x)`, `D1+` gives

\[
+\neg Z(x),
\]

which by FDE negation is

\[
-Z(x).
\]

This contradicts `CONS_G`. Therefore the `-P(Z)` alternative is excluded, leaving

\[
+P(Z).
\]

Hence `REF+`.

---

## 8. Local minimality of the reflection package

Each of the four assumptions above is individually indispensable relative to the other three at this abstract interface.

### Remove `A1-L`

Take

\[
+G(x),\quad v(Z(x))=T,
\]

\[
v(P(Z))=F,
\qquad
v(P(\neg Z))=N.
\]

`D1+`, `CONS_G`, and `COMP_P` can all hold, while `+P(Z)` fails.

### Remove `D1+`

Take

\[
+G(x),\quad v(Z(x))=T,
\]

\[
v(P(Z))=F,
\qquad
v(P(\neg Z))=T.
\]

`A1-L`, `CONS_G`, and `COMP_P` hold, but without `D1+` positivity of `¬Z` need not propagate to the witness. `REF+` fails.

### Remove `CONS_G`

Use the Gate-3 glut assignment

\[
v(Z(x))=B,
\qquad
v(P(Z))=F,
\qquad
v(P(\neg Z))=T.
\]

Then `A1-L`, `D1+`, and `COMP_P` hold, but `REF+` fails.

### Remove `COMP_P`

Use the Gate-3 gap assignment

\[
v(Z(x))=T,
\qquad
v(P(Z))=N,
\qquad
v(P(\neg Z))=N.
\]

Then `A1-L`, `D1+`, and `CONS_G` hold, but `REF+` fails.

Thus the local proof interface has the minimality pattern

```text
A1-L       required to turn non-positivity into complement positivity
D1+        required to push complement positivity onto the witness
CONS_G     required to block the glut escape
COMP_P     required to block the gap escape
```

This is one of the main structural results of Gate 4.

---

# Part IV — Conditional collapse kernel

## 9. Two higher-order interfaces kept abstract

The full four-valued quantifier and Godlikeness definitions are not yet fixed, so Gate 4 uses two explicit control interfaces rather than smuggling them in.

### `GW` — global God-like witness supply

At every world `w` there is some entity `x` such that

\[
+G(x)@w.
\]

On the eventual Scott reconstruction this is intended to be supplied by the appropriate positive reading of the necessary-existence theorem, but that derivation belongs to later gates.

### `CONST` — constant-property embedding

For every modal formula `χ`, there is an intensional property

\[
Z_\chi:=\lambda x.\chi
\]

such that at every world and for every entity

\[
+Z_\chi(x)\iff+\chi,
\]

and

\[
-Z_\chi(x)\iff-\chi.
\]

This is the higher-order bridge used by the classical modal-collapse proof when an arbitrary proposition is turned into a property.

---

## 10. Conditional positive-collapse theorem

Assume globally:

1. `A1-L`;
2. `D1+`;
3. `CONS_G`;
4. `COMP_P`;
5. `R+`;
6. `GW`;
7. `CONST`.

Then

\[
\boxed{MC^+}.
\]

### Proof sketch

Let `w` satisfy

\[
+\chi.
\]

By `GW`, choose `x` with `+G(x)` at `w`. By `CONST`,

\[
+Z_\chi(x).
\]

The local reflection theorem yields

\[
+P(Z_\chi).
\]

By `R+`,

\[
+\Box P(Z_\chi).
\]

Take any accessible world `v`. Then

\[
+P(Z_\chi)@v.
\]

By `GW`, choose a God-like witness `y` at `v`. By `D1+`,

\[
+Z_\chi(y)@v.
\]

By `CONST`,

\[
+\chi@v.
\]

Since `v` was arbitrary,

\[
+\Box\chi@w.
\]

Thus `MC+`.

By the collapse-equivalence theorem, the same package also yields `MC-` automatically.

Therefore the Gate-4 collapse package is

\[
\boxed{
A1_L+D1^++CONS_G+COMP_P+R^++GW+CONST
\models
MC^+\iff MC^-.
}
\]

This is an **interface-level theorem**, not yet a theorem of the complete four-valued Gödel–Scott system. `GW` and `CONST` are deliberately explicit placeholders for higher-order structure that must be justified in later gates.

---

## 11. Where the classical proof hides its assumptions

The collapse spine can now be refined as

```text
+χ
 │
 │ CONST + GW
 ▼
+G(x), +Zχ(x)
 │
 │ A1-L + D1+ + CONS_G + COMP_P
 ▼
+P(Zχ)
 │
 │ R+
 ▼
+□P(Zχ)
 │
 │ GW + D1+ + CONST at accessible worlds
 ▼
+□χ
```

The classical proof compresses at least three distinct kinds of structure:

1. **positivity-negation transfer** (`A1-L`);
2. **classical informational regularity** (`CONS_G`, `COMP_P`);
3. **higher-order witness/property infrastructure** (`GW`, `CONST`).

A4 / `R+` is the modal propagation step, but it is not sufficient to create collapse unless those upstream interfaces are available.

---

# Part V — Revised experimental map

## 12. What is resolved

| Question | Gate-4 result |
|---|---|
| Can informative `MC+` and `MC-` separate under the current FDE negation? | **No. They are equivalent schemata.** |
| Are `R+` and informative `R-` independent without A1? | **Yes. Two-world S5 countermodels separate them.** |
| Does strong A1 preserve that rigidity independence? | **No. Strong A1 makes them interderivable.** |
| Does strong A1 + `D1+` recover `REF+`? | **No. Glut and gap assignments block it.** |
| What locally recovers `REF+`? | `A1-L + D1+ + CONS_G + COMP_P`. |
| Is that four-assumption local package minimal at the abstract interface? | **Yes, each component has a counterassignment when removed.** |
| What additional interfaces propagate `REF+` to collapse? | `R+ + GW + CONST`. |

---

## 13. What remains open

Gate 4 deliberately does **not** claim:

- that `CONS_G` or `COMP_P` should become global axioms of the final theory;
- that `D1+` is the final four-valued definition of Godlikeness;
- that `GW` follows from a four-valued T3;
- that the final higher-order quantifier semantics validates `CONST` without qualification;
- that the interface-level minimality result is already a minimality theorem for the full Gödel–Scott theory.

Those questions move into the reconstruction gates.

---

## 14. Consequence for the paper thesis

The strongest current thesis is no longer

> modal collapse splits into two independent bilateral collapse principles.

Instead:

> **Under symmetric FDE negation, informative positive and negative modal collapse are necessarily coupled. The non-classical decomposition occurs upstream: positivity rigidity separates in the absence of A1, strong A1 recouples its channels, and the classical reflection step additionally depends on consistency and completeness conditions that gluts and gaps independently defeat.**

This is a sharper and falsifiable structural claim.

---

## 15. Gate-4 exit criteria

- [x] use informative `MC+` and `MC-` rather than reflexively trivial clauses;
- [x] prove `MC+ <-> MC-` under the current FDE negation;
- [x] provide finite S5 countermodels separating `R+` and `R-` without A1;
- [x] prove strong A1 makes `R+` and `R-` interderivable;
- [x] identify a sufficient local package for `REF+`;
- [x] give counterassignments showing local minimality of that package;
- [x] state the higher-order interfaces required to lift `REF+` to modal collapse;
- [x] derive the conditional interface-level collapse theorem;
- [ ] machine-check the finite countermodels and dependency results;
- [ ] replace `GW`, `CONST`, and `D1+` with justified components of the full four-valued Gödel–Scott reconstruction.

The remaining unchecked items belong to later mechanization and reconstruction gates and do not block Gate 5 semantic work.
