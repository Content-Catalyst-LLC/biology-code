# Validation Notes

## Biostatistics

- Confirm biological and technical replicate structure.
- Do not treat repeated measures as independent samples.
- Inspect batch structure before modeling.
- Use model diagnostics and effect-size interpretation.
- For binary data, inspect separation and sample size.
- For survival data, document censoring definitions.

## Ecology

- Counts must be non-negative.
- Absence may mean non-detection.
- Sampling effort should be recorded.
- Dissimilarity measures depend on transformation.
- Ordination is exploratory unless paired with appropriate testing and design.

## Genomics

- Count matrices must align with sample metadata.
- Library size affects raw counts.
- Low-count genes can be noisy.
- Differential-expression claims require validated workflows.
- Multiple-testing correction is essential for high-throughput inference.
- Batch effects and design formulas should be explicit.

## Reproducibility

- Data files are stored in `data/`.
- Scripts are stored in language-specific folders.
- Outputs are written to `outputs/`.
- SQL schema records measurement, ecology, genomics, metadata, and provenance tables.
- Notebook scaffold reproduces core calculations.
