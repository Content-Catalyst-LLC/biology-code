# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy

Run from the article directory:

python python/01_sequence_summary.py
python python/02_kmer_counting.py
python python/03_orf_detection.py
python python/04_translation_scaffold.py
python python/05_fastq_quality_summary.py
python python/06_variant_validation.py
python python/07_metadata_validation.py
python python/08_workflow_manifest.py
python python/09_generate_report.py
python python/run_all.py

Optional:

pip install biopython jupyter

## R

Rscript r/sequence_summary_crosscheck.R
Rscript r/variant_summary_crosscheck.R

## Julia

julia julia/genomics_sequence_kernel.jl

## Fortran

gfortran fortran/genomics_sequence_kernel.f90 -o /tmp/genomics_sequence_kernel
/tmp/genomics_sequence_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/genomics_sequence_helper.go

## C

cc c/genomics_sequence_kernel.c -lm -o /tmp/genomics_sequence_kernel_c
/tmp/genomics_sequence_kernel_c

## C++

c++ -std=c++17 cpp/genomics_sequence_scenario.cpp -o /tmp/genomics_sequence_scenario
/tmp/genomics_sequence_scenario

## SQL

sqlite3 /tmp/genomics_sequence_analysis.db < sql/genomics_sequence_schema.sql
sqlite3 /tmp/genomics_sequence_analysis.db < sql/sample_queries.sql

## Notebook

Open `notebooks/genomics_sequence_analysis_workflow.ipynb` in JupyterLab or VS Code.
