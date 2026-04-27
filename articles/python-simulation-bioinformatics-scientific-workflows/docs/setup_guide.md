# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas matplotlib

Run from the article directory:

python python/01_logistic_growth_simulation.py
python python/02_stochastic_population_simulation.py
python python/03_sequence_summary.py
python python/04_kmer_counting.py
python python/05_metadata_validation.py
python python/06_workflow_manifest.py
python python/run_all.py

Optional:

pip install biopython scipy jupyter snakemake

## R

Rscript r/sequence_summary_crosscheck.R
Rscript r/simulation_summary_crosscheck.R

## Julia

julia julia/python_biology_simulation_kernel.jl

## Fortran

gfortran fortran/python_biology_simulation_kernel.f90 -o /tmp/python_biology_simulation_kernel
/tmp/python_biology_simulation_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/python_biology_helper.go

## C

cc c/python_biology_kernel.c -lm -o /tmp/python_biology_kernel_c
/tmp/python_biology_kernel_c

## C++

c++ -std=c++17 cpp/python_biology_scenario_simulation.cpp -o /tmp/python_biology_scenario_simulation
/tmp/python_biology_scenario_simulation

## SQL

sqlite3 /tmp/python_simulation_bioinformatics_workflows.db < sql/python_biology_schema.sql
sqlite3 /tmp/python_simulation_bioinformatics_workflows.db < sql/sample_queries.sql

## Notebook

Open `notebooks/python_simulation_bioinformatics_workflow.ipynb` in JupyterLab or VS Code.
