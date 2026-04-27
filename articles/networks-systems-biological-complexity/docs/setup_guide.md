# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas

Run:

python python/network_complexity_core.py
python python/adjacency_matrix.py
python python/degree_centrality.py
python python/module_summary.py
python python/network_diffusion.py
python python/robustness_simulation.py
python python/gene_regulatory_network.py
python python/food_web_summary.py
python python/microbiome_association_scaffold.py
python python/run_all.py

## R

Run:

Rscript r/edge_list_summary.R
Rscript r/robustness_proxy.R
Rscript r/module_summary.R
Rscript r/network_diffusion.R
Rscript r/food_web_summary.R
Rscript r/degree_centrality.R

## Julia

Run:

julia julia/network_complexity_model.jl

## Fortran

Compile and run:

gfortran fortran/network_complexity_kernel.f90 -o /tmp/network_complexity_kernel
/tmp/network_complexity_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/network_helper.go

## C

Compile and run:

cc c/network_complexity_kernel.c -lm -o /tmp/network_complexity_kernel_c
/tmp/network_complexity_kernel_c

## C++

Compile and run:

c++ -std=c++17 cpp/network_scenario_simulation.cpp -o /tmp/network_scenario_simulation
/tmp/network_scenario_simulation

## SQL

Use SQLite:

sqlite3 /tmp/network_complexity_biology.db < sql/network_complexity_schema.sql
sqlite3 /tmp/network_complexity_biology.db < sql/sample_queries.sql

## Notebook

Open `notebooks/network_complexity_biology_workflow.ipynb` in JupyterLab or VS Code.
