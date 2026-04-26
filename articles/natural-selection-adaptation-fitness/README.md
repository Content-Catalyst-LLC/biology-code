# Natural Selection, Adaptation, and Fitness

This article repository supports the Biology knowledge-series article:

**Natural Selection, Adaptation, and Fitness**

The code distribution expands the article's compact R and Python examples into a fuller computational selection workflow. It includes Hardy-Weinberg baselines, genotype-specific selection, mean fitness, relative fitness scaling, selection coefficients, directional selection, balancing selection, purifying selection, quantitative-trait selection, breeder's equation screening, spatiotemporally variable selection, selection-drift replicate simulations, time-series allele-frequency screening, SQL provenance structures, reproducible data files, and multi-language scientific-computing scaffolding.

## Repository Structure

- `python/` — genotype selection, selection-drift simulations, quantitative trait response, time-series frequency screening, and selection condition scoring
- `r/` — genotype-based selection, quantitative trait selection, variable-environment selection, and selection summaries
- `julia/` — selection updates, mean fitness, and quantitative response modeling
- `fortran/` — compact genotype-selection and trait-response numerical kernels
- `rust/` — safe command-line selection condition scoring utility
- `go/` — portable selection scenario scoring helper
- `c/` — genotype fitness and allele-frequency computational kernel
- `cpp/` — comparative selection scenario simulation
- `sql/` — selection scenarios, trait observations, time-series data, outputs, and provenance schema
- `docs/` — setup, methodology, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent selection and adaptation reasoning:

1. Calculate genotype fitness, mean fitness, and allele-frequency updates.
2. Compare directional selection, heterozygote advantage, heterozygote disadvantage, and purifying selection.
3. Simulate selection and drift across replicate populations.
4. Estimate selection differentials and breeder's equation response for quantitative traits.
5. Model variable selection across alternating environments.
6. Track allele-frequency time series for selection-like change.
7. Track data provenance and reproducibility.

These examples are educational scaffolds, not operational conservation, biomedical, genomic, or selection-inference models. Real applications require empirical fitness measurement, sampling design, variant quality control, uncertainty analysis, and expert interpretation.
