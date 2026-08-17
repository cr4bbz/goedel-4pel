# Formalization

The formal layer is intentionally empty at project start.

## Why

The main risk is not implementation difficulty but semantic premature commitment. There are multiple inequivalent choices for:

- four-valued implication/consequence;
- modal positive/negative satisfaction;
- higher-order quantification;
- the meaning of four-valued positivity;
- the lifting of Scott's axioms.

Lean code should begin only after Gates 0–2 have fixed these choices.

## Planned module boundaries

```text
FourValued/Truth
FourValued/Connectives
FourValued/Consequence
FourValued/Modal
GoedelScott/Baseline
GoedelScott/Positivity
GoedelScott/Godlike
GoedelScott/Essence
GoedelScott/NecessaryExistence
Analysis/Collapse
Analysis/Recovery
Models/Counterexamples
```

The project should prefer small definitions and explicit model witnesses over a single large axiomatized theory.
