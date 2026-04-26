# Setup Guide

This directory contains small, reproducible examples for biosphere and planetary life-support workflows.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run:

python python/functional_integrity_screening.py
python python/biosphere_carbon_balance.py

## R

Run:

Rscript r/monte_carlo_biosphere_carbon.R

## Julia

Run:

julia julia/productivity_disturbance_model.jl

## Fortran

Compile and run:

gfortran fortran/carbon_stock_kernel.f90 -o /tmp/carbon_stock_kernel
/tmp/carbon_stock_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/biosphere_indicator_score.go

## C

Compile and run:

cc c/carbon_balance_kernel.c -o /tmp/carbon_balance_kernel
/tmp/carbon_balance_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/biosphere_disturbance_simulation.cpp -o /tmp/biosphere_disturbance_simulation
/tmp/biosphere_disturbance_simulation

## SQL

Use SQLite:

sqlite3 /tmp/biosphere_life_support.db < sql/biosphere_schema.sql
sqlite3 /tmp/biosphere_life_support.db < sql/sample_queries.sql

## Notebook

Open `notebooks/biosphere_life_support_workflow.ipynb` in JupyterLab or VS Code.
