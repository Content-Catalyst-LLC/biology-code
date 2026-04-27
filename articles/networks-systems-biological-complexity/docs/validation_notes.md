# Validation Notes

## Input Validation

- Nodes should have unique identifiers.
- Edges should define valid source and target nodes.
- Edge direction should be documented.
- Edge weights should be interpretable and non-negative when required.
- Module assignments should be documented.
- Diffusion parameters should be chosen to avoid numerical explosion.
- Inferred biological edges require empirical validation.

## Numerical Checks

- Density is sensitive to network size.
- Degree centrality does not prove biological importance.
- Correlation networks do not prove direct interaction.
- Clustering metrics can be unstable in sparse networks.
- Module detection can produce mathematically plausible but biologically weak clusters.
- Robustness proxies based only on edge counts are incomplete.
- Dynamic results depend on propagation, decay, initial state, and network topology.

## Reproducibility Checks

- Synthetic datasets are versioned in `data/`.
- SQL schema records provenance and uncertainty.
- Scripts are deterministic.
- Notebook scaffolds reproduce the core calculations.
- Model assumptions are documented in `docs/methodology.md`.

## Limitations

The examples do not include formal community detection optimization, causal network inference, Bayesian network learning, dynamic graph inference, multilayer networks, hypergraphs, temporal networks, uncertainty propagation, or production-grade network medicine workflows.
