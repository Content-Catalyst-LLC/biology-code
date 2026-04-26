# Biogeochemical Cycles and the Conditions of Habitability

This article repository supports the Biology knowledge-series article:

**Biogeochemical Cycles and the Conditions of Habitability**

The code distribution expands the article's compact R and Python examples into a fuller computational biogeochemistry workflow. It includes multi-reservoir carbon and nutrient simulations, habitability-support screening, dissolved-oxygen stress modeling, nutrient-loading scenarios, SQL provenance structures, reproducible data files, and multi-language scientific-computing scaffolding.

## Repository Structure

- `python/` — habitability-support scoring, nutrient-loading scenarios, and dissolved-oxygen screening
- `r/` — multi-reservoir carbon and reactive nitrogen Monte Carlo simulation
- `julia/` — coupled carbon-nitrogen-oxygen reservoir dynamics
- `fortran/` — compact mass-balance numerical kernel
- `rust/` — safe command-line habitability-support scoring utility
- `go/` — portable nutrient-risk scoring helper
- `c/` — dissolved-oxygen balance computational kernel
- `cpp/` — multi-reservoir biogeochemical simulation
- `sql/` — reservoir, flux, observation, scenario, and provenance schema
- `docs/` — setup, methodology, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent biogeochemical reasoning:

1. Track stocks, flows, reservoirs, and transformations.
2. Simulate carbon and nutrient accumulation under uncertainty.
3. Screen habitability-support capacity across ecological units.
4. Model dissolved-oxygen stress from production, respiration, decomposition, and stratification.
5. Track data provenance and reproducibility.

These examples are educational scaffolds, not operational Earth-system models. Real biogeochemical analysis requires validated field data, laboratory chemistry, uncertainty analysis, spatial context, domain expertise, and careful interpretation across scale.
