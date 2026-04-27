# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas

Run:

python python/differential_equations_core.py
python python/logistic_growth.py
python python/predator_prey.py
python python/sir_epidemic.py
python python/homeostasis.py
python python/pharmacokinetics.py
python python/chemostat.py
python python/reaction_diffusion.py
python python/sensitivity_analysis.py
python python/run_all.py

## R

Run:

Rscript r/logistic_growth.R
Rscript r/homeostasis.R
Rscript r/predator_prey.R
Rscript r/sir_epidemic.R
Rscript r/pharmacokinetics.R
Rscript r/chemostat.R

## Julia

Run:

julia julia/differential_equations_biology_model.jl

## Fortran

Compile and run:

gfortran fortran/differential_equations_kernel.f90 -o /tmp/differential_equations_kernel
/tmp/differential_equations_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/dynamic_model_helper.go

## C

Compile and run:

cc c/differential_equations_kernel.c -lm -o /tmp/differential_equations_kernel_c
/tmp/differential_equations_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/biological_dynamics_scenario_simulation.cpp -o /tmp/biological_dynamics_scenario_simulation
/tmp/biological_dynamics_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/differential_equations_biology.db < sql/differential_equations_schema.sql
sqlite3 /tmp/differential_equations_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/differential_equations_biology_workflow.ipynb` in JupyterLab or VS Code.
