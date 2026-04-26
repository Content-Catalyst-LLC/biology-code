# Methodology Notes

## Purpose

The computational examples support ecology reasoning by translating interdependence, interaction, turnover, network structure, and ecosystem condition into transparent calculations. The examples are intentionally compact so they can be inspected, adapted, and extended.

## Core Methods

### Multi-Species Dynamics

The R, Julia, and C++ examples simulate producers, herbivores, carnivores, and a biomass or detrital pool. The model includes density dependence, trophic interaction, mortality, disturbance, and ecosystem process terms.

### Community Turnover

The Python workflow calculates Bray-Curtis dissimilarity across sites using a site-by-species abundance matrix.

### Ecological Condition

The ecological-condition score combines normalized Shannon diversity, productivity, nutrient retention, connectivity, mean turnover, and disturbance pressure. It is not a universal index. It is a transparent scaffold for comparing assumptions.

### Network Connectance

The network examples represent species interactions with an adjacency matrix and calculate connectance:

C = L / S^2

where L is the number of realized links and S is the number of species.

### Biomass Balance

The compact ecosystem-process balance is:

dB/dt = P - C - D + R

where B is a biomass or detrital pool, P is production, C is consumer removal, D is decomposition or loss, and R is recovery or regrowth.

## Interpretation

These workflows should be interpreted as educational ecology-analysis scaffolds, not as operational monitoring systems. Real applications require sampling design, calibrated parameters, spatial structure, uncertainty analysis, system-specific validation, and expert interpretation.
