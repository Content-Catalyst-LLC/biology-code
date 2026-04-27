# Run all R workflows.

scripts <- c(
  "r/01_measurement_quality_summary.R",
  "r/02_assay_visualization.R",
  "r/03_ecological_diversity.R",
  "r/04_dose_response_visualization.R",
  "r/05_reproducibility_manifest.R"
)

for (script in scripts) {
  message("\n=== Running ", script, " ===")
  source(script, local = new.env())
}
