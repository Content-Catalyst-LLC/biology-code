# Plant condition and restoration recovery screening in R.

library(dplyr)

sites_path <- file.path("data", "plant_condition_sites.csv")

if (!file.exists(sites_path)) {
  sites_path <- file.path("..", "data", "plant_condition_sites.csv")
}

sites <- read.csv(sites_path) %>%
  mutate(
    plant_condition_score =
      0.20 * canopy_condition +
      0.18 * water_availability +
      0.16 * nutrient_status +
      0.16 * soil_function +
      0.15 * regeneration_support +
      0.08 * (1 - disease_pressure) +
      0.07 * (1 - drought_stress),
    condition_class = case_when(
      plant_condition_score >= 0.72 ~ "strong",
      plant_condition_score >= 0.55 ~ "moderate",
      TRUE ~ "high-concern"
    )
  ) %>%
  arrange(desc(plant_condition_score))

print(sites)
