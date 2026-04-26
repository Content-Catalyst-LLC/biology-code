# Setup Guide

This directory contains small, reproducible examples for immunology and biological-defense workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/immune_scenario_screening.py
python python/immune_condition_scoring.py
python python/host_pathogen_time_series.py

## R

Run:

Rscript r/coupled_host_pathogen_immune_dynamics.R

## Julia

Run:

julia julia/immune_response_model.jl

## Fortran

Compile and run:

gfortran fortran/host_pathogen_immune_kernel.f90 -o /tmp/host_pathogen_immune_kernel
/tmp/host_pathogen_immune_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/immune_condition_score.go

## C

Compile and run:

cc c/host_pathogen_threshold_kernel.c -lm -o /tmp/host_pathogen_threshold_kernel
/tmp/host_pathogen_threshold_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/immune_scenario_simulation.cpp -o /tmp/immune_scenario_simulation
/tmp/immune_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/immunology_defense.db < sql/immunology_defense_schema.sql
sqlite3 /tmp/immunology_defense.db < sql/sample_queries.sql

## Notebook

Open `notebooks/immunology_defense_workflow.ipynb` in JupyterLab or VS Code.
