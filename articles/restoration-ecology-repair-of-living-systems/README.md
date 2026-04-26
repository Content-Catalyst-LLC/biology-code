# Restoration Ecology and the Repair of Living Systems

This folder supports the Biology knowledge-series article **Restoration Ecology and the Repair of Living Systems**.

## Purpose

This repository folder expands the article's compact quantitative examples into reproducible computational restoration ecology workflows. It focuses on ecological recovery trajectories, coupled vegetation-soil-function repair, disturbance pressure, restoration intervention intensity, scenario comparison, functional thresholds, monitoring indicators, SQL provenance, and evidence structures for adaptive management.

## Included Materials

- Python workflows for restoration scenario simulation, recovery classification, and monitoring summaries
- R workflows for coupled restoration trajectories and scenario screening
- Julia numerical restoration model scaffold
- Fortran recovery table scaffold
- Rust command-line restoration scenario utility
- Go command-line restoration scenario utility
- C compact recovery model example
- C++ parameter sweep scaffold
- SQL schema for restoration projects, indicators, interventions, monitoring records, scenarios, and provenance
- notebooks folder for future computational restoration notebooks
- setup, methodology, and reproducibility documentation
- sample data tables

## Core Conceptual Model

A simple recovery model can be written as:

dR/dt = k(T - R)

where:

- R = current restoration state
- T = target functional condition
- k = recovery rate

A coupled restoration system can be written as:

dV/dt = aS - bV - cD
dM/dt = pV + qB - rM
dF/dt = uV + vM - wD

where:

- V = vegetation structure
- M = soil or microbial recovery
- F = functional integrity
- S = restoration effort or seeding input
- B = belowground support
- D = continuing disturbance pressure

## Article Repository URL

https://github.com/Content-Catalyst-LLC/biology-code/tree/main/articles/restoration-ecology-repair-of-living-systems
