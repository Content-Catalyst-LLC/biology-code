# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas

Run:

python python/nonlinear_feedback_core.py
python python/saturating_response.py
python python/hill_thresholds.py
python python/negative_feedback.py
python python/positive_feedback_switch.py
python python/delayed_feedback.py
python python/logistic_regulation.py
python python/predator_prey_feedback.py
python python/bistability_scaffold.py
python python/sensitivity_analysis.py
python python/run_all.py

## R

Run:

Rscript r/saturating_response.R
Rscript r/negative_feedback.R
Rscript r/hill_function.R
Rscript r/positive_feedback_switch.R
Rscript r/delayed_feedback.R
Rscript r/logistic_regulation.R

## Julia

Run:

julia julia/nonlinear_feedback_model.jl

## Fortran

Compile and run:

gfortran fortran/nonlinear_feedback_kernel.f90 -o /tmp/nonlinear_feedback_kernel
/tmp/nonlinear_feedback_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/nonlinear_regulation_helper.go

## C

Compile and run:

cc c/nonlinear_feedback_kernel.c -lm -o /tmp/nonlinear_feedback_kernel_c
/tmp/nonlinear_feedback_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/regulation_scenario_simulation.cpp -o /tmp/regulation_scenario_simulation
/tmp/regulation_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/nonlinear_feedback_biology.db < sql/nonlinear_feedback_schema.sql
sqlite3 /tmp/nonlinear_feedback_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/nonlinear_feedback_biology_workflow.ipynb` in JupyterLab or VS Code.
