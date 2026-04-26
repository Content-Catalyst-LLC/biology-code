# Reproducibility Notes

## Inputs

The main input tables are:

- data/restoration_scenarios.csv
- data/restoration_parameters.csv
- data/monitoring_indicators.csv
- data/source_metadata.csv

## Outputs

Generated outputs include:

- computed restoration scenario summaries
- coupled recovery trajectories
- monitoring indicator summaries
- recovery classifications
- SQL provenance tables

## Reproducibility Checklist

- Model assumptions are documented in docs/methodology.md.
- Scenario parameters are stored in CSV files.
- SQL schema preserves intervention, monitoring, indicator, scenario, and source metadata.
- Scripts can be run independently.
- No external data download is required for baseline workflows.
- Randomness is avoided in the core deterministic examples.
