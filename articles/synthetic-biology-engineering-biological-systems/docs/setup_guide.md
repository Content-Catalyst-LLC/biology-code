# Setup Guide

Run commands from this article directory:

articles/synthetic-biology-engineering-biological-systems

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/01_design_build_test_learn.py
python python/02_biosensor_signal_to_noise.py
python python/03_host_burden.py
python python/04_metabolic_yield.py
python python/05_genetic_circuit_dynamics.py
python python/06_provenance_manifest.py
python python/07_generate_synthetic_biology_report.py
python python/run_all.py

## R

Rscript r/host_burden_summary.R
Rscript r/metabolic_yield_table.R
Rscript r/biosensor_signal_to_noise.R

## Julia

julia julia/synthetic_biology_kernel.jl

## Fortran

gfortran fortran/genetic_circuit_kernel.f90 -o /tmp/genetic_circuit_kernel
/tmp/genetic_circuit_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/construct_metadata_summary.go

## C

cc c/biosensor_signal_to_noise.c -lm -o /tmp/biosensor_snr_c
/tmp/biosensor_snr_c

## C++

c++ -std=c++17 cpp/synthetic_design_ranker.cpp -o /tmp/synthetic_design_ranker_cpp
/tmp/synthetic_design_ranker_cpp

## SQL

sqlite3 /tmp/synthetic_biology_engineering.db < sql/synthetic_biology_schema.sql
sqlite3 /tmp/synthetic_biology_engineering.db < sql/sample_queries.sql

## Notebook

Open notebooks/synthetic_biology_engineering_workflow.ipynb in JupyterLab or VS Code.
