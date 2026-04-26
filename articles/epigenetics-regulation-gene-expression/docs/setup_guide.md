# Setup Guide

This directory contains small, reproducible examples for epigenetics, regulation, gene expression, methylation, accessibility, and cell-state dynamics.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/expression_kinetics.py
python python/regulatory_switching.py
python python/differential_expression_accessibility.py
python python/cell_state_transitions.py
python python/epigenetic_condition_scoring.py

## R

Run:

Rscript r/expression_kinetics.R
Rscript r/regulatory_state_methylation.R
Rscript r/integrated_regulatory_summary.R

## Julia

Run:

julia julia/epigenetics_expression_model.jl

## Fortran

Compile and run:

gfortran fortran/epigenetics_kernel.f90 -o /tmp/epigenetics_kernel
/tmp/epigenetics_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/epigenetic_condition_score.go

## C

Compile and run:

cc c/epigenetics_kernel.c -lm -o /tmp/epigenetics_kernel_c
/tmp/epigenetics_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/regulatory_scenario_simulation.cpp -o /tmp/regulatory_scenario_simulation
/tmp/regulatory_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/epigenetics_expression.db < sql/epigenetics_expression_schema.sql
sqlite3 /tmp/epigenetics_expression.db < sql/sample_queries.sql

## Notebook

Open `notebooks/epigenetics_expression_workflow.ipynb` in JupyterLab or VS Code.
