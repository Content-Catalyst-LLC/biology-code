# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/taxonomy_core.py
python python/sequence_distance.py
python python/biodiversity_indices.py
python python/occurrence_summary.py
python python/taxonomic_confidence.py
python python/run_all.py

## R

Run:

Rscript r/sequence_distance.R
Rscript r/biodiversity_indices.R
Rscript r/taxonomic_confidence.R

## Julia

Run:

julia julia/taxonomy_model.jl

## Fortran

Compile and run:

gfortran fortran/taxonomy_kernel.f90 -o /tmp/taxonomy_kernel
/tmp/taxonomy_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/taxonomic_confidence_score.go

## C

Compile and run:

cc c/taxonomy_kernel.c -lm -o /tmp/taxonomy_kernel_c
/tmp/taxonomy_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/taxonomic_assignment_simulation.cpp -o /tmp/taxonomic_assignment_simulation
/tmp/taxonomic_assignment_simulation

## SQL

Use SQLite:

sqlite3 /tmp/taxonomy.db < sql/taxonomy_schema.sql
sqlite3 /tmp/taxonomy.db < sql/sample_queries.sql

## Notebook

Open `notebooks/taxonomy_workflow.ipynb` in JupyterLab or VS Code.
