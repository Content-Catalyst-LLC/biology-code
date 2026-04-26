# Setup Guide

This directory contains reproducible examples for metabolism, energy allocation, growth modeling, substrate limitation, oxygen consumption, toy flux-balance analysis, metabolic condition scoring, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/metabolism_core.py
python python/growth_models.py
python python/yield_allocation.py
python python/monod_substrate_limitation.py
python python/respirometry_summary.py
python python/toy_flux_balance.py
python python/metabolic_condition_scoring.py
python python/run_all.py

## R

Run:

Rscript r/growth_models.R
Rscript r/yield_allocation.R
Rscript r/monod_substrate_limitation.R
Rscript r/respirometry_summary.R
Rscript r/metabolic_condition_scoring.R

## Julia

Run:

julia julia/metabolism_model.jl

## Fortran

Compile and run:

gfortran fortran/metabolism_kernel.f90 -o /tmp/metabolism_kernel
/tmp/metabolism_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/metabolic_condition_score.go

## C

Compile and run:

cc c/metabolism_kernel.c -lm -o /tmp/metabolism_kernel_c
/tmp/metabolism_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/metabolic_scenario_simulation.cpp -o /tmp/metabolic_scenario_simulation
/tmp/metabolic_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/metabolism.db < sql/metabolism_schema.sql
sqlite3 /tmp/metabolism.db < sql/sample_queries.sql

## Notebook

Open `notebooks/metabolism_workflow.ipynb` in JupyterLab or VS Code.
