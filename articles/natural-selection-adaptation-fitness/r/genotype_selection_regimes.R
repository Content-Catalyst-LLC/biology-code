# Genotype-based selection regimes in R.

library(dplyr)
library(tidyr)
library(purrr)

scenario_path <- file.path("data", "selection_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "selection_scenarios.csv")
}

simulate_selection <- function(generations, p0, w_AA, w_Aa, w_aa) {
  p <- numeric(generations + 1)
  q <- numeric(generations + 1)
  mean_w <- numeric(generations + 1)
  Hexp <- numeric(generations + 1)

  p[1] <- p0
  q[1] <- 1 - p0
  mean_w[1] <- NA_real_
  Hexp[1] <- 2 * p0 * (1 - p0)

  for (t in 1:generations) {
    pt <- p[t]
    qt <- 1 - pt

    wbar <- pt^2 * w_AA + 2 * pt * qt * w_Aa + qt^2 * w_aa
    p_next <- (pt^2 * w_AA + pt * qt * w_Aa) / wbar

    p[t + 1] <- p_next
    q[t + 1] <- 1 - p_next
    mean_w[t + 1] <- wbar
    Hexp[t + 1] <- 2 * p_next * (1 - p_next)
  }

  tibble(
    generation = 0:generations,
    p = p,
    q = q,
    mean_fitness = mean_w,
    expected_heterozygosity = Hexp
  )
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    sim = pmap(
      list(generations, p0, w_AA, w_Aa, w_aa),
      simulate_selection
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

summary_tbl <- results %>%
  group_by(scenario) %>%
  summarise(
    final_p = last(p),
    final_mean_fitness = last(mean_fitness),
    final_H = last(expected_heterozygosity),
    .groups = "drop"
  )

print(summary_tbl)
