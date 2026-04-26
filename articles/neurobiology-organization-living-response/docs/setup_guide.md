# Setup Guide

This directory contains small, reproducible examples for neurobiology and living-response workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/leaky_integrator_response.py
python python/recurrent_network_response.py
python python/neural_condition_screening.py

## R

Run:

Rscript r/leaky_neural_integration.R

## Julia

Run:

julia julia/neural_response_model.jl

## Fortran

Compile and run:

gfortran fortran/membrane_integration_kernel.f90 -o /tmp/membrane_integration_kernel
/tmp/membrane_integration_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/neural_response_score.go

## C

Compile and run:

cc c/membrane_threshold_kernel.c -lm -o /tmp/membrane_threshold_kernel
/tmp/membrane_threshold_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/recurrent_network_simulation.cpp -o /tmp/recurrent_network_simulation
/tmp/recurrent_network_simulation

## SQL

Use SQLite:

sqlite3 /tmp/neurobiology_response.db < sql/neurobiology_response_schema.sql
sqlite3 /tmp/neurobiology_response.db < sql/sample_queries.sql

## Notebook

Open `notebooks/neurobiology_response_workflow.ipynb` in JupyterLab or VS Code.
