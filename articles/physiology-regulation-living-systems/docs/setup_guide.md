# Setup Guide

This directory contains small, reproducible examples for physiology and regulatory-systems workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/feedback_scenario_screening.py
python python/physiological_condition_scoring.py
python python/homeostatic_time_series.py

## R

Run:

Rscript r/coupled_homeostatic_feedback.R

## Julia

Run:

julia julia/physiological_feedback_model.jl

## Fortran

Compile and run:

gfortran fortran/physiological_feedback_kernel.f90 -o /tmp/physiological_feedback_kernel
/tmp/physiological_feedback_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/physiological_condition_score.go

## C

Compile and run:

cc c/balance_feedback_kernel.c -lm -o /tmp/balance_feedback_kernel
/tmp/balance_feedback_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/regulatory_scenario_simulation.cpp -o /tmp/regulatory_scenario_simulation
/tmp/regulatory_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/physiology_regulation.db < sql/physiology_regulation_schema.sql
sqlite3 /tmp/physiology_regulation.db < sql/sample_queries.sql

## Notebook

Open `notebooks/physiology_regulation_workflow.ipynb` in JupyterLab or VS Code.
