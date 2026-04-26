# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas

Run:

python python/math_biology_core.py
python python/population_dynamics.py
python python/predator_prey.py
python python/epidemic_models.py
python python/enzyme_kinetics.py
python python/reaction_diffusion.py
python python/stochastic_birth_death.py
python python/network_analysis.py
python python/sensitivity_analysis.py
python python/optimization_scaffold.py
python python/run_all.py

## R

Run:

Rscript r/logistic_growth.R
Rscript r/predator_prey.R
Rscript r/sir_model.R
Rscript r/stochastic_birth_death.R
Rscript r/sensitivity_summary.R

## Julia

Run:

julia julia/mathematical_biology_model.jl

## Fortran

Compile and run:

gfortran fortran/math_biology_kernel.f90 -o /tmp/math_biology_kernel
/tmp/math_biology_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/math_biology_helper.go

## C

Compile and run:

cc c/math_biology_kernel.c -lm -o /tmp/math_biology_kernel_c
/tmp/math_biology_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/math_biology_scenario_simulation.cpp -o /tmp/math_biology_scenario_simulation
/tmp/math_biology_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/math_biology.db < sql/math_biology_schema.sql
sqlite3 /tmp/math_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/mathematical_biology_workflow.ipynb` in JupyterLab or VS Code.
