# Setup Guide

This directory contains small, reproducible examples for behavior, communication, and biological strategy workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/behavioral_choice_softmax.py
python python/signaling_strategy_screening.py
python python/hawk_dove_conflict.py

## R

Run:

Rscript r/behavioral_choice_softmax.R

## Julia

Run:

julia julia/behavioral_strategy_model.jl

## Fortran

Compile and run:

gfortran fortran/payoff_choice_kernel.f90 -o /tmp/payoff_choice_kernel
/tmp/payoff_choice_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/behavioral_strategy_score.go

## C

Compile and run:

cc c/payoff_softmax_kernel.c -lm -o /tmp/payoff_softmax_kernel
/tmp/payoff_softmax_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/hawk_dove_simulation.cpp -o /tmp/hawk_dove_simulation
/tmp/hawk_dove_simulation

## SQL

Use SQLite:

sqlite3 /tmp/behavior_strategy.db < sql/behavior_strategy_schema.sql
sqlite3 /tmp/behavior_strategy.db < sql/sample_queries.sql

## Notebook

Open `notebooks/behavior_strategy_workflow.ipynb` in JupyterLab or VS Code.
