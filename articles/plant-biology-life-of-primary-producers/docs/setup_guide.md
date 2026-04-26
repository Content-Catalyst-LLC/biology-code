# Setup Guide

This directory contains small, reproducible examples for plant biology, productivity, light response, biomass recovery, and restoration screening.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/productivity_carbon_balance.py
python python/biomass_recovery.py
python python/canopy_light_response.py
python python/plant_condition_scoring.py

## R

Run:

Rscript r/carbon_balance_site_comparison.R
Rscript r/light_response_drought_screening.R
Rscript r/restoration_recovery_screening.R

## Julia

Run:

julia julia/plant_productivity_model.jl

## Fortran

Compile and run:

gfortran fortran/plant_productivity_kernel.f90 -o /tmp/plant_productivity_kernel
/tmp/plant_productivity_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/plant_recovery_score.go

## C

Compile and run:

cc c/productivity_light_kernel.c -lm -o /tmp/productivity_light_kernel
/tmp/productivity_light_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/plant_scenario_simulation.cpp -o /tmp/plant_scenario_simulation
/tmp/plant_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/plant_biology.db < sql/plant_biology_schema.sql
sqlite3 /tmp/plant_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/plant_biology_workflow.ipynb` in JupyterLab or VS Code.
