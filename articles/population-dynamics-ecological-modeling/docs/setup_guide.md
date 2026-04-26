# Setup Guide

This directory contains small, reproducible examples for population dynamics and ecological modeling workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/stage_structured_projection.py
python python/stochastic_population_viability.py
python python/metapopulation_occupancy.py

## R

Run:

Rscript r/stochastic_logistic_pva.R

## Julia

Run:

julia julia/stochastic_population_model.jl

## Fortran

Compile and run:

gfortran fortran/logistic_growth_kernel.f90 -o /tmp/logistic_growth_kernel
/tmp/logistic_growth_kernel

gfortran fortran/stage_matrix_kernel.f90 -o /tmp/stage_matrix_kernel
/tmp/stage_matrix_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/population_persistence_score.go

## C

Compile and run:

cc c/logistic_harvest_kernel.c -lm -o /tmp/logistic_harvest_kernel
/tmp/logistic_harvest_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/stochastic_population_viability.cpp -o /tmp/stochastic_population_viability
/tmp/stochastic_population_viability

## SQL

Use SQLite:

sqlite3 /tmp/population_dynamics.db < sql/population_dynamics_schema.sql
sqlite3 /tmp/population_dynamics.db < sql/sample_queries.sql

## Notebook

Open `notebooks/population_dynamics_workflow.ipynb` in JupyterLab or VS Code.
