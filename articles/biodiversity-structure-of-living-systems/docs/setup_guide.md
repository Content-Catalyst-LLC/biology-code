# Setup Guide

This directory contains small, reproducible examples for biodiversity and living-systems structure workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy scipy scikit-learn matplotlib

Run:

python python/diversity_metrics.py
python python/biodiversity_priority_screening.py

## R

Run:

Rscript r/biodiversity_workflow.R

## Julia

Run:

julia julia/hill_diversity_profile.jl

## Fortran

Compile and run:

gfortran fortran/shannon_kernel.f90 -o /tmp/shannon_kernel
/tmp/shannon_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/biodiversity_priority_score.go

## C

Compile and run:

cc c/diversity_kernel.c -lm -o /tmp/diversity_kernel
/tmp/diversity_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/diversity_turnover_simulation.cpp -o /tmp/diversity_turnover_simulation
/tmp/diversity_turnover_simulation

## SQL

Use SQLite:

sqlite3 /tmp/biodiversity_structure.db < sql/biodiversity_schema.sql
sqlite3 /tmp/biodiversity_structure.db < sql/sample_queries.sql

## Notebook

Open `notebooks/biodiversity_structure_workflow.ipynb` in JupyterLab or VS Code.
