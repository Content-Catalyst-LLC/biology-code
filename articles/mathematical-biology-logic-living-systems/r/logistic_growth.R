# Logistic growth workflow in R.

scenario_path <- file.path("data", "logistic_scenarios.csv")
if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "logistic_scenarios.csv")
}

logistic_growth <- function(time, N0, r, K) {
  K / (1 + ((K - N0) / N0) * exp(-r * time))
}

scenarios <- read.csv(scenario_path)

rows <- list()

for (i in seq_len(nrow(scenarios))) {
  s <- scenarios[i, ]
  time <- seq(0, s$time_end, by = s$dt)
  population <- logistic_growth(time, s$initial_population, s$growth_rate, s$carrying_capacity)

  rows[[i]] <- data.frame(
    scenario = s$scenario,
    final_population = tail(population, 1),
    fraction_of_capacity = tail(population, 1) / s$carrying_capacity,
    initial_doubling_time = log(2) / s$growth_rate
  )
}

summary_df <- do.call(rbind, rows)
print(round(summary_df, 5))
