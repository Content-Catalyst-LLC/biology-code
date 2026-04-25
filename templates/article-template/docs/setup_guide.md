# Setup Guide

## Python

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas scipy matplotlib scikit-learn

## R

install.packages(c("tidyverse", "ggplot2", "deSolve"))

## SQL

sqlite3 data/article.sqlite < sql/schema.sql
