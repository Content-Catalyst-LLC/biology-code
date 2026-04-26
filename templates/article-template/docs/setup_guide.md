# Setup Guide

## Python

python3 -m venv .venv
source .venv/bin/activate
pip install numpy pandas scipy matplotlib scikit-learn

## R

install.packages(c("tidyverse", "ggplot2", "deSolve"))

## Julia

julia articles/ARTICLE_SLUG/julia/example.jl

## Fortran

gfortran articles/ARTICLE_SLUG/fortran/example.f90 -o example_fortran
./example_fortran

## Rust

rustc articles/ARTICLE_SLUG/rust/example.rs -o example_rust
./example_rust

## Go

go run articles/ARTICLE_SLUG/go/example.go

## C

gcc articles/ARTICLE_SLUG/c/example.c -o example_c -lm
./example_c

## C++

g++ -std=c++17 articles/ARTICLE_SLUG/cpp/example.cpp -o example_cpp
./example_cpp

## SQL

sqlite3 articles/ARTICLE_SLUG/data/article.sqlite < articles/ARTICLE_SLUG/sql/schema.sql
