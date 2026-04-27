# Setup Guide

## Python

Recommended:

python3 -m venv .venv
source .venv/bin/activate
pip install pandas numpy matplotlib

Run from the article directory:

python python/01_generate_synthetic_microscopy.py
python python/02_threshold_segmentation.py
python python/03_object_feature_extraction.py
python python/04_segmentation_validation.py
python python/05_colocalization_summary.py
python python/06_tracking_summary.py
python python/07_workflow_manifest.py
python python/08_generate_report.py
python python/run_all.py

Optional:

pip install scikit-image tifffile imageio napari jupyter

## R

Rscript r/threshold_segmentation_crosscheck.R
Rscript r/object_features_crosscheck.R
Rscript r/colocalization_crosscheck.R

## Julia

julia julia/microscopy_image_analysis_kernel.jl

## Fortran

gfortran fortran/microscopy_image_analysis_kernel.f90 -o /tmp/microscopy_image_analysis_kernel
/tmp/microscopy_image_analysis_kernel

## Rust

cd rust
cargo run
cd ..

## Go

go run go/microscopy_image_analysis_helper.go

## C

cc c/microscopy_image_analysis_kernel.c -lm -o /tmp/microscopy_image_analysis_kernel_c
/tmp/microscopy_image_analysis_kernel_c

## C++

c++ -std=c++17 cpp/microscopy_image_analysis_scenario.cpp -o /tmp/microscopy_image_analysis_scenario
/tmp/microscopy_image_analysis_scenario

## SQL

sqlite3 /tmp/image_analysis_microscopy.db < sql/microscopy_image_analysis_schema.sql
sqlite3 /tmp/image_analysis_microscopy.db < sql/sample_queries.sql

## Notebook

Open `notebooks/image_analysis_microscopy_workflow.ipynb` in JupyterLab or VS Code.
