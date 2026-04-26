# Mutation, Variation, and the Sources of Novelty

This article repository supports the Biology knowledge-series article:

**Mutation, Variation, and the Sources of Novelty**

The code distribution expands the article's compact R and Python examples into a fuller computational mutation-and-variation workflow. It includes mutation supply, Poisson mutation expectations, mutation spectra, sequence-distance matrices, Jukes-Cantor correction, genotype matrices, nucleotide diversity, site-frequency summaries, mutation-selection-drift simulations, structural-variation summaries, novelty condition scoring, SQL provenance structures, reproducible data files, and multi-language scientific-computing scaffolding.

## Repository Structure

- `python/` — mutation supply, sequence distance, nucleotide diversity, mutation-selection-drift, structural variation, and novelty condition scoring
- `r/` — mutation spectra, diversity and differentiation, Wright-Fisher mutation-selection-drift, and variation summaries
- `julia/` — mutation supply, sequence distance, diversity, and mutation-selection calculations
- `fortran/` — compact mutation and diversity numerical kernels
- `rust/` — safe command-line novelty condition scoring utility
- `go/` — portable novelty condition scoring helper
- `c/` — mutation supply, sequence distance, and mutation-selection computational kernel
- `cpp/` — comparative mutation and novelty scenario simulation
- `sql/` — mutation spectra, sequence records, genotype summaries, structural variation, outputs, and provenance schema
- `docs/` — setup, methodology, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent mutation and variation reasoning:

1. Estimate expected mutation counts and Poisson probabilities.
2. Summarize mutation spectra.
3. Calculate pairwise sequence distance and Jukes-Cantor correction.
4. Estimate nucleotide diversity and site-frequency summaries.
5. Simulate mutation-selection-drift dynamics.
6. Screen structural variation for functional-priority signals.
7. Score novelty condition examples.
8. Track data provenance and reproducibility.

These examples are educational scaffolds, not operational clinical, conservation-genomic, population-genomic, cancer-genomic, or variant-interpretation models. Real applications require empirical data, quality control, annotation pipelines, statistical inference, uncertainty analysis, and expert interpretation.
