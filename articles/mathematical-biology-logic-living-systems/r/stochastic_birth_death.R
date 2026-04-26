# Stochastic birth-death workflow in R.

scenario_path <- file.path("data", "stochastic_scenarios.csv")
if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "stochastic_scenarios.csv")
}

simulate_birth_death <- function(initial_population, birth_rate, death_rate, time_end, seed) {
  set.seed(seed)

  time <- 0
  population <- initial_population
  rows <- data.frame(time = time, population = population, event = "initial")

  while (time < time_end && population > 0) {
    total_rate <- (birth_rate + death_rate) * population
    if (total_rate <= 0) break

    time <- time + rexp(1, rate = total_rate)

    if (time > time_end) break

    if (runif(1) < birth_rate / (birth_rate + death_rate)) {
      population <- population + 1
      event <- "birth"
    } else {
      population <- population - 1
      event <- "death"
    }

    rows <- rbind(rows, data.frame(time = time, population = population, event = event))
  }

  rows
}

scenarios <- read.csv(scenario_path)

summary_rows <- list()

for (i in seq_len(nrow(scenarios))) {
  s <- scenarios[i, ]

  sim <- simulate_birth_death(
    s$initial_population,
    s$birth_rate,
    s$death_rate,
    s$time_end,
    s$seed
  )

  final <- tail(sim, 1)

  summary_rows[[i]] <- data.frame(
    scenario = s$scenario,
    n_events = nrow(sim) - 1,
    final_time = final$time,
    final_population = final$population,
    extinct = final$population == 0
  )
}

summary_df <- do.call(rbind, summary_rows)
print(round(summary_df, 4))
