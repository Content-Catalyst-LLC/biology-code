# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas

Run:

python python/statistics_measurement_core.py
python python/descriptive_uncertainty.py
python python/uncertainty_budget.py
python python/calibration_curve.py
python python/measurement_error_simulation.py
python python/variance_components.py
python python/bootstrap_intervals.py
python python/assay_quality_control.py
python python/error_propagation.py
python python/mixed_effects_scaffold.py
python python/run_all.py

## R

Run:

Rscript r/descriptive_uncertainty.R
Rscript r/uncertainty_budget.R
Rscript r/calibration_curve.R
Rscript r/variance_components.R
Rscript r/bootstrap_intervals.R
Rscript r/measurement_error_simulation.R

## Julia

Run:

julia julia/statistics_measurement_model.jl

## Fortran

Compile and run:

gfortran fortran/statistics_measurement_kernel.f90 -o /tmp/statistics_measurement_kernel
/tmp/statistics_measurement_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/measurement_helper.go

## C

Compile and run:

cc c/statistics_measurement_kernel.c -lm -o /tmp/statistics_measurement_kernel_c
/tmp/statistics_measurement_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/measurement_scenario_simulation.cpp -o /tmp/measurement_scenario_simulation
/tmp/measurement_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/statistics_measurement.db < sql/statistics_measurement_schema.sql
sqlite3 /tmp/statistics_measurement.db < sql/sample_queries.sql

## Notebook

Open `notebooks/statistics_measurement_workflow.ipynb` in JupyterLab or VS Code.
