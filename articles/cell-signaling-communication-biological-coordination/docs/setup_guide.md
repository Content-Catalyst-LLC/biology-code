# Setup Guide

This directory contains small, reproducible examples for receptor occupancy, Hill response curves, signaling decay, pulse-driven dynamics, negative feedback, quorum sensing, and provenance.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run:

python python/receptor_response.py
python python/signaling_decay.py
python python/pulse_feedback_dynamics.py
python python/quorum_sensing_threshold.py
python python/pathway_activation_summary.py
python python/signaling_condition_scoring.py

## R

Run:

Rscript r/receptor_response.R
Rscript r/signaling_decay.R
Rscript r/pulse_feedback_dynamics.R
Rscript r/quorum_sensing_threshold.R
Rscript r/pathway_activation_summary.R

## Julia

Run:

julia julia/signaling_model.jl

## Fortran

Compile and run:

gfortran fortran/signaling_kernel.f90 -o /tmp/signaling_kernel
/tmp/signaling_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/signaling_condition_score.go

## C

Compile and run:

cc c/signaling_kernel.c -lm -o /tmp/signaling_kernel_c
/tmp/signaling_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/signaling_scenario_simulation.cpp -o /tmp/signaling_scenario_simulation
/tmp/signaling_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/signaling.db < sql/signaling_schema.sql
sqlite3 /tmp/signaling.db < sql/sample_queries.sql

## Notebook

Open `notebooks/signaling_workflow.ipynb` in JupyterLab or VS Code.
