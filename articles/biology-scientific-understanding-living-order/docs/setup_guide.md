# Setup Guide

This directory contains reproducible examples for living order, homeostasis, perturbation recovery, growth, logistic constraint, feedback loops, biological networks, condition scoring, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/living_order_core.py
python python/homeostasis_model.py
python python/growth_models.py
python python/feedback_dynamics.py
python python/network_order.py
python python/resilience_index.py
python python/living_order_condition_scoring.py
python python/run_all.py

## R

Run:

Rscript r/homeostasis_model.R
Rscript r/growth_models.R
Rscript r/feedback_dynamics.R
Rscript r/network_order.R
Rscript r/living_order_condition_scoring.R

## Julia

Run:

julia julia/living_order_model.jl

## Fortran

Compile and run:

gfortran fortran/living_order_kernel.f90 -o /tmp/living_order_kernel
/tmp/living_order_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/living_order_condition_score.go

## C

Compile and run:

cc c/living_order_kernel.c -lm -o /tmp/living_order_kernel_c
/tmp/living_order_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/living_order_scenario_simulation.cpp -o /tmp/living_order_scenario_simulation
/tmp/living_order_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/living_order.db < sql/living_order_schema.sql
sqlite3 /tmp/living_order.db < sql/sample_queries.sql

## Notebook

Open `notebooks/living_order_workflow.ipynb` in JupyterLab or VS Code.
