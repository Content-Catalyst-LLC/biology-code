# Methodology Notes

## Purpose

This repository demonstrates reproducible computational scaffolding for evolutionary medicine and biological disease interpretation.

## Core Concepts

The workflow models several concepts:

- antimicrobial resistance under selection
- mismatch between evolved systems and current environments
- life-history allocation trade-offs
- somatic clonal expansion
- defense activation thresholds
- provenance and reproducibility

## Antimicrobial Resistance

The simplified resistant-frequency model is:

resistant_frequency_next =
  resistant_frequency * (1 + selection_advantage - fitness_cost)

The result is bounded between 0 and 1.

## Mismatch

Mismatch distance is represented as:

mismatch_distance =
  abs(current_exposure - adapted_exposure_reference)

Weighted mismatch multiplies the distance by an evidence-confidence value.

## Life-History Allocation

Energy allocation is summarized across growth, reproduction, and maintenance.

## Somatic Evolution

Clonal expansion is modeled as:

clone_size =
  initial_clone_size * exp(growth_rate * time)

## Scientific Caution

These are educational models. They are not clinical, diagnostic, forecasting, or treatment models.
