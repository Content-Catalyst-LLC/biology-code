# Light-response and drought-sensitivity screening in R.

library(dplyr)
library(tidyr)
library(purrr)

light_response <- function(I, alpha = 0.05, Amax = 18, Rd = 1.5) {
  (alpha * I * Amax) / (alpha * I + Amax) - Rd
}

scenario_path <- file.path("data", "light_response_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "light_response_scenarios.csv")
}

scenarios <- read.csv(scenario_path)
irradiance <- seq(0, 2000, by = 25)

results <- scenarios %>%
  mutate(
    sim = pmap(
      list(scenario, alpha, Amax, Rd),
      function(scenario, alpha, Amax, Rd) {
        tibble(
          scenario = scenario,
          irradiance = irradiance,
          assimilation = light_response(irradiance, alpha, Amax, Rd)
        )
      }
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

summary_tbl <- results %>%
  group_by(scenario) %>%
  summarise(
    max_assimilation = max(assimilation),
    assimilation_at_1000 = assimilation[irradiance == 1000],
    .groups = "drop"
  )

print(summary_tbl)
