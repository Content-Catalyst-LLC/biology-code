# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas matplotlib

Run from the article directory:

python python/01_validate_parameters.py
python python/02_logistic_growth_model.py
python python/03_two_compartment_model.py
python python/04_parameter_sweep.py
python python/05_sensitivity_summary.py
python python/06_workflow_manifest.py
python python/07_generate_report.py
python python/run_all.py

Optional:

pip install scipy jupyter snakemake

## R

Rscript r/model_summary_crosscheck.R
Rscript r/parameter_validation_crosscheck.R

## Julia

julia julia/biological_modeling_kernel.jl

## Fortran

gfortran fortran/biological_modeling_kernel.f90 -o /tmp/biological_modeling_kernel
/tmp/biological_modeling_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/biological_modeling_helper.go

## C

cc c/biological_modeling_kernel.c -lm -o /tmp/biological_modeling_kernel_c
/tmp/biological_modeling_kernel_c

## C++

c++ -std=c++17 cpp/biological_modeling_scenario.cpp -o /tmp/biological_modeling_scenario
/tmp/biological_modeling_scenario

## SQL

sqlite3 /tmp/python_biological_modeling_automation.db < sql/python_biological_modeling_schema.sql
sqlite3 /tmp/python_biological_modeling_automation.db < sql/sample_queries.sql

## Notebook

Open `notebooks/python_biological_modeling_automation_workflow.ipynb` in JupyterLab or VS Code.
