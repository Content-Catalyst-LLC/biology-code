# Setup Guide

Run commands from this article directory:

articles/computational-notebooks-reproducible-biological-research

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib nbformat

Run:

python python/01_validate_sample_metadata.py
python python/02_create_provenance_manifest.py
python python/03_notebook_execution_check.py
python python/04_generate_reproducibility_report.py
python python/run_all.py

## R

Rscript r/biological_summary_table.R
Rscript r/session_info_capture.R

## Julia

julia julia/reproducibility_kernel.jl

## Fortran

gfortran fortran/reproducibility_kernel.f90 -o /tmp/reproducibility_kernel_fortran
/tmp/reproducibility_kernel_fortran

## Rust

cd rust
cargo run
cd ..

## Go

go run go/notebook_manifest_helper.go

## C

cc c/reproducibility_completeness.c -o /tmp/reproducibility_completeness_c
/tmp/reproducibility_completeness_c

## C++

c++ -std=c++17 cpp/notebook_execution_status.cpp -o /tmp/notebook_execution_status_cpp
/tmp/notebook_execution_status_cpp

## SQL

sqlite3 /tmp/computational_notebooks_biology.db < sql/notebook_reproducibility_schema.sql
sqlite3 /tmp/computational_notebooks_biology.db < sql/sample_queries.sql

## Notebook

Open notebooks/computational_notebooks_biological_research_workflow.ipynb in JupyterLab or VS Code.
