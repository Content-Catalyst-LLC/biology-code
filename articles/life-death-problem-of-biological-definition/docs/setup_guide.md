# Setup Guide

This directory contains reproducible examples for viability decay, mortality, dormancy, host-virus dynamics, life-criteria scoring, borderline-case comparison, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/definition_core.py
python python/viability_decay.py
python python/dormancy_model.py
python python/host_virus_dynamics.py
python python/survival_curve.py
python python/borderline_case_scoring.py
python python/run_all.py

## R

Run:

Rscript r/viability_decay.R
Rscript r/dormancy_model.R
Rscript r/host_virus_dynamics.R
Rscript r/survival_curve.R
Rscript r/borderline_case_scoring.R

## Julia

Run:

julia julia/life_definition_model.jl

## Fortran

Compile and run:

gfortran fortran/life_definition_kernel.f90 -o /tmp/life_definition_kernel
/tmp/life_definition_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/life_definition_score.go

## C

Compile and run:

cc c/life_definition_kernel.c -lm -o /tmp/life_definition_kernel_c
/tmp/life_definition_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/life_definition_scenario_simulation.cpp -o /tmp/life_definition_scenario_simulation
/tmp/life_definition_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/life_definition.db < sql/life_definition_schema.sql
sqlite3 /tmp/life_definition.db < sql/sample_queries.sql

## Notebook

Open `notebooks/life_definition_workflow.ipynb` in JupyterLab or VS Code.
