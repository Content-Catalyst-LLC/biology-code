# Setup Guide

## R

The R scripts use mostly base R. Visualization scripts optionally use ggplot2 when available, and mixed/survival examples optionally use lme4 and survival when installed.

Run from the article directory:

Rscript r/01_biostatistics_models.R
Rscript r/02_ecology_diversity_ordination.R
Rscript r/03_genomics_count_workflow.R
Rscript r/04_visualization_suite.R
Rscript r/05_reproducibility_manifest.R
Rscript r/run_all.R

Optional packages:

install.packages(c("ggplot2", "lme4", "survival", "vegan"))

## Python

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/validate_project_data.py
python python/ecology_summary.py
python python/genomics_summary.py
python python/run_all.py

## Julia

julia julia/r_biology_summary_kernel.jl

## Fortran

gfortran fortran/r_biology_statistics_kernel.f90 -o /tmp/r_biology_statistics_kernel
/tmp/r_biology_statistics_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/r_biology_summary_helper.go

## C

cc c/r_biology_statistics_kernel.c -lm -o /tmp/r_biology_statistics_kernel_c
/tmp/r_biology_statistics_kernel_c

## C++

c++ -std=c++17 cpp/r_biology_scenario_simulation.cpp -o /tmp/r_biology_scenario_simulation
/tmp/r_biology_scenario_simulation

## SQL

sqlite3 /tmp/r_biostatistics_ecology_genomics.db < sql/r_biostatistics_ecology_genomics_schema.sql
sqlite3 /tmp/r_biostatistics_ecology_genomics.db < sql/sample_queries.sql

## Notebook

Open `notebooks/r_biostatistics_ecology_genomics_workflow.ipynb` in JupyterLab or VS Code.
