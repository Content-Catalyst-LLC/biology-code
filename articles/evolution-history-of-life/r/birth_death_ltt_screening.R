# Macroevolutionary diversification workflow in R.
#
# Simulates branching richness under simple birth-death logic.

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
    richness <- N0
    peak <- richness

    for (t in seq_len(time_steps)) {
      births <- rpois(1, lambda = lambda_rate * richness)
      deaths <- rpois(1, lambda = mu_rate * richness)
      richness <- max(richness + births - deaths, 0)
      peak <- max(peak, richness)

      if (richness == 0) break
    }

    finals[i] <- richness
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
    seed = row_number() + 200,
    sim = pmap(
      list(time_steps, N0, lambda_rate, mu_rate, n_iter, seed),
      simulate_birth_death
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
