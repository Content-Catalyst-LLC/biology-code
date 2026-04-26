# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real reproductive or demographic assessments.

## Provenance

The SQL schema includes fields for:

- life stages
- transition rates
- reproductive scenarios
- life-history trait values
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent reproductive-biology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The included core examples are deterministic. Future simulation extensions should set random seeds where stochasticity is introduced.

## Limitations

The examples do not include:

- Bayesian uncertainty models
- individual-based developmental simulation
- genomic inheritance simulation
- gamete-level recombination modeling
- embryological image analysis
- developmental toxicity modeling
- endocrine-disruption pathways
- spatially explicit recruitment
- field sampling correction
- real demographic calibration

Those extensions can be added as the repository grows.
