# Material-condition scoring in R.

condition_path <- file.path("data", "material_condition_sites.csv")

if (!file.exists(condition_path)) {
  condition_path <- file.path("..", "data", "material_condition_sites.csv")
}

condition_class <- function(score) {
  ifelse(
    score >= 0.72,
    "strong_material_conditions",
    ifelse(score >= 0.52, "moderate_material_conditions", "constrained_or_high_uncertainty_conditions")
  )
}

sites <- read.csv(condition_path)

sites$material_condition_score <-
  0.17 * sites$water_availability +
  0.15 * sites$osmotic_stability +
  0.17 * sites$energy_availability +
  0.14 * sites$oxygen_support +
  0.13 * sites$thermal_suitability +
  0.14 * sites$ph_stability +
  0.10 * (1 - sites$stress_penalty)

sites$condition_class <- condition_class(sites$material_condition_score)

sites <- sites[order(-sites$material_condition_score), ]

print(round(sites, 3))
