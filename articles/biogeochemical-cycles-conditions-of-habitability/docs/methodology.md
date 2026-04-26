# Methodology Notes

## Purpose

The computational examples support biogeochemical reasoning by translating article concepts into transparent calculations. The examples are intentionally compact so they can be inspected, adapted, and extended.

## Core Methods

### Mass Balance

The general stock-flow form is:

dX/dt = inputs - outputs + transformations

This applies to atmospheric carbon, reactive nitrogen surplus, phosphorus loading, dissolved oxygen, and many other reservoirs.

### Multi-Reservoir Simulation

The R and C++ examples track simplified reservoirs through time:

- cumulative atmospheric carbon burden
- cumulative coastal nitrogen surplus
- land and ocean uptake
- disturbance release
- coastal assimilation

### Habitability-Support Screening

The Python and Rust examples combine normalized indicators:

- carbon uptake capacity
- water regulation
- nitrogen retention
- phosphorus buffering
- oxygen stability
- disturbance pressure
- acidification pressure
- nutrient loading

Positive terms represent buffering or support capacity. Negative terms represent pressures that weaken habitability.

### Dissolved-Oxygen Stress

The oxygen model uses:

oxygen change = production - respiration demand - decomposition demand - stratification limitation

This is not a full lake or estuary model. It is a transparent scaffold for thinking about oxygen stress.

## Interpretation

These workflows should be interpreted as educational decision-support scaffolds, not as operational Earth-system models. Real applications require field chemistry, laboratory methods, hydrological context, microbial process data, uncertainty analysis, and expert interpretation.
