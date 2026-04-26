# Setup Guide

This directory contains reproducible examples for cell architecture, membrane transport, compartment flux, organelle morphometry, organelle interaction networks, condition scoring, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/cell_architecture_core.py
python python/membrane_transport.py
python python/compartment_flux_model.py
python python/organelle_morphometry.py
python python/organelle_network.py
python python/cellular_architecture_condition_scoring.py
python python/run_all.py

## R

Run:

Rscript r/surface_area_volume_scaling.R
Rscript r/membrane_transport.R
Rscript r/organelle_morphometry.R
Rscript r/organelle_network.R
Rscript r/cellular_architecture_condition_scoring.R

## Julia

Run:

julia julia/cell_architecture_model.jl

## Fortran

Compile and run:

gfortran fortran/cell_architecture_kernel.f90 -o /tmp/cell_architecture_kernel
/tmp/cell_architecture_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/cellular_architecture_score.go

## C

Compile and run:

cc c/cell_architecture_kernel.c -lm -o /tmp/cell_architecture_kernel_c
/tmp/cell_architecture_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/cell_architecture_scenario_simulation.cpp -o /tmp/cell_architecture_scenario_simulation
/tmp/cell_architecture_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/cell_architecture.db < sql/cell_architecture_schema.sql
sqlite3 /tmp/cell_architecture.db < sql/sample_queries.sql

## Notebook

Open `notebooks/cell_architecture_workflow.ipynb` in JupyterLab or VS Code.
