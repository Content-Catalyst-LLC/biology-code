# Hazard and post-crisis recovery screening in R.

library(dplyr)
library(tidyr)
library(purrr)

hazard_path <- file.path("data", "hazard_scenarios.csv")

if (!file.exists(hazard_path)) {
  hazard_path <- file.path("..", "data", "hazard_scenarios.csv")
}

hazards <- read.csv(hazard_path)

survival_results <- hazards %>%
  mutate(
    sim = pmap(
      list(scenario, lambda, time_horizon),
      function(scenario, lambda, time_horizon) {
        time <- seq(0, time_horizon, by = 0.1)

        tibble(
          scenario = scenario,
          time = time,
          survivorship = exp(-lambda * time)
        )
      }
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

survival_summary <- survival_results %>%
  group_by(scenario) %>%
  summarise(
    survivorship_end = survivorship[time == max(time)],
    .groups = "drop"
  )

print(survival_summary)

recovery_path <- file.path("data", "recovery_scenarios.csv")

if (!file.exists(recovery_path)) {
  recovery_path <- file.path("..", "data", "recovery_scenarios.csv")
}

recovery_scenarios <- read.csv(recovery_path)

recovery <- recovery_scenarios %>%
  mutate(
    sim = pmap(
      list(scenario, N0, r, K, time_horizon),
      function(scenario, N0, r, K, time_horizon) {
        time <- seq(0, time_horizon, by = 0.5)

        tibble(
          scenario = scenario,
          time = time,
          richness = K / (1 + ((K - N0) / N0) * exp(-r * time))
        )
      }
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

recovery_summary <- recovery %>%
  group_by(scenario) %>%
  summarise(
    final_richness = richness[time == max(time)],
    .groups = "drop"
  )

print(recovery_summary)
