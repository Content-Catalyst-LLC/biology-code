# Setup Guide

This directory contains small, reproducible examples for extinction, contingency, survivorship, hazard, recovery, and trait-risk workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/clade_loss_comparison.py
python python/stochastic_survivorship.py
python python/post_crisis_recovery.py
python python/trait_risk_screening.py
python python/phylogenetic_loss_scoring.py
python python/extinction_condition_scoring.py

## R

Run:

Rscript r/survivorship_clade_comparison.R
Rscript r/hazard_recovery_screening.R
Rscript r/trait_extinction_risk.R

## Julia

Run:

julia julia/extinction_recovery_model.jl

## Fortran

Compile and run:

gfortran fortran/extinction_kernel.f90 -o /tmp/extinction_kernel
/tmp/extinction_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/extinction_risk_score.go

## C

Compile and run:

cc c/survivorship_recovery_kernel.c -lm -o /tmp/survivorship_recovery_kernel
/tmp/survivorship_recovery_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/extinction_scenario_simulation.cpp -o /tmp/extinction_scenario_simulation
/tmp/extinction_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/extinction_contingency.db < sql/extinction_contingency_schema.sql
sqlite3 /tmp/extinction_contingency.db < sql/sample_queries.sql

## Notebook

Open `notebooks/extinction_contingency_workflow.ipynb` in JupyterLab or VS Code.
