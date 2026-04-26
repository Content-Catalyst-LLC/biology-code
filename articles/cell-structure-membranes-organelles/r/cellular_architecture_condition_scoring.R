# Cellular architecture condition scoring in R.

condition_path <- file.path("data", "cellular_architecture_condition_sites.csv")

if (!file.exists(condition_path)) {
  condition_path <- file.path("..", "data", "cellular_architecture_condition_sites.csv")
}

condition_class <- function(score) {
  ifelse(
    score >= 0.72,
    "strong_cellular_architecture",
    ifelse(score >= 0.52, "moderate_cellular_architecture", "constrained_or_high_uncertainty_architecture")
  )
}

sites <- read.csv(condition_path)

sites$cellular_architecture_score <-
  0.17 * sites$membrane_integrity +
  0.15 * sites$transport_capacity +
  0.14 * sites$organelle_specialization +
  0.15 * sites$trafficking_coordination +
  0.15 * sites$energy_compartment_function +
  0.14 * sites$turnover_capacity +
  0.10 * (1 - sites$stress_penalty)

sites$condition_class <- condition_class(sites$cellular_architecture_score)

sites <- sites[order(-sites$cellular_architecture_score), ]

print(round(sites, 3))
