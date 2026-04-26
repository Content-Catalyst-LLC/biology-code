# Metabolic condition scoring in R.

condition_path <- file.path("data", "metabolic_condition_sites.csv")

if (!file.exists(condition_path)) {
  condition_path <- file.path("..", "data", "metabolic_condition_sites.csv")
}

condition_class <- function(score) {
  ifelse(
    score >= 0.72,
    "strong_metabolic_function",
    ifelse(score >= 0.52, "moderate_metabolic_function", "constrained_or_high_uncertainty_metabolism")
  )
}

sites <- read.csv(condition_path)

sites$metabolic_condition_score <-
  0.16 * sites$substrate_availability +
  0.17 * sites$energy_conversion +
  0.15 * sites$redox_balance +
  0.14 * sites$growth_capacity +
  0.14 * sites$maintenance_resilience +
  0.14 * sites$pathway_integration +
  0.10 * (1 - sites$stress_penalty)

sites$condition_class <- condition_class(sites$metabolic_condition_score)

sites <- sites[order(-sites$metabolic_condition_score), ]

print(round(sites, 3))
