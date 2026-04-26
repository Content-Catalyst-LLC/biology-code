# Reproducibility Notes

## Data

All example datasets in `data/` are synthetic and small. They demonstrate structure rather than represent real neural recordings.

## Provenance

The SQL schema includes fields for:

- neural units
- input pulses
- network weights
- response scenarios
- model outputs
- data source
- analytical method
- license
- uncertainty notes

This supports transparent neurobiology workflows where results can be traced back to data sources and modeling assumptions.

## Randomness

The included examples are deterministic. Future stochastic extensions should set random seeds and record parameter settings.

## Limitations

The examples do not include:

- Hodgkin-Huxley ion-channel dynamics
- spike trains from empirical electrophysiology
- compartmental neuron morphology
- synaptic plasticity calibration
- calcium imaging workflows
- EEG or LFP signal processing
- fMRI or connectomic pipelines
- Bayesian parameter estimation
- sensory stimulus calibration
- clinical inference

Those extensions can be added as the repository grows.
