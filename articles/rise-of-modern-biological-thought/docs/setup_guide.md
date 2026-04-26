# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/modern_biology_core.py
python python/growth_models.py
python python/population_genetics.py
python python/sequence_similarity.py
python python/historical_timeline.py
python python/run_all.py

## R

Run:

Rscript r/growth_model.R
Rscript r/population_genetics.R
Rscript r/selection_recurrence.R
Rscript r/historical_timeline.R

## Julia

Run:

julia julia/modern_biology_model.jl

## Fortran

Compile and run:

gfortran fortran/modern_biology_kernel.f90 -o /tmp/modern_biology_kernel
/tmp/modern_biology_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/genotype_expectations.go

## C

Compile and run:

cc c/modern_biology_kernel.c -lm -o /tmp/modern_biology_kernel_c
/tmp/modern_biology_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/modern_biology_scenario_simulation.cpp -o /tmp/modern_biology_scenario_simulation
/tmp/modern_biology_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/modern_biology.db < sql/modern_biology_schema.sql
sqlite3 /tmp/modern_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/modern_biology_workflow.ipynb` in JupyterLab or VS Code.
