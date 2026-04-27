# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas

Run:

python python/experimental_design_core.py
python python/randomized_allocation.py
python python/two_group_inference.py
python python/power_simulation.py
python python/factorial_design.py
python python/blocked_design_summary.py
python python/bootstrap_uncertainty.py
python python/permutation_test.py
python python/mixed_effects_scaffold.py
python python/assay_design_simulation.py
python python/run_all.py

## R

Run:

Rscript r/two_group_effect_size.R
Rscript r/blocked_design.R
Rscript r/power_simulation.R
Rscript r/factorial_design.R
Rscript r/bootstrap_uncertainty.R
Rscript r/permutation_test.R

## Julia

Run:

julia julia/biostatistics_design_model.jl

## Fortran

Compile and run:

gfortran fortran/biostatistics_design_kernel.f90 -o /tmp/biostatistics_design_kernel
/tmp/biostatistics_design_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/design_helper.go

## C

Compile and run:

cc c/biostatistics_design_kernel.c -lm -o /tmp/biostatistics_design_kernel_c
/tmp/biostatistics_design_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/design_scenario_simulation.cpp -o /tmp/design_scenario_simulation
/tmp/design_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/biostatistics_design.db < sql/biostatistics_design_schema.sql
sqlite3 /tmp/biostatistics_design.db < sql/sample_queries.sql

## Notebook

Open `notebooks/biostatistics_experimental_design_workflow.ipynb` in JupyterLab or VS Code.
