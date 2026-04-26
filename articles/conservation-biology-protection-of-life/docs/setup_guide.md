# Setup Guide

This directory contains small, reproducible examples for conservation biology workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/stochastic_pva.py
python python/conservation_priority.py

## R

Run:

Rscript r/stochastic_pva.R

## Julia

Run:

julia julia/metapopulation_connectivity.jl

## Fortran

Compile and run:

gfortran fortran/population_kernel.f90 -o /tmp/population_kernel
/tmp/population_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/conservation_priority.go

## C

Compile and run:

cc c/habitat_fragmentation_index.c -o /tmp/habitat_fragmentation_index
/tmp/habitat_fragmentation_index

## C++

Compile and run:

c++ -std=c++17 cpp/metapopulation_simulation.cpp -o /tmp/metapopulation_simulation
/tmp/metapopulation_simulation

## SQL

Use SQLite:

sqlite3 /tmp/conservation_biology.db < sql/conservation_schema.sql
sqlite3 /tmp/conservation_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/conservation_biology_workflow.ipynb` in JupyterLab or VS Code.
