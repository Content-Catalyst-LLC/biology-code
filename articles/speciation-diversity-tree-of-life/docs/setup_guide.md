# Setup Guide

This directory contains small, reproducible examples for speciation, divergence, phylogenetic distance, and diversification workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/divergence_with_gene_flow.py
python python/sequence_distance_matrix.py
python python/birth_death_diversification.py
python python/speciation_condition_scoring.py

## R

Run:

Rscript r/multilocus_divergence_fst.R
Rscript r/sequence_distance_clustering.R
Rscript r/birth_death_lineage_screening.R

## Julia

Run:

julia julia/speciation_tree_model.jl

## Fortran

Compile and run:

gfortran fortran/speciation_kernel.f90 -o /tmp/speciation_kernel
/tmp/speciation_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/speciation_tree_score.go

## C

Compile and run:

cc c/distance_diversification_kernel.c -lm -o /tmp/distance_diversification_kernel
/tmp/distance_diversification_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/speciation_scenario_simulation.cpp -o /tmp/speciation_scenario_simulation
/tmp/speciation_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/speciation_tree.db < sql/speciation_tree_schema.sql
sqlite3 /tmp/speciation_tree.db < sql/sample_queries.sql

## Notebook

Open `notebooks/speciation_tree_workflow.ipynb` in JupyterLab or VS Code.
