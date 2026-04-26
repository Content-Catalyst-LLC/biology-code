# Setup Guide

This directory contains small, reproducible examples for natural selection, adaptation, fitness, genotype-specific selection, quantitative traits, selection-drift dynamics, and variable environments.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/genotype_selection.py
python python/selection_drift_replicates.py
python python/quantitative_trait_selection.py
python python/time_series_frequency_screening.py
python python/selection_condition_scoring.py

## R

Run:

Rscript r/genotype_selection_regimes.R
Rscript r/quantitative_trait_selection.R
Rscript r/variable_environment_selection.R

## Julia

Run:

julia julia/selection_adaptation_model.jl

## Fortran

Compile and run:

gfortran fortran/selection_kernel.f90 -o /tmp/selection_kernel
/tmp/selection_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/selection_condition_score.go

## C

Compile and run:

cc c/genotype_selection_kernel.c -lm -o /tmp/genotype_selection_kernel
/tmp/genotype_selection_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/selection_scenario_simulation.cpp -o /tmp/selection_scenario_simulation
/tmp/selection_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/natural_selection.db < sql/natural_selection_schema.sql
sqlite3 /tmp/natural_selection.db < sql/sample_queries.sql

## Notebook

Open `notebooks/natural_selection_workflow.ipynb` in JupyterLab or VS Code.
