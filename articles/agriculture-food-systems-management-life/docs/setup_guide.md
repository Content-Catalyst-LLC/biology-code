# Setup Guide

Run commands from this article directory:

articles/agriculture-food-systems-management-life

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/01_food_system_indicators.py
python python/02_biodiversity_resilience.py
python python/03_soil_carbon_change.py
python python/04_diet_diversity.py
python python/05_food_loss_accounting.py
python python/06_provenance_manifest.py
python python/07_generate_food_system_report.py
python python/run_all.py

## R

Rscript r/soil_organic_carbon_change.R
Rscript r/diet_diversity_access.R
Rscript r/nutrient_use_efficiency.R

## Julia

julia julia/agriculture_food_systems_kernel.jl

## Fortran

gfortran fortran/yield_water_productivity_kernel.f90 -o /tmp/yield_water_productivity_kernel
/tmp/yield_water_productivity_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/food_system_metadata_summary.go

## C

cc c/nutrient_use_efficiency.c -o /tmp/nutrient_use_efficiency_c
/tmp/nutrient_use_efficiency_c

## C++

c++ -std=c++17 cpp/food_system_ranker.cpp -o /tmp/food_system_ranker_cpp
/tmp/food_system_ranker_cpp

## SQL

sqlite3 /tmp/agriculture_food_systems.db < sql/agriculture_food_systems_schema.sql
sqlite3 /tmp/agriculture_food_systems.db < sql/sample_queries.sql

## Notebook

Open notebooks/agriculture_food_systems_workflow.ipynb in JupyterLab or VS Code.
