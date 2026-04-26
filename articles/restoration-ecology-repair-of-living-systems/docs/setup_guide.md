# Setup Guide

## Python

From the repository root:

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas matplotlib
python articles/restoration-ecology-repair-of-living-systems/python/restoration_scenario_screening.py
python articles/restoration-ecology-repair-of-living-systems/python/monitoring_summary.py

## R

From the repository root:

Rscript articles/restoration-ecology-repair-of-living-systems/r/coupled_restoration_model.R
Rscript articles/restoration-ecology-repair-of-living-systems/r/restoration_scenario_screening.R

Required R packages:

install.packages(c("tidyverse"))

## Julia

julia articles/restoration-ecology-repair-of-living-systems/julia/restoration_model.jl

## Fortran

gfortran articles/restoration-ecology-repair-of-living-systems/fortran/restoration_recovery_table.f90 -o restoration_recovery_table
./restoration_recovery_table

## Rust

rustc articles/restoration-ecology-repair-of-living-systems/rust/restoration_cli.rs -o restoration_cli
./restoration_cli

## Go

go run articles/restoration-ecology-repair-of-living-systems/go/restoration_cli.go

## C

gcc articles/restoration-ecology-repair-of-living-systems/c/restoration_recovery.c -o restoration_recovery_c -lm
./restoration_recovery_c

## C++

g++ -std=c++17 articles/restoration-ecology-repair-of-living-systems/cpp/restoration_parameter_sweep.cpp -o restoration_parameter_sweep
./restoration_parameter_sweep

## SQL

sqlite3 articles/restoration-ecology-repair-of-living-systems/data/restoration_ecology.sqlite < articles/restoration-ecology-repair-of-living-systems/sql/restoration_schema.sql
