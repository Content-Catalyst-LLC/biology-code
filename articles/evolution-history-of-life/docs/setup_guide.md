# Setup Guide

This directory contains small, reproducible examples for evolution, allele-frequency change, sequence divergence, birth-death diversification, major transitions, and deep-time reasoning.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/allele_frequency_evolution.py
python python/wright_fisher_replicates.py
python python/sequence_distance_matrix.py
python python/birth_death_diversification.py
python python/evolutionary_condition_scoring.py

## R

Run:

Rscript r/selection_mutation_migration_drift.R
Rscript r/sequence_divergence_matrix.R
Rscript r/birth_death_ltt_screening.R

## Julia

Run:

julia julia/evolution_history_model.jl

## Fortran

Compile and run:

gfortran fortran/evolution_kernel.f90 -o /tmp/evolution_kernel
/tmp/evolution_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/evolution_condition_score.go

## C

Compile and run:

cc c/evolution_kernel.c -lm -o /tmp/evolution_kernel_c
/tmp/evolution_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/evolution_scenario_simulation.cpp -o /tmp/evolution_scenario_simulation
/tmp/evolution_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/evolution_history.db < sql/evolution_history_schema.sql
sqlite3 /tmp/evolution_history.db < sql/sample_queries.sql

## Notebook

Open `notebooks/evolution_history_workflow.ipynb` in JupyterLab or VS Code.
