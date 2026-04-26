# Validation Notes

The repository includes simple validation checks appropriate for an educational scientific-computing scaffold.

## Input Validation

- Time values must be non-negative.
- Viable counts must be positive for log-linear decay fitting.
- Loss, mortality, reactivation, infection, production, and clearance rates must be non-negative.
- Dormant, active, target-cell, infected-cell, and virus counts must be non-negative.
- Life-criteria scores are expected to be scaled between 0 and 1.
- Life-criteria weights should sum to approximately 1.

## Numerical Checks

- Viability-decay fitting is performed in log space.
- Half-life is calculated as log(2) / k when k is positive.
- Dormancy simulations prevent negative abundance.
- Host-virus simulations prevent negative target-cell, infected-cell, or virus abundance.
- Borderline-case scoring reports explicit criteria and weights.
- SQL provenance records identify synthetic data and uncertainty.

## Limitations

The validation checks are not substitutes for empirical quality control. Research, clinical, astrobiology, ecological, toxicological, virological, biosafety, or regulatory applications require stronger validation, calibration, uncertainty propagation, domain review, and ethical or regulatory oversight.
