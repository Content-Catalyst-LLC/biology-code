# Multi-lineage differentiation workflow in R.
#
# Progenitors feed two differentiated lineages with distinct rates.

library(dplyr)
library(tidyr)
library(purrr)

scenario_path <- file.path("data", "lineage_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "lineage_scenarios.csv")
}

simulate_lineage_split <- function(t_end, dt, progenitor0, k1, k2) {
  times <- seq(0, t_end, by = dt)

  P <- numeric(length(times))
  D1 <- numeric(length(times))
  D2 <- numeric(length(times))

  P[1] <- progenitor0
  D1[1] <- 0
  D2[1] <- 0

  for (i in 2:length(times)) {
    dP <- -(k1 + k2) * P[i - 1]
    dD1 <- k1 * P[i - 1]
    dD2 <- k2 * P[i - 1]

    P[i] <- max(P[i - 1] + dP * dt, 0)
    D1[i] <- D1[i - 1] + dD1 * dt
    D2[i] <- D2[i - 1] + dD2 * dt
  }

  tibble(time = times, progenitor = P, lineage_1 = D1, lineage_2 = D2)
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    sim = pmap(
      list(t_end, dt, progenitor0, k1, k2),
      simulate_lineage_split
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

summary_tbl <- results %>%
  group_by(scenario) %>%
  summarise(
    final_progenitor = last(progenitor),
    final_lineage_1 = last(lineage_1),
    final_lineage_2 = last(lineage_2),
    lineage_1_fraction = final_lineage_1 / (final_lineage_1 + final_lineage_2),
    .groups = "drop"
  )

print(summary_tbl)
