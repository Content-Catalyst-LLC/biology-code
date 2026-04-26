# Methodology Notes

## Purpose

The computational examples support spatial ecology and biogeography reasoning by turning article concepts into transparent calculations. The examples are intentionally compact so they can be inspected, adapted, and extended.

## Core Methods

### Species-Area Modeling

The species-area workflow uses the classic relationship:

S = cA^z

where S is species richness, A is habitat area, c is a fitted constant, and z is the species-area exponent. The R example fits this model on a log-log scale, bootstraps uncertainty in z, and compares baseline area with a fragmentation scenario.

### Habitat Suitability Modeling

The habitat suitability workflow uses environmental predictors such as temperature, precipitation, soil quality, connectivity, disturbance, and land-use pressure to estimate occurrence probability. The Python example uses logistic regression with scaling and cross-validation.

### Distance-Decay and Turnover

The distance-decay example models increasing ecological dissimilarity with geographic or environmental distance:

beta = 1 - exp(-k * distance)

This is a compact representation of spatial turnover, dispersal limitation, and environmental differentiation.

### Spatial Prioritization

The prioritization examples combine suitability, connectivity, and land-use pressure. This is not a universal conservation decision rule. It is a transparent scaffold for comparing assumptions.

## Interpretation

These workflows should be interpreted as educational decision-support scaffolds, not as operational species distribution models. Real applications require spatially explicit data, sampling-bias correction, spatial cross-validation, environmental rasters, ecological expertise, and uncertainty analysis.
