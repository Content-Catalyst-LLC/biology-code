# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run from the article directory:

python python/01_sir_model.py
python python/02_seir_model.py
python python/03_rt_proxy.py
python python/04_branching_process.py
python python/05_reporting_delay_adjustment.py
python python/06_validation_metrics.py
python python/07_workflow_manifest.py
python python/08_generate_report.py
python python/run_all.py

Optional:

pip install scipy networkx jupyter

## R

Rscript r/sir_crosscheck.R
Rscript r/seir_crosscheck.R
Rscript r/validation_metrics_crosscheck.R

## Julia

julia julia/epidemiology_kernel.jl

## Fortran

gfortran fortran/epidemiology_kernel.f90 -o /tmp/epidemiology_kernel
/tmp/epidemiology_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/epidemiology_helper.go

## C

cc c/epidemiology_kernel.c -lm -o /tmp/epidemiology_kernel_c
/tmp/epidemiology_kernel_c

## C++

c++ -std=c++17 cpp/epidemiology_scenario.cpp -o /tmp/epidemiology_scenario
/tmp/epidemiology_scenario

## SQL

sqlite3 /tmp/modeling_disease_epidemiology.db < sql/epidemiology_schema.sql
sqlite3 /tmp/modeling_disease_epidemiology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/modeling_disease_epidemiology_workflow.ipynb` in JupyterLab or VS Code.
