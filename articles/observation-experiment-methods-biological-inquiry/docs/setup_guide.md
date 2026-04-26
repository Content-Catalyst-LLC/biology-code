# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/biological_methods_core.py
python python/growth_models.py
python python/assay_validation.py
python python/sequence_matching.py
python python/imaging_summary.py
python python/experimental_signal_scoring.py
python python/run_all.py

## R

Run:

Rscript r/growth_curve.R
Rscript r/assay_validation.R
Rscript r/experimental_summary.R
Rscript r/signal_scoring.R

## Julia

Run:

julia julia/biological_methods_model.jl

## Fortran

Compile and run:

gfortran fortran/biological_methods_kernel.f90 -o /tmp/biological_methods_kernel
/tmp/biological_methods_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/assay_validation.go

## C

Compile and run:

cc c/biological_methods_kernel.c -lm -o /tmp/biological_methods_kernel_c
/tmp/biological_methods_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/experimental_scenario_simulation.cpp -o /tmp/experimental_scenario_simulation
/tmp/experimental_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/biological_methods.db < sql/biological_methods_schema.sql
sqlite3 /tmp/biological_methods.db < sql/sample_queries.sql

## Notebook

Open `notebooks/biological_methods_workflow.ipynb` in JupyterLab or VS Code.
