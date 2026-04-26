# Birth-death diversification and lineage-through-time screening in R.

library(dplyr)
library(purrr)
library(tidyr)

scenario_path <- file.path("data", "birth_death_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "birth_death_scenarios.csv")
}

simulate_birth_death <- function(
  time_steps,
  N0,
  lambda_rate,
  mu_rate,
  n_iter,
  seed
) {
  set.seed(seed)

  finals <- numeric(n_iter)
  peaks <- numeric(n_iter)

  for (i in seq_len(n_iter)) {
    N <- N0
    peak <- N

    for (t in seq_len(time_steps)) {
      births <- rpois(1, lambda = lambda_rate * N)
      deaths <- rpois(1, lambda = mu_rate * N)
      N <- max(N + births - deaths, 0)
      peak <- max(peak, N)

      if (N == 0) break
    }

    finals[i] <- N
    peaks[i] <- peak
  }

  tibble(
    final_richness = finals,
    peak_richness = peaks
  )
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    seed = row_number() + 100,
    sim = pmap(
      list(time_steps, N0, lambda_rate, mu_rate, n_iter, seed),
      function(time_steps, N0, lambda_rate, mu_rate, n_iter, seed) {
        simulate_birth_death(
          time_steps = time_steps,
          N0 = N0,
          lambda_rate = lambda_rate,
          mu_rate = mu_rate,
          n_iter = n_iter,
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
    mean_final_richness = mean(final_richness),
    median_final_richness = median(final_richness),
    mean_peak_richness = mean(peak_richness),
    extinction_probability = mean(final_richness == 0),
    .groups = "drop"
  )

print(summary_tbl)
