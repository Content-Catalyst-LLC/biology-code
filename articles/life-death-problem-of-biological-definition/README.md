# Life, Death, and the Problem of Biological Definition

This article repository supports the Biology knowledge-series article:

**Life, Death, and the Problem of Biological Definition**

The code distribution expands the article's compact R and Python examples into a rigorous, reproducible computational workflow for biological definition, viability, mortality, dormancy, host-virus dynamics, and borderline-case analysis. It includes viability-decay fitting, mortality half-life estimation, survival curves, dormancy-loss and reactivation models, host-virus dynamics, heuristic life-criteria matrices, borderline-case scoring, SQL provenance structures, reproducible data files, validation notes, and multi-language scientific-computing scaffolding.

No university affiliation is implied by the repository. The design goal is advanced reproducible computational rigor: clear assumptions, modular code, transparent data structures, provenance, validation checks, and reproducible workflows.

## Repository Structure

- `python/` — viability decay, dormancy, host-virus dynamics, survival curves, borderline-case scoring, and validation
- `r/` — viability-decay fitting, dormancy modeling, host-virus dynamics, life-criteria scoring, and survival summaries
- `julia/` — viability, dormancy, host-virus, and scoring calculations
- `fortran/` — compact numerical kernel for viability, dormancy, and viral dynamics
- `rust/` — safe command-line life-definition scoring utility
- `go/` — portable life-definition scoring helper
- `c/` — compact life-definition numerical kernel
- `cpp/` — comparative borderline-case scenario simulation
- `sql/` — viability observations, dormancy scenarios, host-virus scenarios, criteria matrices, outputs, and provenance schema
- `docs/` — setup, methodology, validation, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent reasoning about life, death, and borderline cases:

1. Estimate viability-loss rates from live-count time series.
2. Estimate mortality half-life under stress.
3. Simulate dormancy loss and reactivation.
4. Simulate host-virus dynamics.
5. Compare borderline cases using explicit life-criteria matrices.
6. Track assumptions, uncertainty, and provenance.
7. Separate measurable processes from philosophical definition.

These examples are educational and methodological scaffolds. They are not clinical, diagnostic, astrobiology mission, regulatory, biosafety, therapeutic, or environmental compliance systems. Real applications require empirical data, calibration, quality control, uncertainty analysis, domain expertise, and ethical or regulatory review where applicable.
