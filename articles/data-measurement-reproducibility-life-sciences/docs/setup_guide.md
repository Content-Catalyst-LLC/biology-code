# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas

Run:

python python/reproducibility_core.py
python python/measurement_quality_summary.py
python python/schema_validation.py
python python/uncertainty_budget.py
python python/provenance_manifest.py
python python/checksum_manifest.py
python python/qc_flag_summary.py
python python/reproducibility_report.py
python python/workflow_audit.py
python python/run_all.py

## R

Run:

Rscript r/measurement_quality_summary.R
Rscript r/qc_summary.R
Rscript r/metadata_manifest.R
Rscript r/uncertainty_budget.R
Rscript r/reproducibility_summary.R

## Julia

Run:

julia julia/reproducibility_measurement_model.jl

## Fortran

Compile and run:

gfortran fortran/measurement_uncertainty_kernel.f90 -o /tmp/measurement_uncertainty_kernel
/tmp/measurement_uncertainty_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/reproducibility_helper.go

## C

Compile and run:

cc c/measurement_quality_kernel.c -lm -o /tmp/measurement_quality_kernel_c
/tmp/measurement_quality_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/data_quality_scenario_simulation.cpp -o /tmp/data_quality_scenario_simulation
/tmp/data_quality_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/life_science_reproducibility.db < sql/reproducibility_schema.sql
sqlite3 /tmp/life_science_reproducibility.db < sql/sample_queries.sql

## Notebook

Open `notebooks/data_measurement_reproducibility_workflow.ipynb` in JupyterLab or VS Code.
