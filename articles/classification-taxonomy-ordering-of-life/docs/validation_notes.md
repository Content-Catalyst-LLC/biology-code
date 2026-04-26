# Validation Notes

## Input Validation

- Aligned sequences must have equal length.
- Sequence distance is calculated only across comparable aligned positions.
- Jukes-Cantor distance is undefined when p-distance is >= 0.75.
- Abundance counts must be non-negative.
- Diversity calculations require positive total abundance.
- Assignment confidence inputs should be scaled between 0 and 1.
- Occurrence records should include taxon name, locality, basis of record, and uncertainty notes where available.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Code is deterministic.
- Notebook scaffolds reproduce the core calculations.

## Limitations

These examples do not perform authoritative taxonomic revision, formal nomenclatural publication, species delimitation, barcode gap analysis, phylogenomic inference, or regulatory conservation assessment.
