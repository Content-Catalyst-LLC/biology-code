# Setup Guide

This directory contains small, reproducible examples for biomes, habitats, and the geography of life.

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy scikit-learn matplotlib

Run:

python python/habitat_suitability_model.py
python python/spatial_priority_screening.py

## R

Run:

Rscript r/species_area_model.R

## Julia

Run:

julia julia/distance_decay_turnover.jl

## Fortran

Compile and run:

gfortran fortran/species_area_kernel.f90 -o /tmp/species_area_kernel
/tmp/species_area_kernel

## Rust

Compile and run:

cd rust
cargo run
cd ..

## Go

Run:

go run go/biome_indicator_score.go

## C

Compile and run:

cc c/habitat_suitability_kernel.c -o /tmp/habitat_suitability_kernel
/tmp/habitat_suitability_kernel

## C++

Compile and run:

c++ -std=c++17 cpp/habitat_fragmentation_simulation.cpp -o /tmp/habitat_fragmentation_simulation
/tmp/habitat_fragmentation_simulation

## SQL

Use SQLite:

sqlite3 /tmp/biomes_habitats.db < sql/biogeography_schema.sql
sqlite3 /tmp/biomes_habitats.db < sql/sample_queries.sql

## Notebook

Open `notebooks/biomes_habitats_workflow.ipynb` in JupyterLab or VS Code.
