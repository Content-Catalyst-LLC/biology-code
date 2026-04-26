# Enzyme and biochemical pathway condition scoring in R.

library(dplyr)

condition_path <- file.path("data", "enzyme_condition_sites.csv")

if (!file.exists(condition_path)) {
  condition_path <- file.path("..", "data", "enzyme_condition_sites.csv")
}

condition_class <- function(score) {
  ifelse(
    score >= 0.72,
    "strong_enzyme_pathway_function",
    ifelse(score >= 0.52, "moderate_enzyme_pathway_function", "constrained_or_high_uncertainty_pathway")
  )
}

sites <- read.csv(condition_path)

sites <- sites %>%
  mutate(
    enzyme_pathway_score =
      0.17 * catalytic_capacity +
      0.14 * substrate_access +
      0.15 * regulatory_control +
      0.14 * cofactor_availability +
      0.16 * pathway_integration +
      0.14 * environmental_stability +
      0.10 * (1 - inhibition_risk),
    condition_class = condition_class(enzyme_pathway_score)
  ) %>%
  arrange(desc(enzyme_pathway_score))

print(round(sites, 3))
