# Setup Guide

This directory contains small, reproducible examples for animal biology, allometry, survival screening, and population recovery workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/energy_demand_allometry.py
python python/survival_stress_screening.py
python python/stage_structured_projection.py
python python/population_recovery.py
python python/animal_condition_scoring.py

## R

Run:

Rscript r/allometry_trait_screening.R
Rscript r/population_recovery_interventions.R

## Julia

Run:

julia julia/animal_allometry_projection.jl

## Fortran

Compile and run:

gfortran fortran/animal_population_kernel.f90 -o /tmp/animal_population_kernel
/tmp/animal_population_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/animal_recovery_score.go

## C

Compile and run:

cc c/allometry_survival_kernel.c -lm -o /tmp/allometry_survival_kernel
/tmp/allometry_survival_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/animal_scenario_simulation.cpp -o /tmp/animal_scenario_simulation
/tmp/animal_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/animal_biology.db < sql/animal_biology_schema.sql
sqlite3 /tmp/animal_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/animal_biology_workflow.ipynb` in JupyterLab or VS Code.
