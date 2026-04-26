# Setup Guide

This directory contains small, reproducible examples for fungal biology, decomposition, exchange, and restoration workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/stochastic_decomposition.py
python python/fungal_biomass_recovery.py
python python/mycelial_network_efficiency.py
python python/restoration_priority_screening.py

## R

Run:

Rscript r/decomposition_scenario_analysis.R
Rscript r/fungal_condition_scoring.R

## Julia

Run:

julia julia/fungal_decomposition_model.jl

## Fortran

Compile and run:

gfortran fortran/decomposition_biomass_kernel.f90 -o /tmp/decomposition_biomass_kernel
/tmp/decomposition_biomass_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/fungal_recovery_score.go

## C

Compile and run:

cc c/decomposition_q10_kernel.c -lm -o /tmp/decomposition_q10_kernel
/tmp/decomposition_q10_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/mycelial_network_efficiency.cpp -o /tmp/mycelial_network_efficiency
/tmp/mycelial_network_efficiency

## SQL

Use SQLite:

sqlite3 /tmp/fungal_exchange.db < sql/fungal_exchange_schema.sql
sqlite3 /tmp/fungal_exchange.db < sql/sample_queries.sql

## Notebook

Open `notebooks/fungal_exchange_workflow.ipynb` in JupyterLab or VS Code.
