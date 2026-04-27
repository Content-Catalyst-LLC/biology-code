# Reproducibility Notes

All datasets are synthetic and educational.

Reproducible biological notebooks should preserve:

- project root
- relative file paths
- raw and processed data distinctions
- sample identifiers
- data dictionaries
- provenance records
- checksums
- package versions
- random seeds
- execution order
- notebook kernel information
- output artifact locations
- limitations and intended use

Future extensions could include:

- nbval testing
- Papermill execution
- Quarto rendering
- Binder configuration
- Dockerfile or Apptainer recipe
- renv.lock for R workflows
- environment.yml for Python workflows
- GitHub Actions notebook execution
- Zenodo archival metadata
- RO-Crate workflow packaging
- Nextflow or Snakemake integration
