# Validation Notes

## Sequence Validation

- FASTA identifiers should be unique.
- Sequence strings should be checked for ambiguous characters.
- GC content should be calculated from valid A/C/G/T bases.
- k-mer counts should exclude ambiguous k-mers unless explicitly allowed.
- ORF detection should be interpreted as a simple scaffold, not gene prediction.

## Metadata Validation

- Sequence identifiers should match metadata identifiers.
- Sample identifiers should be unique.
- Organism, condition, batch, and source fields should be documented.
- QC flags should use controlled values.

## Variant Validation

- Reference and alternate alleles should be valid bases in this scaffold.
- Read depth should meet a predefined threshold.
- Alternate depth should not exceed total read depth.
- Variant allele frequency should be interpreted with context.
- Real variant interpretation requires reference version, coordinate system, caller settings, and biological validation.

## Limitations

The examples do not implement alignment, assembly, variant calling, transcript annotation, splicing, multiple-sequence alignment, phylogenetics, structural variation, read trimming, contamination screening, or clinical interpretation.
