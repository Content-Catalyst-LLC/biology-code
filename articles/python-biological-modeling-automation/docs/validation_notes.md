# Validation Notes

## Parameter Validation

- Initial population must be non-negative.
- Carrying capacity must be positive.
- Growth rate should be biologically plausible.
- Time step must be positive.
- Number of steps must be a positive integer.
- Compartment amounts should be non-negative.
- Transfer and clearance rates should be non-negative.
- Units should be explicit.

## Modeling Validation

- Euler time steps can be unstable if dt is too large.
- Compartment flows should be checked for mass balance.
- Scenario identifiers should be unique.
- Outputs should record the parameter set used.
- Sensitivity summaries should not be interpreted as formal uncertainty analysis unless designed as such.

## Automation Validation

- Required files should exist before execution.
- Output directories should be created by the workflow.
- Scripts should fail clearly when inputs are invalid.
- Provenance should record inputs, scripts, outputs, and checksums.
- Reports should include assumptions and limitations.

## Limitations

The examples do not implement formal Bayesian calibration, nonlinear mixed-effects modeling, optimal control, agent-based modeling, mechanistic validation against empirical datasets, containerization, or production workflow orchestration.
