# Setup Guide

This directory contains small, reproducible examples for ecology and interdependence workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy scipy scikit-learn matplotlib

Run:

python python/ecological_condition_screening.py
python python/network_connectance.py

## R

Run:

Rscript r/multispecies_ecological_dynamics.R

## Julia

Run:

julia julia/ecological_interdependence_model.jl

## Fortran

Compile and run:

gfortran fortran/ecological_interaction_kernel.f90 -o /tmp/ecological_interaction_kernel
/tmp/ecological_interaction_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/ecological_condition_score.go

## C

Compile and run:

cc c/interaction_biomass_kernel.c -lm -o /tmp/interaction_biomass_kernel
/tmp/interaction_biomass_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/multispecies_ecosystem_simulation.cpp -o /tmp/multispecies_ecosystem_simulation
/tmp/multispecies_ecosystem_simulation

## SQL

Use SQLite:

sqlite3 /tmp/ecology_interdependence.db < sql/ecology_interdependence_schema.sql
sqlite3 /tmp/ecology_interdependence.db < sql/sample_queries.sql

## Notebook

Open `notebooks/ecology_interdependence_workflow.ipynb` in JupyterLab or VS Code.
