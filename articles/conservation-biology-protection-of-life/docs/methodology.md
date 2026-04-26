# Methodology Notes

## Purpose

The computational examples support conservation biology reasoning by turning core concepts into transparent calculations. The examples are intentionally compact so they can be inspected, adapted, and extended.

## Core Methods

### Stochastic Population Viability Analysis

The population viability examples use a stochastic logistic model with annual variation in growth rate and carrying capacity. A catastrophe process is added to represent episodic disturbance.

The model tracks:

- final population size
- minimum population size
- extinction risk
- quasi-extinction risk
- median and mean final abundance

### Conservation Priority Scoring

The prioritization examples combine multiple normalized indicators:

- extinction risk
- endemism or irreplaceability
- habitat loss
- fragmentation pressure
- recovery potential
- relative implementation cost

The framework is not a universal conservation decision rule. It is a transparent scoring scaffold for comparing assumptions.

### Connectivity and Fragmentation

The Julia and C++ examples use compact patch-based models to show how patch quality, dispersal, and colonization affect persistence. The C example computes a simple fragmentation index from remaining habitat area and patch count.

## Interpretation

These workflows should be interpreted as decision-support tools, not substitutes for ecological expertise. Real conservation work requires field data, local ecological knowledge, governance context, uncertainty analysis, and ethical review.
