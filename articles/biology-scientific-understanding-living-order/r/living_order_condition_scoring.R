# Living-order condition scoring in R.

condition_path <- file.path("data", "living_order_condition_sites.csv")

if (!file.exists(condition_path)) {
  condition_path <- file.path("..", "data", "living_order_condition_sites.csv")
}

condition_class <- function(score) {
  ifelse(
    score >= 0.72,
    "strong_living_order",
    ifelse(score >= 0.52, "moderate_living_order", "constrained_or_high_uncertainty_living_order")
  )
}

sites <- read.csv(condition_path)

sites$living_order_score <-
  0.17 * sites$homeostatic_regulation +
  0.16 * sites$metabolic_throughput +
  0.15 * sites$structural_integration +
  0.13 * sites$developmental_coordination +
  0.15 * sites$information_continuity +
  0.14 * sites$ecological_relation +
  0.10 * (1 - sites$stress_penalty)

sites$condition_class <- condition_class(sites$living_order_score)

sites <- sites[order(-sites$living_order_score), ]

print(round(sites, 3))
