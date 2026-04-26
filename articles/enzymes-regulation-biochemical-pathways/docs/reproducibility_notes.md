# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real enzyme assays, clinical chemistry, high-throughput screening, metabolic engineering, soil enzyme measurements, or pathway-flux experiments.

## Provenance

The SQL schema includes fields for:

- enzyme assay observations
- enzyme variants
- inhibitor conditions
- pathway steps
- enzyme condition sites
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent enzyme-biology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The synthetic assay fitting example uses a fixed random seed where stochastic noise is generated. Future stochastic extensions should record seeds, sample sizes, parameter distributions, and assumptions.

## Limitations

The examples do not include:

- replicate assay uncertainty
- temperature or pH correction
- enzyme stability modeling
- substrate depletion dynamics
- product inhibition with full ODE integration
- allosteric multi-state models
- metabolic control coefficients
- flux balance analysis
- enzyme structure modeling
- real HTS assay normalization
- clinical interpretation

Those extensions can be added as the repository grows.
