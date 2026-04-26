# Population-genetic simulation in R.
#
# This workflow combines selection, mutation, migration, and optional
# Wright-Fisher drift.

library(dplyr)
library(tidyr)
library(purrr)

scenario_path <- file.path("data", "population_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "population_scenarios.csv")
}

simulate_population <- function(
  generations,
  p0,
  N,
  W_AA,
  W_Aa,
  W_aa,
  mu_A_to_a,
  mu_a_to_A,
  m,
  p_migrant,
  drift,
  seed = 123
) {
  set.seed(seed)

  p <- numeric(generations + 1)
  heterozygosity <- numeric(generations + 1)

  p[1] <- p0
  heterozygosity[1] <- 2 * p0 * (1 - p0)

  for (t in 1:generations) {
    pt <- p[t]
    qt <- 1 - pt

    f_AA <- pt^2
    f_Aa <- 2 * pt * qt
    f_aa <- qt^2

    wbar <- f_AA * W_AA + f_Aa * W_Aa + f_aa * W_aa
    p_sel <- (f_AA * W_AA + 0.5 * f_Aa * W_Aa) / wbar

    p_mut <- p_sel * (1 - mu_A_to_a) + (1 - p_sel) * mu_a_to_A
    p_mig <- (1 - m) * p_mut + m * p_migrant

    if (drift) {
      count_A <- rbinom(1, size = 2 * N, prob = p_mig)
      p_next <- count_A / (2 * N)
    } else {
      p_next <- p_mig
    }

    p[t + 1] <- p_next
    heterozygosity[t + 1] <- 2 * p_next * (1 - p_next)
  }

  tibble(
    generation = 0:generations,
    p = p,
    q = 1 - p,
    heterozygosity = heterozygosity
  )
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    drift_bool = tolower(drift) == "true",
    sim = pmap(
      list(
        generations, p0, N, W_AA, W_Aa, W_aa,
        mu_A_to_a, mu_a_to_A, m, p_migrant, drift_bool
      ),
      function(
        generations, p0, N, W_AA, W_Aa, W_aa,
        mu_A_to_a, mu_a_to_A, m, p_migrant, drift_bool
      ) {
        simulate_population(
          generations = generations,
          p0 = p0,
          N = N,
          W_AA = W_AA,
          W_Aa = W_Aa,
          W_aa = W_aa,
          mu_A_to_a = mu_A_to_a,
          mu_a_to_A = mu_a_to_A,
          m = m,
          p_migrant = p_migrant,
          drift = drift_bool
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
    final_heterozygosity = last(heterozygosity),
    .groups = "drop"
  )

print(summary_tbl)
