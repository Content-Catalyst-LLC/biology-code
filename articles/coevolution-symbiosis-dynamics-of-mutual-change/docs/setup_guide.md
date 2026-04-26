# Setup Guide

This directory contains small, reproducible examples for coevolution, symbiosis, reciprocal selection, and interaction-risk workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/benefit_cost_threshold.py
python python/host_pathogen_dynamics.py
python python/network_dependency_scoring.py
python python/reciprocal_feedback.py

## R

Run:

Rscript r/context_dependent_mutualism.R
Rscript r/reciprocal_frequency_dynamics.R
Rscript r/interaction_risk_screening.R

## Julia

Run:

julia julia/coevolution_symbiosis_model.jl

## Fortran

Compile and run:

gfortran fortran/coevolution_kernel.f90 -o /tmp/coevolution_kernel
/tmp/coevolution_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/coevolution_risk_score.go

## C

Compile and run:

cc c/benefit_cost_kernel.c -lm -o /tmp/benefit_cost_kernel
/tmp/benefit_cost_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/coevolution_scenario_simulation.cpp -o /tmp/coevolution_scenario_simulation
/tmp/coevolution_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/coevolution_symbiosis.db < sql/coevolution_symbiosis_schema.sql
sqlite3 /tmp/coevolution_symbiosis.db < sql/sample_queries.sql

## Notebook

Open `notebooks/coevolution_symbiosis_workflow.ipynb` in JupyterLab or VS Code.
