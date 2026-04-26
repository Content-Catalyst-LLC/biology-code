# Methodology Notes

## Purpose

The computational examples support plant-biology reasoning by translating productivity, respiration, light response, biomass recovery, drought sensitivity, and plant condition into transparent calculations.

## Core Methods

### Carbon Balance

Net primary productivity:

NPP = GPP - Ra

Net ecosystem productivity:

NEP = GPP - (Ra + Rh)

where GPP is gross primary productivity, Ra is autotrophic respiration, and Rh is heterotrophic respiration.

### Light Response

A compact rectangular-hyperbola light-response model is:

A(I) = alpha I Amax / (alpha I + Amax) - Rd

where I is irradiance, alpha is initial quantum-use efficiency, Amax is the asymptotic photosynthetic maximum, and Rd is dark respiration.

### Biomass Recovery

Plant biomass recovery after disturbance is represented as:

dB/dt = rB(1 - B/K) - mB + I(t)

where B is biomass, r is intrinsic regrowth rate, K is carrying capacity, m is chronic stress loss, and I(t) is an intervention pulse.

### Condition Screening

The plant condition score combines canopy condition, water availability, nutrient status, soil function, disease pressure, drought stress, and regeneration support. It is an illustrative screening framework, not a substitute for field assessment.

## Interpretation

These workflows should be interpreted as educational computational plant-biology scaffolds, not calibrated ecosystem, crop, forestry, or carbon-accounting models. Real applications require field measurements, calibrated productivity data, uncertainty analysis, site context, and expert interpretation.
