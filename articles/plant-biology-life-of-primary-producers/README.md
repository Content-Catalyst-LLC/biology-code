# Plant Biology and the Life of Primary Producers

This article repository supports the Biology knowledge-series article:

**Plant Biology and the Life of Primary Producers**

The code distribution expands the article's compact R and Python examples into a fuller computational plant-biology workflow. It includes carbon-balance comparison, GPP/NPP/NEP accounting, light-response curves, drought-sensitivity screening, plant biomass recovery, canopy productivity analysis, restoration scenario comparison, SQL provenance structures, reproducible data files, and multi-language scientific-computing scaffolding.

## Repository Structure

- `python/` — productivity accounting, biomass recovery, light-response screening, and plant condition scoring
- `r/` — carbon balance, light-response scenarios, and restoration screening
- `julia/` — plant productivity and biomass recovery modeling
- `fortran/` — compact productivity and biomass numerical kernels
- `rust/` — safe command-line plant condition scoring utility
- `go/` — portable plant recovery scoring helper
- `c/` — productivity and light-response computational kernel
- `cpp/` — comparative plant scenario simulation
- `sql/` — plant sites, productivity scenarios, recovery scenarios, outputs, and provenance schema
- `docs/` — setup, methodology, and reproducibility notes
- `data/` — small reproducible example datasets
- `notebooks/` — notebook scaffold and workflow notes

## Scientific Focus

The workflows are designed to support transparent plant-biology reasoning:

1. Compare GPP, autotrophic respiration, heterotrophic respiration, NPP, and NEP across sites.
2. Model nonlinear light-response curves under drought and nutrient limitation.
3. Simulate biomass recovery after disturbance, planting, and hydrologic repair.
4. Screen plant condition using habitat, water, nutrient, disease, and connectivity indicators.
5. Track data provenance and reproducibility.

These examples are educational scaffolds, not operational forestry, crop, flux-tower, or restoration models. Real applications require calibrated field data, species or community traits, climate covariates, uncertainty analysis, site context, and expert interpretation.
