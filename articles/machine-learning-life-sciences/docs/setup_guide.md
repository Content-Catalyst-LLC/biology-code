# Setup Guide

Run all commands from the article directory:

articles/machine-learning-life-sciences

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy scikit-learn joblib matplotlib

Run:

python python/01_train_biomarker_classifier.py
python python/02_external_validation.py
python python/03_feature_importance_report.py
python python/04_model_provenance_manifest.py
python python/05_generate_ml_report.py
python python/run_all.py

## R

Rscript r/logistic_biomarker_model.R
Rscript r/validation_metrics_crosscheck.R

## Julia

julia julia/ml_life_sciences_kernel.jl

## Fortran

gfortran fortran/ml_life_sciences_kernel.f90 -o /tmp/ml_life_sciences_fortran
/tmp/ml_life_sciences_fortran

## Rust

cd rust
cargo run
cd ..

## Go

go run go/life_science_batch_summary.go

## C

cc c/ml_life_sciences_sigmoid.c -lm -o /tmp/ml_life_sciences_c
/tmp/ml_life_sciences_c

## C++

c++ -std=c++17 cpp/life_science_confusion_matrix.cpp -o /tmp/ml_life_sciences_cpp
/tmp/ml_life_sciences_cpp

## SQL

sqlite3 /tmp/machine_learning_life_sciences.db < sql/ml_life_sciences_schema.sql
sqlite3 /tmp/machine_learning_life_sciences.db < sql/sample_queries.sql

## Notebook

Open notebooks/machine_learning_life_sciences_workflow.ipynb in JupyterLab or VS Code.
