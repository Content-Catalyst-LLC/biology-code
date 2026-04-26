# Reciprocal frequency dynamics in R.

library(dplyr)

scenario_path <- file.path("data", "reciprocal_frequency_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "reciprocal_frequency_scenarios.csv")
}

scenarios <- read.csv(scenario_path)

simulate_feedback <- function(host_initial, symbiont_initial, host_feedback, symbiont_feedback, steps) {
  time <- 0:steps
  host_match <- numeric(length(time))
  symbiont_match <- numeric(length(time))

  host_match[1] <- host_initial
  symbiont_match[1] <- symbiont_initial

  for (t in 2:length(time)) {
    host_match[t] <- min(
      max(host_match[t - 1] + host_feedback * (symbiont_match[t - 1] - host_match[t - 1]), 0),
      1
    )

    symbiont_match[t] <- min(
      max(symbiont_match[t - 1] + symbiont_feedback * (host_match[t - 1] - symbiont_match[t - 1]), 0),
      1
    )
  }

  tibble(
    time = time,
    host_match = host_match,
    symbiont_match = symbiont_match,
    mismatch = abs(host_match - symbiont_match)
  )
}

results <- bind_rows(lapply(seq_len(nrow(scenarios)), function(i) {
  row <- scenarios[i, ]

  simulate_feedback(
    row$host_initial,
    row$symbiont_initial,
    row$host_feedback,
    row$symbiont_feedback,
    row$steps
  ) %>% mutate(scenario = row$scenario)
}))

summary_tbl <- results %>%
  group_by(scenario) %>%
  summarise(
    final_host_match = last(host_match),
    final_symbiont_match = last(symbiont_match),
    final_mismatch = last(mismatch),
    mean_mismatch = mean(mismatch),
    .groups = "drop"
  )

print(summary_tbl)
