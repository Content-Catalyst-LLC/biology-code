# Setup Guide

Run commands from this article directory:

articles/biotechnology-intervention-power-alter-life

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/01_intervention_risk_benefit.py
python python/02_containment_probability.py
python python/03_equity_adjusted_access.py
python python/04_ecological_release_scenarios.py
python python/05_provenance_manifest.py
python python/06_generate_biotechnology_report.py
python python/run_all.py

## R

Rscript r/equity_adjusted_access.R
Rscript r/intervention_scenario_risk.R

## Julia

julia julia/biotechnology_intervention_kernel.jl

## Fortran

gfortran fortran/biotechnology_risk_kernel.f90 -o /tmp/biotechnology_risk_kernel
/tmp/biotechnology_risk_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/biosafety_metadata_summary.go

## C

cc c/containment_probability.c -lm -o /tmp/containment_probability_c
/tmp/containment_probability_c

## C++

c++ -std=c++17 cpp/intervention_ranker.cpp -o /tmp/intervention_ranker_cpp
/tmp/intervention_ranker_cpp

## SQL

sqlite3 /tmp/biotechnology_intervention.db < sql/biotechnology_intervention_schema.sql
sqlite3 /tmp/biotechnology_intervention.db < sql/sample_queries.sql

## Notebook

Open notebooks/biotechnology_intervention_workflow.ipynb in JupyterLab or VS Code.
