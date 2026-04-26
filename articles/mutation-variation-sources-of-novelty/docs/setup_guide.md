# Setup Guide

This directory contains small, reproducible examples for mutation, variation, novelty, mutation spectra, nucleotide diversity, sequence distance, mutation-selection-drift, and structural variation.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/mutation_supply.py
python python/sequence_distance_matrix.py
python python/nucleotide_diversity.py
python python/mutation_selection_drift.py
python python/structural_variation_summary.py
python python/novelty_condition_scoring.py

## R

Run:

Rscript r/mutation_supply_spectrum.R
Rscript r/multilocus_diversity_differentiation.R
Rscript r/wright_fisher_mutation_selection_drift.R

## Julia

Run:

julia julia/mutation_variation_model.jl

## Fortran

Compile and run:

gfortran fortran/mutation_variation_kernel.f90 -o /tmp/mutation_variation_kernel
/tmp/mutation_variation_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/novelty_condition_score.go

## C

Compile and run:

cc c/mutation_variation_kernel.c -lm -o /tmp/mutation_variation_kernel_c
/tmp/mutation_variation_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/mutation_variation_scenario.cpp -o /tmp/mutation_variation_scenario
/tmp/mutation_variation_scenario

## SQL

Use SQLite:

sqlite3 /tmp/mutation_variation.db < sql/mutation_variation_schema.sql
sqlite3 /tmp/mutation_variation.db < sql/sample_queries.sql

## Notebook

Open `notebooks/mutation_variation_workflow.ipynb` in JupyterLab or VS Code.
