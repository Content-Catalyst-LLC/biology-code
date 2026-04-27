# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run from the article directory:

python python/01_habitat_suitability.py
python python/02_patch_occupancy.py
python python/03_environmental_stress_scenarios.py
python python/04_runoff_scaffold.py
python python/05_validation_metrics.py
python python/06_workflow_manifest.py
python python/07_generate_report.py
python python/run_all.py

Optional:

pip install geopandas rasterio xarray netcdf4 scikit-learn jupyter

## R

Rscript r/habitat_suitability_crosscheck.R
Rscript r/occupancy_crosscheck.R
Rscript r/validation_metrics_crosscheck.R

## Julia

julia julia/computational_ecology_kernel.jl

## Fortran

gfortran fortran/computational_ecology_kernel.f90 -o /tmp/computational_ecology_kernel
/tmp/computational_ecology_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/computational_ecology_helper.go

## C

cc c/computational_ecology_kernel.c -lm -o /tmp/computational_ecology_kernel_c
/tmp/computational_ecology_kernel_c

## C++

c++ -std=c++17 cpp/computational_ecology_scenario.cpp -o /tmp/computational_ecology_scenario
/tmp/computational_ecology_scenario

## SQL

sqlite3 /tmp/computational_ecology_environmental_modeling.db < sql/computational_ecology_schema.sql
sqlite3 /tmp/computational_ecology_environmental_modeling.db < sql/sample_queries.sql

## Notebook

Open `notebooks/computational_ecology_environmental_modeling_workflow.ipynb` in JupyterLab or VS Code.
