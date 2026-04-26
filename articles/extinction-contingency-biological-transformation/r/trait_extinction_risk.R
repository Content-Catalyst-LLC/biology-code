# Trait-dependent extinction-risk screening in R.

library(dplyr)

trait_path <- file.path("data", "trait_risk_taxa.csv")

if (!file.exists(trait_path)) {
  trait_path <- file.path("..", "data", "trait_risk_taxa.csv")
}

taxa <- read.csv(trait_path) %>%
  mutate(
    risk_index =
      0.4 * (1 - range_size) +
      0.3 * (1 - trophic_flexibility) +
      0.3 * habitat_dependence,
    risk_class = case_when(
      risk_index >= 0.70 ~ "high",
      risk_index >= 0.45 ~ "moderate",
      TRUE ~ "lower"
    )
  ) %>%
  arrange(desc(risk_index))

print(taxa)
