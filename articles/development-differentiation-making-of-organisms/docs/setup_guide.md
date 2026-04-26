# Setup Guide

This directory contains small, reproducible examples for developmental biology, differentiation, growth, morphogen gradients, patterning, and state transitions.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/developmental_growth.py
python python/branching_differentiation.py
python python/morphogen_gradient.py
python python/reaction_diffusion_pattern.py
python python/state_transition_model.py
python python/developmental_condition_scoring.py

## R

Run:

Rscript r/developmental_growth.R
Rscript r/lineage_split_dynamics.R
Rscript r/morphogen_gradient_thresholds.R

## Julia

Run:

julia julia/development_model.jl

## Fortran

Compile and run:

gfortran fortran/development_kernel.f90 -o /tmp/development_kernel
/tmp/development_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/developmental_condition_score.go

## C

Compile and run:

cc c/development_kernel.c -lm -o /tmp/development_kernel_c
/tmp/development_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/development_scenario_simulation.cpp -o /tmp/development_scenario_simulation
/tmp/development_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/developmental_biology.db < sql/developmental_biology_schema.sql
sqlite3 /tmp/developmental_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/developmental_biology_workflow.ipynb` in JupyterLab or VS Code.
