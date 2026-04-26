# Restoration Scenario Screening in R

library(tidyverse)

article_dir <- "articles/restoration-ecology-repair-of-living-systems"

params <- read_csv(
  file.path(article_dir, "data/restoration_parameters.csv"),
  show_col_types = FALSE
)

scenarios <- read_csv(
  file.path(article_dir, "data/restoration_scenarios.csv"),
  show_col_types = FALSE
)

get_param <- function(name) {
  params %>%
    filter(parameter == name) %>%
    pull(value) %>%
    as.numeric()
}

simulate_restoration <- function(S, B, D) {
  a <- get_param("a")
  b <- get_param("b")
  c <- get_param("c")
  p <- get_param("p")
  q <- get_param("q")
  r <- get_param("r")
  u <- get_param("u")
  v <- get_param("v")
  w <- get_param("w")
  dt <- get_param("dt")
  T_end <- get_param("T")

  time <- seq(0, T_end, by = dt)

  V <- numeric(length(time))
  M <- numeric(length(time))
  F <- numeric(length(time))

  V[1] <- 10
  M[1] <- 8
  F[1] <- 6

  for (i in 2:length(time)) {
    dV <- a * S - b * V[i - 1] - c * D
    dM <- p * V[i - 1] + q * B - r * M[i - 1]
    dF <- u * V[i - 1] + v * M[i - 1] - w * D

    V[i] <- max(0, V[i - 1] + dV * dt)
    M[i] <- max(0, M[i - 1] + dM * dt)
    F[i] <- max(0, F[i - 1] + dF * dt)
  }

  tibble(
    final_V = last(V),
    final_M = last(M),
    final_F = last(F),
    peak_F = max(F)
  )
}

scenario_summary <- scenarios %>%
  mutate(result = pmap(list(S, B, D), simulate_restoration)) %>%
  unnest(result) %>%
  mutate(
    restoration_class = case_when(
      final_F >= 12 ~ "strong-recovery",
      final_F >= 8 ~ "partial-recovery",
      TRUE ~ "stalled"
    )
  )

write_csv(
  scenario_summary,
  file.path(article_dir, "data/computed_restoration_scenario_screening_r.csv")
)

print(scenario_summary)
