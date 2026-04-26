# Population genetics workflow in R.
#
# Simulates a diploid two-allele locus under genotype-specific selection,
# bidirectional mutation, migration, and optional Wright-Fisher drift.

library(dplyr)
library(tidyr)
library(purrr)

scenario_path <- file.path("data", "population_genetics_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "population_genetics_scenarios.csv")
}

simulate_pg <- function(
  generations,
  p0,
  N,
  W_AA,
  W_Aa,
  W_aa,
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
  Wbar <- numeric(generations + 1)

  p[1] <- p0
  q[1] <- 1 - p0
  Hexp[1] <- 2 * p0 * (1 - p0)
  Wbar[1] <- NA_real_

  for (t in 1:generations) {
    pt <- p[t]
    qt <- 1 - pt

    f_AA <- pt^2
    f_Aa <- 2 * pt * qt
    f_aa <- qt^2

    wbar <- f_AA * W_AA + f_Aa * W_Aa + f_aa * W_aa
    p_sel <- (f_AA * W_AA + 0.5 * f_Aa * W_Aa) / wbar

    q_sel <- 1 - p_sel
    p_mut <- p_sel * (1 - mu) + q_sel * nu

    p_mig <- (1 - m) * p_mut + m * p_migrant

    if (drift) {
      count_A <- rbinom(1, size = 2 * N, prob = p_mig)
      p_next <- count_A / (2 * N)
    } else {
      p_next <- p_mig
    }

    p[t + 1] <- p_next
    q[t + 1] <- 1 - p_next
    Hexp[t + 1] <- 2 * p_next * (1 - p_next)
    Wbar[t + 1] <- wbar
  }

  tibble(
    generation = 0:generations,
    p = p,
    q = q,
    expected_heterozygosity = Hexp,
    mean_fitness = Wbar
  )
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    drift_bool = tolower(drift) == "true",
    sim = pmap(
      list(
        generations, p0, N, W_AA, W_Aa, W_aa,
        mu, nu, m, p_migrant, drift_bool, seed
      ),
      function(generations, p0, N, W_AA, W_Aa, W_aa, mu, nu, m, p_migrant, drift_bool, seed) {
        simulate_pg(
          generations = generations,
          p0 = p0,
          N = N,
          W_AA = W_AA,
          W_Aa = W_Aa,
          W_aa = W_aa,
          mu = mu,
          nu = nu,
          m = m,
          p_migrant = p_migrant,
          drift = drift_bool,
          seed = seed
        )
      }
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
