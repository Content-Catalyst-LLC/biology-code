# Setup Guide

This directory contains small, reproducible examples for population, community, and ecosystem dynamics workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy scipy scikit-learn matplotlib

Run:

python python/community_turnover_risk.py
python python/trophic_interaction_screening.py

## R

Run:

Rscript r/coupled_ecology_simulation.R

## Julia

Run:

julia julia/trophic_disturbance_model.jl

## Fortran

Compile and run:

gfortran fortran/logistic_predator_prey_kernel.f90 -o /tmp/logistic_predator_prey_kernel
/tmp/logistic_predator_prey_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/ecosystem_reorganization_score.go

## C

Compile and run:

cc c/logistic_biomass_kernel.c -lm -o /tmp/logistic_biomass_kernel
/tmp/logistic_biomass_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/coupled_ecology_simulation.cpp -o /tmp/coupled_ecology_simulation
/tmp/coupled_ecology_simulation

## SQL

Use SQLite:

sqlite3 /tmp/populations_communities_ecosystems.db < sql/ecology_schema.sql
sqlite3 /tmp/populations_communities_ecosystems.db < sql/sample_queries.sql

## Notebook

Open `notebooks/populations_communities_ecosystems_workflow.ipynb` in JupyterLab or VS Code.
