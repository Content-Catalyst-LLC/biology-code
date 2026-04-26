# Setup Guide

This directory contains small, reproducible examples for microevolution, macroevolution, deep time, population genetics, divergence, and clade turnover workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/hardy_weinberg_selection.py
python python/wright_fisher_selection.py
python python/sequence_distance_matrix.py
python python/birth_death_screen.py
python python/evolutionary_scale_summary.py

## R

Run:

Rscript r/population_genetic_simulation.R
Rscript r/sequence_divergence_matrix.R
Rscript r/clade_turnover_screening.R

## Julia

Run:

julia julia/evolutionary_scale_model.jl

## Fortran

Compile and run:

gfortran fortran/evolutionary_scale_kernel.f90 -o /tmp/evolutionary_scale_kernel
/tmp/evolutionary_scale_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/evolutionary_scale_score.go

## C

Compile and run:

cc c/allele_diversification_kernel.c -lm -o /tmp/allele_diversification_kernel
/tmp/allele_diversification_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/evolutionary_scale_simulation.cpp -o /tmp/evolutionary_scale_simulation
/tmp/evolutionary_scale_simulation

## SQL

Use SQLite:

sqlite3 /tmp/micro_macro_deep_time.db < sql/evolutionary_scale_schema.sql
sqlite3 /tmp/micro_macro_deep_time.db < sql/sample_queries.sql

## Notebook

Open `notebooks/micro_macro_deep_time_workflow.ipynb` in JupyterLab or VS Code.
