# Setup Guide

This directory contains small, reproducible examples for DNA-RNA biology, transcript kinetics, sequence comparison, codon usage, expression matrices, translation scaffolds, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/sequence_comparison.py
python python/transcript_kinetics.py
python python/expression_matrix_pca.py
python python/codon_usage_translation.py
python python/molecular_condition_scoring.py

## R

Run:

Rscript r/transcript_kinetics.R
Rscript r/expression_matrix_pca.R
Rscript r/codon_usage_gc_content.R

## Julia

Run:

julia julia/dna_rna_model.jl

## Fortran

Compile and run:

gfortran fortran/dna_rna_kernel.f90 -o /tmp/dna_rna_kernel
/tmp/dna_rna_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/molecular_condition_score.go

## C

Compile and run:

cc c/dna_rna_kernel.c -lm -o /tmp/dna_rna_kernel_c
/tmp/dna_rna_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/molecular_scenario_simulation.cpp -o /tmp/molecular_scenario_simulation
/tmp/molecular_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/dna_rna.db < sql/dna_rna_schema.sql
sqlite3 /tmp/dna_rna.db < sql/sample_queries.sql

## Notebook

Open `notebooks/dna_rna_workflow.ipynb` in JupyterLab or VS Code.
