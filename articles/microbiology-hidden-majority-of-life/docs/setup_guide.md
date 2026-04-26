# Setup Guide

This directory contains small, reproducible examples for microbiology, microbial ecology, growth, recovery, and community-condition workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/monod_growth_scenarios.py
python python/community_recovery.py
python python/microbial_condition_scoring.py
python python/monte_carlo_growth_uncertainty.py

## R

Run:

Rscript r/growth_environment_screening.R
Rscript r/microbial_condition_index.R

## Julia

Run:

julia julia/microbial_growth_model.jl

## Fortran

Compile and run:

gfortran fortran/microbial_growth_kernel.f90 -o /tmp/microbial_growth_kernel
/tmp/microbial_growth_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/microbial_recovery_score.go

## C

Compile and run:

cc c/logistic_monod_kernel.c -lm -o /tmp/logistic_monod_kernel
/tmp/logistic_monod_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/microbial_scenario_simulation.cpp -o /tmp/microbial_scenario_simulation
/tmp/microbial_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/microbiology_hidden_majority.db < sql/microbiology_schema.sql
sqlite3 /tmp/microbiology_hidden_majority.db < sql/sample_queries.sql

## Notebook

Open `notebooks/microbiology_hidden_majority_workflow.ipynb` in JupyterLab or VS Code.
