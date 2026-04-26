# Setup Guide

This directory contains reproducible examples for cell-growth modeling, viability decay, membrane flux, cell-cycle compartments, treatment response, cell-condition scoring, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/cell_theory_core.py
python python/growth_models.py
python python/viability_decay.py
python python/membrane_flux.py
python python/cell_cycle_model.py
python python/treatment_response.py
python python/cell_condition_scoring.py
python python/run_all.py

## R

Run:

Rscript r/growth_models.R
Rscript r/viability_decay.R
Rscript r/treatment_response.R
Rscript r/cell_condition_scoring.R

## Julia

Run:

julia julia/cell_theory_model.jl

## Fortran

Compile and run:

gfortran fortran/cell_theory_kernel.f90 -o /tmp/cell_theory_kernel
/tmp/cell_theory_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/cell_condition_score.go

## C

Compile and run:

cc c/cell_theory_kernel.c -lm -o /tmp/cell_theory_kernel_c
/tmp/cell_theory_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/cell_condition_scenario_simulation.cpp -o /tmp/cell_condition_scenario_simulation
/tmp/cell_condition_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/cell_theory.db < sql/cell_theory_schema.sql
sqlite3 /tmp/cell_theory.db < sql/sample_queries.sql

## Notebook

Open `notebooks/cell_theory_workflow.ipynb` in JupyterLab or VS Code.
