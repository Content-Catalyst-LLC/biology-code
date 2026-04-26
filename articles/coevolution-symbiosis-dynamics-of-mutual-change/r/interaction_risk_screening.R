# Interaction dependency-risk screening in R.

library(dplyr)

network_path <- file.path("data", "network_interactions.csv")

if (!file.exists(network_path)) {
  network_path <- file.path("..", "data", "network_interactions.csv")
}

interactions <- read.csv(network_path)

dependency <- interactions %>%
  mutate(weighted_support = weight * partner_reliability) %>%
  group_by(focal) %>%
  summarise(
    dependency_support = sum(weighted_support),
    partner_count = n(),
    mean_partner_reliability = mean(partner_reliability),
    .groups = "drop"
  ) %>%
  mutate(
    risk_class = case_when(
      dependency_support < 0.45 ~ "high_risk",
      dependency_support < 0.65 ~ "moderate_risk",
      TRUE ~ "lower_risk"
    )
  )

print(dependency)
