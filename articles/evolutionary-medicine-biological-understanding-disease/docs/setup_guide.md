# Setup Guide

Run commands from this article directory:

articles/evolutionary-medicine-biological-understanding-disease

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/01_antimicrobial_resistance_selection.py
python python/02_mismatch_risk_scores.py
python python/03_life_history_tradeoffs.py
python python/04_somatic_evolution.py
python python/05_defense_thresholds.py
python python/06_provenance_manifest.py
python python/07_generate_evolutionary_medicine_report.py
python python/run_all.py

## R

Rscript r/life_history_allocation.R
Rscript r/somatic_evolution_scenario.R
Rscript r/mismatch_risk_crosscheck.R

## Julia

julia julia/evolutionary_medicine_kernel.jl

## Fortran

gfortran fortran/resistance_selection_kernel.f90 -o /tmp/resistance_selection_kernel
/tmp/resistance_selection_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/disease_scenario_summary.go

## C

cc c/selection_frequency.c -lm -o /tmp/selection_frequency_c
/tmp/selection_frequency_c

## C++

c++ -std=c++17 cpp/evolutionary_scenario_ranker.cpp -o /tmp/evolutionary_scenario_ranker_cpp
/tmp/evolutionary_scenario_ranker_cpp

## SQL

sqlite3 /tmp/evolutionary_medicine.db < sql/evolutionary_medicine_schema.sql
sqlite3 /tmp/evolutionary_medicine.db < sql/sample_queries.sql

## Notebook

Open notebooks/evolutionary_medicine_workflow.ipynb in JupyterLab or VS Code.
