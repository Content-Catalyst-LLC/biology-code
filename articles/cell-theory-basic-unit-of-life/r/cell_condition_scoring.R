# Cell-condition scoring in R.

condition_path <- file.path("data", "cell_condition_sites.csv")
imaging_path <- file.path("data", "imaging_features.csv")

if (!file.exists(condition_path)) {
  condition_path <- file.path("..", "data", "cell_condition_sites.csv")
  imaging_path <- file.path("..", "data", "imaging_features.csv")
}

condition_class <- function(score) {
  ifelse(
    score >= 0.75,
    "strong_cell_condition",
    ifelse(score >= 0.50, "moderate_cell_condition", "constrained_cell_condition")
  )
}

cells <- read.csv(condition_path)

cells$cell_condition_score <-
  0.18 * cells$membrane_integrity +
  0.22 * cells$metabolic_activity +
  0.18 * cells$proliferation_capacity +
  0.17 * cells$genomic_stability +
  0.15 * cells$organelle_function +
  0.10 * (1 - cells$stress_penalty)

cells$condition_class <- condition_class(cells$cell_condition_score)

cells <- cells[order(-cells$cell_condition_score), ]

print(round(cells, 3))

imaging <- read.csv(imaging_path)

summary_df <- aggregate(
  cbind(area_um2, nuclear_area_um2, mean_intensity, roundness) ~ condition,
  data = imaging,
  FUN = mean
)

print(round(summary_df, 3))
