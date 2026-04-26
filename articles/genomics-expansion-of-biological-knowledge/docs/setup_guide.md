# Setup Guide

This directory contains small, reproducible examples for genomics, expression matrices, variant summaries, population structure, sequence distance, metagenomic profiles, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/variant_matrix_summary.py
python python/expression_pca.py
python python/sequence_distance_matrix.py
python python/population_structure.py
python python/metagenomic_profile.py
python python/genomic_condition_scoring.py

## R

Run:

Rscript r/expression_matrix_pca.R
Rscript r/population_genomics_structure.R
Rscript r/sequence_distance_clustering.R

## Julia

Run:

julia julia/genomics_model.jl

## Fortran

Compile and run:

gfortran fortran/genomics_kernel.f90 -o /tmp/genomics_kernel
/tmp/genomics_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/genomic_condition_score.go

## C

Compile and run:

cc c/genomics_kernel.c -lm -o /tmp/genomics_kernel_c
/tmp/genomics_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/genomics_scenario_simulation.cpp -o /tmp/genomics_scenario_simulation
/tmp/genomics_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/genomics.db < sql/genomics_schema.sql
sqlite3 /tmp/genomics.db < sql/sample_queries.sql

## Notebook

Open `notebooks/genomics_workflow.ipynb` in JupyterLab or VS Code.
