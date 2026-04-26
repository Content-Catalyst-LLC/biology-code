# Setup Guide

This directory contains small, reproducible examples for enzyme kinetics, inhibition modeling, catalytic efficiency, assay fitting, feedback-inhibited pathway flux, pathway bottlenecks, enzyme condition scoring, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/michaelis_menten.py
python python/inhibition_models.py
python python/catalytic_efficiency.py
python python/assay_parameter_fit.py
python python/pathway_flux_bottleneck.py
python python/enzyme_condition_scoring.py

## R

Run:

Rscript r/michaelis_menten.R
Rscript r/inhibition_models.R
Rscript r/assay_parameter_fit.R
Rscript r/pathway_flux_feedback.R
Rscript r/enzyme_condition_scoring.R

## Julia

Run:

julia julia/enzyme_pathway_model.jl

## Fortran

Compile and run:

gfortran fortran/enzyme_kernel.f90 -o /tmp/enzyme_kernel
/tmp/enzyme_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/enzyme_condition_score.go

## C

Compile and run:

cc c/enzyme_kernel.c -lm -o /tmp/enzyme_kernel_c
/tmp/enzyme_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/enzyme_pathway_scenario_simulation.cpp -o /tmp/enzyme_pathway_scenario_simulation
/tmp/enzyme_pathway_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/enzyme_pathways.db < sql/enzyme_pathway_schema.sql
sqlite3 /tmp/enzyme_pathways.db < sql/sample_queries.sql

## Notebook

Open `notebooks/enzyme_pathway_workflow.ipynb` in JupyterLab or VS Code.
