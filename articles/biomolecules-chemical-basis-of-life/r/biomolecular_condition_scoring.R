# Biomolecular condition scoring in R.

condition_path <- file.path("data", "biomolecular_condition_sites.csv")

if (!file.exists(condition_path)) {
  condition_path <- file.path("..", "data", "biomolecular_condition_sites.csv")
}

condition_class <- function(score) {
  ifelse(
    score >= 0.72,
    "strong_biomolecular_function",
    ifelse(score >= 0.52, "moderate_biomolecular_function", "constrained_or_high_uncertainty_biomolecular_state")
  )
}

sites <- read.csv(condition_path)

sites$biomolecular_condition_score <-
  0.14 * sites$carbohydrate_support +
  0.15 * sites$lipid_boundary_function +
  0.18 * sites$protein_function +
  0.17 * sites$nucleic_acid_integrity +
  0.14 * sites$metabolite_balance +
  0.12 * sites$cofactor_availability +
  0.10 * (1 - sites$stress_penalty)

sites$condition_class <- condition_class(sites$biomolecular_condition_score)

sites <- sites[order(-sites$biomolecular_condition_score), ]

print(round(sites, 3))
