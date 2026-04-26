# Setup Guide

This directory contains reproducible examples for water biology, energy throughput, osmotic pressure, water potential, homeostasis, oxygen limitation, growth, energy allocation, material-condition scoring, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/water_energy_core.py
python python/osmotic_pressure.py
python python/water_potential.py
python python/homeostatic_setpoint.py
python python/growth_energy_model.py
python python/oxygen_limitation.py
python python/energy_budget_allocation.py
python python/material_condition_scoring.py
python python/run_all.py

## R

Run:

Rscript r/osmotic_pressure.R
Rscript r/homeostatic_setpoint.R
Rscript r/growth_energy_model.R
Rscript r/oxygen_limitation.R
Rscript r/material_condition_scoring.R

## Julia

Run:

julia julia/water_energy_model.jl

## Fortran

Compile and run:

gfortran fortran/water_energy_kernel.f90 -o /tmp/water_energy_kernel
/tmp/water_energy_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/material_condition_score.go

## C

Compile and run:

cc c/water_energy_kernel.c -lm -o /tmp/water_energy_kernel_c
/tmp/water_energy_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/material_condition_scenario_simulation.cpp -o /tmp/material_condition_scenario_simulation
/tmp/material_condition_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/water_energy.db < sql/water_energy_schema.sql
sqlite3 /tmp/water_energy.db < sql/sample_queries.sql

## Notebook

Open `notebooks/water_energy_workflow.ipynb` in JupyterLab or VS Code.
