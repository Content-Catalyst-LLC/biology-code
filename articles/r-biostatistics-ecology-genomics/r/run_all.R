# Run all R workflows.

scripts <- c(
  "r/01_biostatistics_models.R",
  "r/02_ecology_diversity_ordination.R",
  "r/03_genomics_count_workflow.R",
  "r/04_visualization_suite.R",
  "r/05_reproducibility_manifest.R"
)

for (script in scripts) {
  message("\n=== Running ", script, " ===")
  source(script, local = new.env())
}
