# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real-world biodiversity assessments.

## Provenance

The SQL schema includes fields for:

- site records
- species records
- observation records
- trait records
- biodiversity metrics
- scenario definitions
- sampling method
- license
- processing step
- uncertainty notes

This supports transparent biodiversity workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The included examples are deterministic unless noted. Future simulations should set random seeds where practical.

## Limitations

The examples do not include:

- rarefaction or sample coverage correction
- spatial autocorrelation correction
- phylogenetic tree parsing
- DNA/eDNA sequence processing
- taxonomic name resolution
- Bayesian uncertainty models
- occupancy-detection modeling
- remote-sensing biodiversity proxies
- large-scale biodiversity informatics pipelines

Those extensions can be added as the repository grows.
