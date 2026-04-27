# Reproducibility summary workflow.

measurement_path <- file.path("data", "measurements.csv")
artifact_path <- file.path("data", "artifact_manifest.csv")
provenance_path <- file.path("data", "provenance_steps.csv")

if (!file.exists(measurement_path)) {
  measurement_path <- file.path("..", "data", "measurements.csv")
  artifact_path <- file.path("..", "data", "artifact_manifest.csv")
  provenance_path <- file.path("..", "data", "provenance_steps.csv")
}

measurements <- read.csv(measurement_path)
artifacts <- read.csv(artifact_path)
provenance <- read.csv(provenance_path)

values <- suppressWarnings(as.numeric(measurements$measurement_value))

summary_df <- data.frame(
  n_measurements = nrow(measurements),
  n_artifacts = nrow(artifacts),
  n_provenance_steps = nrow(provenance),
  completeness_rate = 1 - sum(is.na(values)) / nrow(measurements),
  qc_pass_rate = sum(measurements$qc_flag == "pass") / nrow(measurements)
)

print(round(summary_df, 5))
