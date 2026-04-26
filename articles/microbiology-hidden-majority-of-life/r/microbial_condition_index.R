# Microbial condition index for applied ecological screening.

library(dplyr)

sites_path <- file.path("data", "microbial_condition_sites.csv")

if (!file.exists(sites_path)) {
  sites_path <- file.path("..", "data", "microbial_condition_sites.csv")
}

sites <- read.csv(sites_path)

sites <- sites %>%
  mutate(
    microbial_condition_index =
      0.30 * functional_richness +
      0.20 * nitrification_potential +
      0.20 * denitrification_balance +
      0.15 * (1 - pathogen_signal) +
      0.15 * (1 - organic_overload)
  ) %>%
  arrange(desc(microbial_condition_index))

print(sites)
