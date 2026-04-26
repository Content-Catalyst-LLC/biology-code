# Taxonomic-confidence scoring in R.

assign_path <- file.path("data", "taxonomic_assignments.csv")
if (!file.exists(assign_path)) {
  assign_path <- file.path("..", "data", "taxonomic_assignments.csv")
}

assignments <- read.csv(assign_path)

assignments$taxonomic_confidence_score <-
  0.30 * assignments$sequence_similarity +
  0.20 * assignments$morphological_support +
  0.15 * assignments$geographic_plausibility +
  0.25 * assignments$phylogenetic_support -
  0.10 * assignments$uncertainty_penalty

assignments$confidence_class <- ifelse(
  assignments$taxonomic_confidence_score >= 0.75,
  "high_confidence",
  ifelse(assignments$taxonomic_confidence_score >= 0.55, "moderate_confidence", "low_confidence")
)

assignments <- assignments[order(-assignments$taxonomic_confidence_score), ]

print(round(assignments, 3))
