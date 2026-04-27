# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas

Run:

python python/probability_core.py
python python/binomial_inference.py
python python/bayesian_update.py
python python/bootstrap_uncertainty.py
python python/permutation_test.py
python python/power_simulation.py
python python/likelihood_comparison.py
python python/false_discovery_scaffold.py
python python/stochastic_sampling.py
python python/run_all.py

## R

Run:

Rscript r/binomial_confidence.R
Rscript r/bootstrap_uncertainty.R
Rscript r/permutation_test.R
Rscript r/bayesian_update.R
Rscript r/power_simulation.R

## Julia

Run:

julia julia/probability_inference_model.jl

## Fortran

Compile and run:

gfortran fortran/probability_inference_kernel.f90 -o /tmp/probability_inference_kernel
/tmp/probability_inference_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/probability_helper.go

## C

Compile and run:

cc c/probability_inference_kernel.c -lm -o /tmp/probability_inference_kernel_c
/tmp/probability_inference_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/biological_inference_scenario_simulation.cpp -o /tmp/biological_inference_scenario_simulation
/tmp/biological_inference_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/probability_biology.db < sql/probability_biology_schema.sql
sqlite3 /tmp/probability_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/probability_biological_inference_workflow.ipynb` in JupyterLab or VS Code.
