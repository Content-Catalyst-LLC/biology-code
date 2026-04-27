# Modeling Disease, Epidemiology, and Biological Spread

This article repository supports the Biology knowledge-series article:

**Modeling Disease, Epidemiology, and Biological Spread**

This repository provides reproducible workflows for infectious-disease modeling, SIR and SEIR simulation, scenario comparison, effective reproduction number scaffolds, branching-process outbreak simulation, reporting-delay adjustment, validation metrics, provenance, SQL audit structures, notebook documentation, and cross-language scientific-computing scaffolding.

No university affiliation is implied by this repository. The design goal is advanced reproducible computational rigor: clear assumptions, modular code, transparent data structures, provenance, validation checks, uncertainty awareness, and reusable workflows.

## Repository Structure

- `python/` — primary workflows for SIR, SEIR, branching processes, nowcasting scaffolds, validation, provenance, and reporting
- `r/` — disease-modeling cross-checks
- `julia/` — numerical epidemiology kernels
- `fortran/` — compact compartment-model kernel
- `rust/` — safe command-line epidemic summary utility
- `go/` — portable epidemic summary helper
- `c/` — compact epidemic modeling kernel
- `cpp/` — scenario-based epidemiology implementation
- `sql/` — scenarios, surveillance observations, model outputs, workflow steps, artifacts, and provenance schema
- `docs/` — setup, methodology, validation, ethics, and reproducibility notes
- `data/` — synthetic reproducible epidemiological datasets
- `notebooks/` — notebook scaffold
- `outputs/` — generated tables, simulations, figures, and reports

## Scientific Focus

The workflows are designed to support transparent epidemiological modeling:

1. Simulate SIR disease dynamics.
2. Simulate SEIR disease dynamics.
3. Compare transmission and recovery scenarios.
4. Estimate simple growth-rate and Rt-proxy scaffolds.
5. Simulate branching-process outbreak spread.
6. Adjust reported cases using reporting-completeness scaffolds.
7. Calculate validation metrics.
8. Record provenance and artifact checksums.
9. Store surveillance and modeling records in SQL.
10. Cross-check core calculations across multiple languages.

These examples are educational and methodological scaffolds. They are not clinical guidance, public-health directives, outbreak-response tools, diagnostic systems, operational forecasts, or regulatory models. Real applications require domain-specific validation, public-health review, data-governance review, privacy review, and appropriate institutional oversight.
