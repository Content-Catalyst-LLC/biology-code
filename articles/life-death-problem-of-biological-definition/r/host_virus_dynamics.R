# Simple host-virus dynamics in R.

scenario_path <- file.path("data", "host_virus_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "host_virus_scenarios.csv")
}

simulate_host_virus <- function(target_initial, infected_initial, virus_initial, beta, delta, production, clearance, time_end, dt) {
  time <- seq(0, time_end, by = dt)

  target <- numeric(length(time))
  infected <- numeric(length(time))
  virus <- numeric(length(time))

  target[1] <- target_initial
  infected[1] <- infected_initial
  virus[1] <- virus_initial

  for (i in 2:length(time)) {
    d_target <- -beta * target[i - 1] * virus[i - 1]
    d_infected <- beta * target[i - 1] * virus[i - 1] - delta * infected[i - 1]
    d_virus <- production * infected[i - 1] - clearance * virus[i - 1]

    target[i] <- max(target[i - 1] + d_target * dt, 0)
    infected[i] <- max(infected[i - 1] + d_infected * dt, 0)
    virus[i] <- max(virus[i - 1] + d_virus * dt, 0)
  }

  data.frame(
    time = time,
    target_cells = target,
    infected_cells = infected,
    free_virus = virus
  )
}

scenarios <- read.csv(scenario_path)

rows <- lapply(seq_len(nrow(scenarios)), function(i) {
  s <- scenarios[i, ]

  sim <- simulate_host_virus(
    s$target_initial,
    s$infected_initial,
    s$virus_initial,
    s$beta,
    s$delta,
    s$production,
    s$clearance,
    s$time_end,
    s$dt
  )

  data.frame(
    scenario = s$scenario,
    final_target_cells = tail(sim$target_cells, 1),
    final_infected_cells = tail(sim$infected_cells, 1),
    final_free_virus = tail(sim$free_virus, 1),
    peak_infected_cells = max(sim$infected_cells),
    peak_free_virus = max(sim$free_virus)
  )
})

summary_df <- do.call(rbind, rows)

print(round(summary_df, 5))
