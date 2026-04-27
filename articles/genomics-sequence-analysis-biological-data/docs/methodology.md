# Methodology Notes

## Purpose

This repository demonstrates a reproducible workflow for genomics, sequence analysis, and biological data.

## Sequence Summary

For each DNA sequence, the workflow calculates:

- sequence length
- valid A/C/G/T base count
- ambiguous-base count
- GC content
- k-mer counts

## Open Reading Frames

The ORF scaffold searches the forward strand for simple ATG-to-stop ORFs. It is a teaching scaffold and does not replace production gene prediction.

## Translation

The translation scaffold uses a compact standard codon table for DNA coding sequences. It does not account for organism-specific genetic-code differences, splicing, RNA editing, frameshifts, or annotation evidence.

## FASTQ Quality

The FASTQ-style example converts ASCII quality characters to Phred scores using:

Q = ord(character) - 33

This is a teaching scaffold.

## Variant Validation

The variant workflow checks:

- valid reference and alternate bases
- positive genomic position
- read-depth threshold
- alternate-depth consistency
- variant allele frequency

## Reproducibility

The repository records:

- input data files
- scripts
- output artifacts
- checksums
- workflow steps
- SQL provenance
- validation reports
