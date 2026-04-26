# Setup Guide

This directory contains small, reproducible examples for reproduction, life cycles, and biological continuity workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/stage_reproductive_projection.py
python python/life_history_continuity_screening.py

## R

Run:

Rscript r/stage_structured_reproductive_projection.R

## Julia

Run:

julia julia/reproductive_life_cycle_projection.jl

## Fortran

Compile and run:

gfortran fortran/stage_matrix_reproduction_kernel.f90 -o /tmp/stage_matrix_reproduction_kernel
/tmp/stage_matrix_reproduction_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/reproductive_continuity_score.go

## C

Compile and run:

cc c/reproductive_replacement_kernel.c -lm -o /tmp/reproductive_replacement_kernel
/tmp/reproductive_replacement_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/life_cycle_projection.cpp -o /tmp/life_cycle_projection
/tmp/life_cycle_projection

## SQL

Use SQLite:

sqlite3 /tmp/reproduction_life_cycles.db < sql/reproduction_life_cycles_schema.sql
sqlite3 /tmp/reproduction_life_cycles.db < sql/sample_queries.sql

## Notebook

Open `notebooks/reproduction_life_cycles_workflow.ipynb` in JupyterLab or VS Code.
