# Validation Notes

## Simulation

- Growth rate should be biologically interpretable.
- Carrying capacity must be positive.
- Initial population should be non-negative.
- Time step should be small enough for stable approximation.
- Stochastic simulations should record random seeds.
- Simulation outputs should not be interpreted as forecasts without validation.

## Sequence Analysis

- FASTA identifiers should be unique.
- Sequence characters should be checked for ambiguous bases.
- Metadata sample identifiers should match sequence identifiers.
- GC content should be calculated only from valid A/C/G/T bases.
- k-mer counts should exclude ambiguous k-mers unless explicitly allowed.

## Workflow

- Required metadata columns must be present.
- Input files should be recorded in a manifest.
- Outputs should be regenerated from scripts.
- Checksums should be recorded for important artifacts.
- External bioinformatics tools require version and parameter records.

## Limitations

The examples do not implement production alignment, variant calling, genome assembly, RNA-seq differential expression, phylogenetics, single-cell analysis, workflow-manager deployment, containerization, or regulatory-grade data governance.
