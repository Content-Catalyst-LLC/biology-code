# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run from the article directory:

python python/01_network_summary.py
python python/02_signal_propagation.py
python python/03_feedback_dynamics.py
python python/04_pathway_activity.py
python python/05_flux_balance_scaffold.py
python python/06_omics_integration.py
python python/07_validation_metrics.py
python python/08_workflow_manifest.py
python python/09_generate_report.py
python python/run_all.py

Optional:

pip install networkx scipy cobra tellurium libroadrunner jupyter

## R

Rscript r/network_degree_crosscheck.R
Rscript r/pathway_activity_crosscheck.R
Rscript r/feedback_dynamics_crosscheck.R

## Julia

julia julia/systems_biology_kernel.jl

## Fortran

gfortran fortran/systems_biology_kernel.f90 -o /tmp/systems_biology_kernel
/tmp/systems_biology_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/systems_biology_helper.go

## C

cc c/systems_biology_kernel.c -lm -o /tmp/systems_biology_kernel_c
/tmp/systems_biology_kernel_c

## C++

c++ -std=c++17 cpp/systems_biology_scenario.cpp -o /tmp/systems_biology_scenario
/tmp/systems_biology_scenario

## SQL

sqlite3 /tmp/systems_biology_living_networks.db < sql/systems_biology_schema.sql
sqlite3 /tmp/systems_biology_living_networks.db < sql/sample_queries.sql

## Notebook

Open `notebooks/systems_biology_living_networks_workflow.ipynb` in JupyterLab or VS Code.
