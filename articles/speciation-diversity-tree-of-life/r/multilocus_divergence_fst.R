# Multi-locus divergence and FST-style summaries in R.

library(dplyr)
library(tidyr)
library(purrr)

scenario_path <- file.path("data", "divergence_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "divergence_scenarios.csv")
}

simulate_two_populations <- function(
  generations,
  loci,
  N1,
  N2,
  m12,
  m21,
  sel_sd,
  seed
) {
  set.seed(seed)

  p1 <- runif(loci, 0.2, 0.8)
  p2 <- p1

  s1 <- rnorm(loci, mean = 0, sd = sel_sd)
  s2 <- -s1

  records <- vector("list", generations + 1)

  record_state <- function(gen, p1, p2) {
    H1 <- 2 * p1 * (1 - p1)
    H2 <- 2 * p2 * (1 - p2)
    p_bar <- (p1 + p2) / 2
    HT <- 2 * p_bar * (1 - p_bar)
    HS <- (H1 + H2) / 2
    fst <- ifelse(HT > 0, (HT - HS) / HT, 0)

    tibble(
      generation = gen,
      locus = seq_along(p1),
      p1 = p1,
      p2 = p2,
      delta_p = abs(p1 - p2),
      fst = fst
    )
  }

  records[[1]] <- record_state(0, p1, p2)

  for (g in 1:generations) {
    p1_sel <- pmin(pmax(p1 + s1 * p1 * (1 - p1), 0), 1)
    p2_sel <- pmin(pmax(p2 + s2 * p2 * (1 - p2), 0), 1)

    p1_mig <- (1 - m12) * p1_sel + m12 * p2_sel
    p2_mig <- (1 - m21) * p2_sel + m21 * p1_sel

    p1 <- rbinom(loci, 2 * N1, p1_mig) / (2 * N1)
    p2 <- rbinom(loci, 2 * N2, p2_mig) / (2 * N2)

    records[[g + 1]] <- record_state(g, p1, p2)
  }

  bind_rows(records)
}

scenarios <- read.csv(scenario_path)

results <- scenarios %>%
  mutate(
    sim = pmap(
      list(generations, loci, N1, N2, m12, m21, sel_sd, seed),
      function(generations, loci, N1, N2, m12, m21, sel_sd, seed) {
        simulate_two_populations(
          generations = generations,
          loci = loci,
          N1 = N1,
          N2 = N2,
          m12 = m12,
          m21 = m21,
          sel_sd = sel_sd,
          seed = seed
        )
      }
    )
  ) %>%
  select(scenario, sim) %>%
  unnest(sim)

summary_tbl <- results %>%
  group_by(scenario, generation) %>%
  summarise(
    mean_delta_p = mean(delta_p),
    mean_fst = mean(fst),
    max_fst = max(fst),
    .groups = "drop"
  ) %>%
  group_by(scenario) %>%
  slice_max(order_by = generation, n = 1) %>%
  ungroup()

print(summary_tbl)
