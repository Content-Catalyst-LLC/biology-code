# Reproducibility Notes

All datasets are synthetic and educational.

Reproducible life-science machine learning should preserve:

- raw data provenance
- biological units of analysis
- labels and label definitions
- metadata and batch variables
- train-validation-test split logic
- preprocessing steps
- random seeds
- software versions
- model hyperparameters
- model artifacts
- metrics
- reports
- limitations
- intended-use statements

Future extensions could include:

- DVC or Quilt data versioning
- MLflow model tracking
- Snakemake or Nextflow workflows
- pytest validation tests
- containerized execution
- model cards
- datasheets for datasets
- TRIPOD+AI reporting checklists
- subgroup analysis
- drift monitoring
- data leakage tests
- external validation reports
