# Setup Guide

This directory contains reproducible examples for biomolecular composition, sequence features, enzyme kinetics, ligand binding, molecular diffusion, polymerization mass balance, biomolecular condition scoring, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/biomolecule_core.py
python python/composition_analysis.py
python python/sequence_features.py
python python/enzyme_kinetics.py
python python/ligand_binding.py
python python/diffusion_transport.py
python python/polymer_mass_balance.py
python python/biomolecular_condition_scoring.py
python python/run_all.py

## R

Run:

Rscript r/composition_analysis.R
Rscript r/enzyme_kinetics.R
Rscript r/ligand_binding.R
Rscript r/sequence_features.R
Rscript r/biomolecular_condition_scoring.R

## Julia

Run:

julia julia/biomolecule_model.jl

## Fortran

Compile and run:

gfortran fortran/biomolecule_kernel.f90 -o /tmp/biomolecule_kernel
/tmp/biomolecule_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/biomolecular_condition_score.go

## C

Compile and run:

cc c/biomolecule_kernel.c -lm -o /tmp/biomolecule_kernel_c
/tmp/biomolecule_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/biomolecular_scenario_simulation.cpp -o /tmp/biomolecular_scenario_simulation
/tmp/biomolecular_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/biomolecules.db < sql/biomolecule_schema.sql
sqlite3 /tmp/biomolecules.db < sql/sample_queries.sql

## Notebook

Open `notebooks/biomolecule_workflow.ipynb` in JupyterLab or VS Code.
