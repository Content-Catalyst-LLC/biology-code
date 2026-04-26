# Population Genetics and the Mathematics of Inheritance

This article repository supports the Biology knowledge-series article:

**Population Genetics and the Mathematics of Inheritance**

The code distribution expands the article's compact R and Python examples into a fuller computational population-genetics workflow. It includes Hardy-Weinberg expectations, genotype-frequency calculation, expected heterozygosity, genotype-specific selection, bidirectional mutation, migration, Wright-Fisher drift, fixation and loss statistics, multi-population FST-style structure, bottleneck screening, genotype-matrix processing, migration-selection balance, SQL provenance structures, reproducible data files, and multi-language scientific-computing scaffolding.

## Repository Structure

- `python/` — Wright-Fisher replicates, genotype-matrix processing, Hardy-Weinberg screening, migration-selection balance, and population-structure scoring
- `r/` — allele-frequency dynamics, multi-population FST-style structure, bottleneck screening, and population-genetic summaries
- `julia/` — allele-frequency, selection, drift, and structure modeling
- `fortran/` — compact Hardy-Weinberg, selection, and drift numerical kernels
- `rust/` — safe command-line population-genetic condition scoring utility
- `go/` — portable population-genetic scenario scoring helper
- `c/` — genotype-frequency and selection computational kernel
- `cpp/` — comparative population-genetic scenario simulation
- `sql/` — population scenarios, genotype observations, structure datasets, outputs, and provenance schema
- `docs/` — setup, methodology, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent population-genetic reasoning:

1. Calculate Hardy-Weinberg expected genotype frequencies.
2. Simulate selection, mutation, migration, and drift.
3. Estimate expected heterozygosity through time.
4. Run Wright-Fisher replicate simulations with fixation and loss statistics.
5. Process genotype matrices into allele frequencies and genotype expectations.
6. Estimate FST-style population structure across multiple populations.
7. Track data provenance and reproducibility.

These examples are educational scaffolds, not operational conservation, biomedical, genomic, or population-inference models. Real applications require empirical sampling design, variant quality control, missing-data handling, uncertainty analysis, and expert interpretation.
