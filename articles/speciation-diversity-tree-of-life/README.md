# Speciation, Diversity, and the Tree of Life

This article repository supports the Biology knowledge-series article:

**Speciation, Diversity, and the Tree of Life**

The code distribution expands the article's compact R and Python examples into a fuller computational speciation and phylogenetics workflow. It includes divergence-with-gene-flow simulation, FST-style population-structure screening, pairwise sequence distances, Jukes-Cantor correction, distance-matrix construction, UPGMA-style clustering inputs, birth-death diversification, lineage-through-time screening, SQL provenance structures, reproducible data files, and multi-language scientific-computing scaffolding.

## Repository Structure

- `python/` — divergence simulation, sequence distances, distance matrices, birth-death screening, and speciation diagnostics
- `r/` — multi-locus divergence, FST-style summaries, sequence distance matrices, and lineage-through-time screening
- `julia/` — divergence, distance, and diversification modeling
- `fortran/` — compact divergence and birth-death numerical kernels
- `rust/` — safe command-line speciation condition scoring utility
- `go/` — portable speciation and tree-thinking scoring helper
- `c/` — sequence-distance and diversification computational kernel
- `cpp/` — comparative speciation scenario simulation
- `sql/` — populations, loci, sequences, clades, outputs, and provenance schema
- `docs/` — setup, methodology, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent speciation and phylogenetic reasoning:

1. Simulate divergence between two populations under limited gene flow.
2. Calculate allele-frequency divergence and FST-style structure.
3. Build pairwise sequence-distance tables.
4. Calculate Jukes-Cantor corrected distances.
5. Construct distance matrices suitable for exploratory tree workflows.
6. Simulate birth-death diversification and lineage richness.
7. Track data provenance and reproducibility.

These examples are educational scaffolds, not operational phylogenetic, conservation, systematic, or genomic models. Real applications require empirical genomic data, taxon sampling, alignment quality control, explicit model selection, uncertainty analysis, and expert interpretation.
