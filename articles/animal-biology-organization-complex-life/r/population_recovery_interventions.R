# Population recovery under habitat repair or reduced mortality in R.

library(dplyr)
library(purrr)
library(tidyr)

simulate_logistic <- function(time = 0:50, N0 = 20, r = 0.12, K = 200) {
  tibble(
    time = time,
    N = K / (1 + ((K - N0) / N0) * exp(-r * time))
  )
}

scenario_path <- file.path("data", "population_recovery_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "population_recovery_scenarios.csv")
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    sim = pmap(
      list(N0, r, K),
      ~ simulate_logistic(N0 = ..1, r = ..2, K = ..3)
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

summary_tbl <- results %>%
  group_by(scenario) %>%
  summarise(
    final_population = N[time == max(time)],
    .groups = "drop"
  )

print(summary_tbl)
