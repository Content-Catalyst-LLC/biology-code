# Methodology Notes

## Purpose

This repository demonstrates a reproducible R-first workflow for biological data analysis and visualization.

## Measurement Summary

For a group of biological measurements:

mean = sum(x) / n

sample_sd = sqrt(sum((x - mean)^2) / (n - 1))

standard_error = sample_sd / sqrt(n)

coefficient_of_variation = sample_sd / mean

## Ecological Diversity

Richness counts the number of taxa with nonzero abundance.

Shannon diversity is:

H = -sum(p_i * log(p_i))

where p_i is the proportional abundance of species i.

## Dose Response

The dose-response workflow is descriptive and visual. It is not a validated pharmacological model.

## Visualization

The plotting workflow prioritizes:

- individual observations
- clearly labeled groups
- uncertainty where appropriate
- reproducible figure generation
- no manual figure editing

## Reproducibility

Each workflow should document:

- inputs
- outputs
- code file
- data source
- assumptions
- QC criteria
- generated artifacts
- software session information where possible
