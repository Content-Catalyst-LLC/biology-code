# Oxygen limitation workflow in R.

oxygen_path <- file.path("data", "oxygen_scenarios.csv")

if (!file.exists(oxygen_path)) {
  oxygen_path <- file.path("..", "data", "oxygen_scenarios.csv")
}

oxygen <- read.csv(oxygen_path)

oxygen$relative_energy_rate <-
  oxygen$max_relative_energy_rate *
  oxygen$oxygen_mg_L /
  (oxygen$half_saturation_mg_L + oxygen$oxygen_mg_L)

oxygen$oxygen_limitation <- 1 - oxygen$relative_energy_rate

print(round(oxygen, 5))
