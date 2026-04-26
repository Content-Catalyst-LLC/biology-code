# Evolution workflow in R.
#
# Simulates multi-generation allele-frequency change under
# genotype-specific selection, bidirectional mutation, migration, and drift.

library(dplyr)
library(tidyr)
library(purrr)

scenario_path <- file.path("data", "evolutionary_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "evolutionary_scenarios.csv")
}

simulate_evolution <- function(
  generations,
  p0,
  N,
  w_AA,
  w_Aa,
  w_aa,
  mu,
  nu,
  m,
  p_migrant,
  drift,
  seed
) {
  set.seed(seed)

  p <- numeric(generations + 1)
  q <- numeric(generations + 1)
  Hexp <- numeric(generations + 1)
  wbar_vec <- numeric(generations + 1)

  p[1] <- p0
  q[1] <- 1 - p0
  Hexp[1] <- 2 * p0 * (1 - p0)
  wbar_vec[1] <- NA_real_

  for (t in 1:generations) {
    pt <- p[t]
    qt <- 1 - pt

    wbar <- pt^2 * w_AA + 2 * pt * qt * w_Aa + qt^2 * w_aa
    p_sel <- (pt^2 * w_AA + pt * qt * w_Aa) / wbar

    q_sel <- 1 - p_sel
    p_mut <- p_sel * (1 - mu) + q_sel * nu

    p_mig <- (1 - m) * p_mut + m * p_migrant

    if (drift) {
      count_A <- rbinom(1, 2 * N, p_mig)
      p_next <- count_A / (2 * N)
    } else {
      p_next <- p_mig
    }

    p[t + 1] <- p_next
    q[t + 1] <- 1 - p_next
    Hexp[t + 1] <- 2 * p_next * (1 - p_next)
    wbar_vec[t + 1] <- wbar
  }

  tibble(
    generation = 0:generations,
    p = p,
    q = q,
    expected_heterozygosity = Hexp,
    mean_fitness = wbar_vec
  )
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    drift_bool = tolower(drift) == "true",
    sim = pmap(
      list(generations, p0, N, w_AA, w_Aa, w_aa, mu, nu, m, p_migrant, drift_bool, seed),
      simulate_evolution
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

summary_tbl <- results %>%
  group_by(scenario) %>%
  summarise(
    final_p = last(p),
    final_H = last(expected_heterozygosity),
    final_mean_fitness = last(mean_fitness),
    .groups = "drop"
  )

print(summary_tbl)
