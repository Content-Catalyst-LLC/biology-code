# Quantitative microbiology workflow in R.
#
# This script compares logistic growth under multiple environmental conditions
# and screens treatment effects on microbial population trajectories.

library(dplyr)
library(tidyr)
library(purrr)

logistic_curve <- function(t, N0, r, K) {
  K / (1 + ((K - N0) / N0) * exp(-r * t))
}

temp_response <- function(temp, tref = 20, q10 = 2) {
  q10 ^ ((temp - tref) / 10)
}

ph_response <- function(ph, ph_opt = 7, width = 1.2) {
  exp(-((ph - ph_opt)^2) / (2 * width^2))
}

simulate_population <- function(days = 0:48, N0 = 1e4, r0 = 0.35, K = 1e8, temp = 20, ph = 7) {
  r_eff <- r0 * temp_response(temp) * ph_response(ph)

  tibble(
    day = days,
    abundance = logistic_curve(days, N0, r_eff, K),
    r_eff = r_eff
  )
}

growth_path <- file.path("data", "growth_environments.csv")

if (!file.exists(growth_path)) {
  growth_path <- file.path("..", "data", "growth_environments.csv")
}

scenarios <- read.csv(growth_path)

results <- scenarios %>%
  mutate(
    sim = pmap(
      list(temp, ph, K, N0, r0),
      ~ simulate_population(temp = ..1, ph = ..2, K = ..3, N0 = ..4, r0 = ..5)
    )
  ) %>%
  select(environment, sim) %>%
  unnest(sim)

summary_tbl <- results %>%
  group_by(environment) %>%
  summarise(
    effective_growth_rate = first(r_eff),
    abundance_day_24 = abundance[day == 24],
    abundance_day_48 = abundance[day == 48],
    .groups = "drop"
  )

print(summary_tbl)

intervention_path <- file.path("data", "interventions.csv")

if (!file.exists(intervention_path)) {
  intervention_path <- file.path("..", "data", "interventions.csv")
}

interventions <- read.csv(intervention_path)

intervention_results <- interventions %>%
  mutate(
    sim = pmap(
      list(temp, ph, K, N0, r0),
      ~ simulate_population(days = 0:72, temp = ..1, ph = ..2, K = ..3, N0 = ..4, r0 = ..5)
    ),
    final_abundance = map_dbl(sim, ~ dplyr::last(.x$abundance)),
    r_eff = map_dbl(sim, ~ unique(.x$r_eff))
  )

print(intervention_results %>% select(treatment, r_eff, final_abundance))
