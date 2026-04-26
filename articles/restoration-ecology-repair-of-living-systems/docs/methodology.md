# Methodology Notes

## Purpose

The workflows in this folder support a computational reading of restoration ecology. They do not claim to represent a universal restoration model. Instead, they provide transparent scaffolding for thinking about restoration as a coupled trajectory involving vegetation structure, soil or microbial recovery, functional integrity, intervention effort, belowground support, and continuing disturbance pressure.

## Core Modeling Logic

The simplified recovery model is:

dR/dt = k(T - R)

The expanded coupled model is:

dV/dt = aS - bV - cD
dM/dt = pV + qB - rM
dF/dt = uV + vM - wD

This structure makes three ecological ideas explicit:

1. visible vegetation recovery does not guarantee soil or microbial recovery
2. functional integrity may lag behind visible recovery
3. continuing disturbance can suppress restoration even when intervention effort is high

## Interpretation

The variables are dimensionless teaching-scale indicators. They can be adapted into empirical indicators such as native vegetation cover, canopy structure, recruitment density, soil organic matter, microbial biomass, nutrient retention, hydrological reconnection, habitat complexity, dissolved oxygen, sediment stability, and functional integrity scores.

## Limitations

These scripts are conceptual and pedagogical. Real restoration studies require site-specific data, uncertainty analysis, reference conditions, climate projections, disturbance histories, species pools, monitoring protocols, and governance context.
