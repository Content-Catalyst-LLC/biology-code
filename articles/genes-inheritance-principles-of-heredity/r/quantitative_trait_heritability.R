# Simple quantitative-genetics scaffold in R.
#
# Estimates additive and phenotypic variance, h2, and response to selection.

library(dplyr)

qt_path <- file.path("data", "quantitative_trait.csv")

if (!file.exists(qt_path)) {
  qt_path <- file.path("..", "data", "quantitative_trait.csv")
}

trait_df <- read.csv(qt_path)

VA <- var(trait_df$additive_genetic_value)
VP <- var(trait_df$phenotype)
h2 <- VA / VP

selection_threshold <- quantile(trait_df$phenotype, 0.80)
selected <- trait_df$phenotype >= selection_threshold

S <- mean(trait_df$phenotype[selected]) - mean(trait_df$phenotype)
R <- h2 * S

summary_df <- data.frame(
  additive_variance = VA,
  phenotypic_variance = VP,
  h2 = h2,
  selection_differential = S,
  predicted_response = R
)

print(round(summary_df, 4))
