# Migration-selection balance workflow in R.

library(dplyr)
library(tidyr)
library(purrr)

scenario_path <- file.path("data", "migration_selection_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "migration_selection_scenarios.csv")
}

simulate_migration_selection <- function(generations, p1_0, p2_0, m12, m21, s1, s2) {
  p1 <- p1_0
  p2 <- p2_0

  records <- vector("list", generations + 1)

  for (generation in 0:generations) {
    records[[generation + 1]] <- tibble(
      generation = generation,
      p1 = p1,
      p2 = p2,
      delta_p = abs(p1 - p2)
    )

    if (generation == generations) break

    p1_sel <- (p1 * (1 + s1)) / (p1 * (1 + s1) + (1 - p1))
    p2_sel <- (p2 * (1 + s2)) / (p2 * (1 + s2) + (1 - p2))

    p1_next <- (1 - m12) * p1_sel + m12 * p2_sel
    p2_next <- (1 - m21) * p2_sel + m21 * p1_sel

    p1 <- p1_next
    p2 <- p2_next
  }

  bind_rows(records)
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    sim = pmap(
      list(generations, p1_0, p2_0, m12, m21, s1, s2),
      simulate_migration_selection
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

summary_tbl <- results %>%
  group_by(scenario) %>%
  summarise(
    final_p1 = last(p1),
    final_p2 = last(p2),
    final_delta_p = last(delta_p),
    .groups = "drop"
  )

print(summary_tbl)
