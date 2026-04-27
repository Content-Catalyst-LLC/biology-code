# Methodology Notes

## Purpose

The computational examples formalize statistics, uncertainty, and measurement in biology through workflows for descriptive uncertainty, calibration, measurement error, uncertainty budgets, variance components, bootstrap intervals, assay quality control, and error propagation.

## Sample Mean

mean = sum(x_i) / n

## Sample Standard Deviation

s = sqrt(sum((x_i - mean)^2) / (n - 1))

## Standard Error

SE = s / sqrt(n)

## Combined Standard Uncertainty

u_c = sqrt(sum(u_i^2))

## Expanded Uncertainty

U = k u_c

where k is a coverage factor.

## Linear Calibration

response = intercept + slope * concentration + error

## Measurement Error Model

measured = true_value + bias + random_error

## Variance Components

measurement = grand_mean + biological_unit_effect + technical_error

## Error Propagation

For z = f(x, y), approximate uncertainty is based on partial derivatives of f with respect to x and y.

## Interpretation

These workflows are educational and methodological scaffolds. They do not replace domain-specific calibration, metrology review, regulatory validation, or expert biological interpretation.
