# Setup Guide

This directory contains small, reproducible examples for biogeochemical cycles and habitability workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/habitability_risk_screening.py
python python/dissolved_oxygen_stress.py

## R

Run:

Rscript r/multi_reservoir_biogeochem.R

## Julia

Run:

julia julia/coupled_reservoir_dynamics.jl

## Fortran

Compile and run:

gfortran fortran/mass_balance_kernel.f90 -o /tmp/mass_balance_kernel
/tmp/mass_balance_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/nutrient_risk_score.go

## C

Compile and run:

cc c/dissolved_oxygen_kernel.c -o /tmp/dissolved_oxygen_kernel
/tmp/dissolved_oxygen_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/biogeochemical_reservoir_simulation.cpp -o /tmp/biogeochemical_reservoir_simulation
/tmp/biogeochemical_reservoir_simulation

## SQL

Use SQLite:

sqlite3 /tmp/biogeochemical_cycles.db < sql/biogeochemical_schema.sql
sqlite3 /tmp/biogeochemical_cycles.db < sql/sample_queries.sql

## Notebook

Open `notebooks/biogeochemical_cycles_workflow.ipynb` in JupyterLab or VS Code.
