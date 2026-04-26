# Setup Guide

This directory contains small, reproducible examples for heredity, Mendelian ratios, genotype frequencies, allele frequencies, chi-square tests, linkage, recombination, quantitative genetics, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/genotype_expectations.py
python python/chi_square_inheritance.py
python python/inheritance_simulation.py
python python/allele_frequency_summary.py
python python/recombination_linkage.py
python python/quantitative_trait_heritability.py
python python/heredity_condition_scoring.py

## R

Run:

Rscript r/genotype_expectations.R
Rscript r/chi_square_inheritance.R
Rscript r/inheritance_simulation.R
Rscript r/linkage_recombination.R
Rscript r/quantitative_trait_heritability.R

## Julia

Run:

julia julia/heredity_model.jl

## Fortran

Compile and run:

gfortran fortran/heredity_kernel.f90 -o /tmp/heredity_kernel
/tmp/heredity_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/heredity_condition_score.go

## C

Compile and run:

cc c/heredity_kernel.c -lm -o /tmp/heredity_kernel_c
/tmp/heredity_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/heredity_scenario_simulation.cpp -o /tmp/heredity_scenario_simulation
/tmp/heredity_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/heredity.db < sql/heredity_schema.sql
sqlite3 /tmp/heredity.db < sql/sample_queries.sql

## Notebook

Open `notebooks/heredity_workflow.ipynb` in JupyterLab or VS Code.
