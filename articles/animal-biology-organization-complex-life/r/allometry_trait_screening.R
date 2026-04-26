# Allometry, comparative physiology, and trait screening in R.

library(dplyr)

traits_path <- file.path("data", "species_traits.csv")

if (!file.exists(traits_path)) {
  traits_path <- file.path("..", "data", "species_traits.csv")
}

animals <- read.csv(traits_path)

B0 <- 4.2

animals <- animals %>%
  mutate(
    metabolic_rate = B0 * body_mass_kg^(0.75),
    mass_specific_rate = metabolic_rate / body_mass_kg,
    energetic_stress_index =
      as.numeric(scale(mass_specific_rate)) + exposure_risk
  )

print(animals %>%
  select(
    species,
    body_mass_kg,
    habitat,
    metabolic_rate,
    mass_specific_rate,
    energetic_stress_index
  ))
