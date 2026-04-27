# Setup Guide

Run commands from this article directory:

articles/biology-ethics-human-understanding-life

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/01_ethical_review_scores.py
python python/02_consent_completeness.py
python python/03_justice_adjusted_benefit.py
python python/04_ecological_risk.py
python python/05_governance_flags.py
python python/06_provenance_manifest.py
python python/07_generate_biology_ethics_report.py
python python/run_all.py

## R

Rscript r/consent_completeness.R
Rscript r/ecological_risk_reversibility.R
Rscript r/justice_adjusted_benefit.R

## Julia

julia julia/biology_ethics_kernel.jl

## Fortran

gfortran fortran/benefit_harm_kernel.f90 -o /tmp/benefit_harm_kernel
/tmp/benefit_harm_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/governance_metadata_summary.go

## C

cc c/ecological_risk.c -o /tmp/ecological_risk_c
/tmp/ecological_risk_c

## C++

c++ -std=c++17 cpp/biology_ethics_ranker.cpp -o /tmp/biology_ethics_ranker_cpp
/tmp/biology_ethics_ranker_cpp

## SQL

sqlite3 /tmp/biology_ethics.db < sql/biology_ethics_schema.sql
sqlite3 /tmp/biology_ethics.db < sql/sample_queries.sql

## Notebook

Open notebooks/biology_ethics_workflow.ipynb in JupyterLab or VS Code.
