# Setup Guide

## R

The R scripts use mostly base R. Visualization scripts optionally use ggplot2 when available.

Run from the article directory:

Rscript r/01_measurement_quality_summary.R
Rscript r/02_assay_visualization.R
Rscript r/03_ecological_diversity.R
Rscript r/04_dose_response_visualization.R
Rscript r/05_reproducibility_manifest.R
Rscript r/run_all.R

Optional R packages:

install.packages(c("ggplot2", "readr", "dplyr", "tidyr"))

## Python

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/validate_biological_data.py
python python/qc_summary.py
python python/metadata_manifest.py
python python/run_all.py

## Julia

julia julia/biological_summary_kernel.jl

## Fortran

gfortran fortran/biological_statistics_kernel.f90 -o /tmp/biological_statistics_kernel
/tmp/biological_statistics_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/biological_summary_helper.go

## C

cc c/biological_statistics_kernel.c -lm -o /tmp/biological_statistics_kernel_c
/tmp/biological_statistics_kernel_c

## C++

c++ -std=c++17 cpp/biological_data_scenario_simulation.cpp -o /tmp/biological_data_scenario_simulation
/tmp/biological_data_scenario_simulation

## SQL

sqlite3 /tmp/r_biology_workflow.db < sql/r_biology_schema.sql
sqlite3 /tmp/r_biology_workflow.db < sql/sample_queries.sql

## Notebook

Open `notebooks/r_biological_data_analysis_workflow.ipynb` in JupyterLab or VS Code.
