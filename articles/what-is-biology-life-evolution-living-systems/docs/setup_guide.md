# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/biology_core.py
python python/growth_models.py
python python/population_genetics.py
python python/biodiversity_summary.py
python python/sequence_similarity.py
python python/biological_levels.py
python python/run_all.py

## R

Run:

Rscript r/growth_model.R
Rscript r/population_genetics.R
Rscript r/biodiversity_summary.R
Rscript r/biological_levels.R

## Julia

Run:

julia julia/biology_foundations_model.jl

## Fortran

Compile and run:

gfortran fortran/biology_foundations_kernel.f90 -o /tmp/biology_foundations_kernel
/tmp/biology_foundations_kernel

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

cc c/biology_foundations_kernel.c -lm -o /tmp/biology_foundations_kernel_c
/tmp/biology_foundations_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/biological_systems_scenario_simulation.cpp -o /tmp/biological_systems_scenario_simulation
/tmp/biological_systems_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/biology_foundations.db < sql/biology_foundations_schema.sql
sqlite3 /tmp/biology_foundations.db < sql/sample_queries.sql

## Notebook

Open `notebooks/biology_foundations_workflow.ipynb` in JupyterLab or VS Code.
