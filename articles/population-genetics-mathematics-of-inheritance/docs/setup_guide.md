# Setup Guide

This directory contains small, reproducible examples for population genetics, Hardy-Weinberg expectations, selection, mutation, migration, drift, and population structure.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/hardy_weinberg_selection.py
python python/wright_fisher_replicates.py
python python/genotype_matrix_hw_screening.py
python python/migration_selection_balance.py
python python/population_structure_scoring.py

## R

Run:

Rscript r/hardy_weinberg_selection_drift.R
Rscript r/multipop_fst_bottleneck_screening.R
Rscript r/migration_selection_balance.R

## Julia

Run:

julia julia/population_genetics_model.jl

## Fortran

Compile and run:

gfortran fortran/population_genetics_kernel.f90 -o /tmp/population_genetics_kernel
/tmp/population_genetics_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/population_genetics_score.go

## C

Compile and run:

cc c/genotype_selection_kernel.c -lm -o /tmp/genotype_selection_kernel
/tmp/genotype_selection_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/population_genetics_scenario_simulation.cpp -o /tmp/population_genetics_scenario_simulation
/tmp/population_genetics_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/population_genetics.db < sql/population_genetics_schema.sql
sqlite3 /tmp/population_genetics.db < sql/sample_queries.sql

## Notebook

Open `notebooks/population_genetics_workflow.ipynb` in JupyterLab or VS Code.
