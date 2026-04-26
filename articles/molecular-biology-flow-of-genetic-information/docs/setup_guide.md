# Setup Guide

This directory contains small, reproducible examples for molecular biology, genetic information flow, transcript kinetics, sequence comparison, codon usage, expression matrices, translation scaffolds, mutation-rate examples, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/transcript_dynamics.py
python python/sequence_comparison.py
python python/expression_matrix_summary.py
python python/codon_usage_translation.py
python python/mutation_rate_example.py
python python/molecular_flow_scoring.py

## R

Run:

Rscript r/transcript_dynamics.R
Rscript r/expression_matrix_summary.R
Rscript r/sequence_and_codon_summary.R

## Julia

Run:

julia julia/molecular_information_flow_model.jl

## Fortran

Compile and run:

gfortran fortran/molecular_flow_kernel.f90 -o /tmp/molecular_flow_kernel
/tmp/molecular_flow_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/molecular_flow_score.go

## C

Compile and run:

cc c/molecular_flow_kernel.c -lm -o /tmp/molecular_flow_kernel_c
/tmp/molecular_flow_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/molecular_flow_scenario_simulation.cpp -o /tmp/molecular_flow_scenario_simulation
/tmp/molecular_flow_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/molecular_flow.db < sql/molecular_flow_schema.sql
sqlite3 /tmp/molecular_flow.db < sql/sample_queries.sql

## Notebook

Open `notebooks/molecular_flow_workflow.ipynb` in JupyterLab or VS Code.
