# Methodology Notes

## Purpose

This repository demonstrates a reproducible Python-first workflow for biological simulation, bioinformatics sequence summaries, metadata validation, and workflow provenance.

## Logistic Growth

dN/dt = rN(1 - N/K)

where:

- N is population size
- r is intrinsic growth rate
- K is carrying capacity

The basic simulation uses Euler approximation:

N_next = N + dt * rN(1 - N/K)

## Stochastic Population Update

N_next = max(0, N + deterministic_growth + stochastic_noise)

The stochastic example is a teaching scaffold, not a validated ecological forecasting model.

## Sequence Summary

For each sequence:

- length
- valid A/C/G/T base count
- ambiguous-base count
- GC content
- k-mer counts

## Workflow Provenance

Each workflow step records:

- step identifier
- operation
- input artifact
- output artifact
- script
- notes

## Reproducibility

The repository emphasizes:

- deterministic scripts
- documented parameters
- explicit outputs
- checksum records
- validation reports
- SQL provenance
- cross-language checks
