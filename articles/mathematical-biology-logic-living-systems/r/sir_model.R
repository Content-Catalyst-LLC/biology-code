# SIR model workflow in R.

sir_path <- file.path("data", "sir_scenarios.csv")
if (!file.exists(sir_path)) {
  sir_path <- file.path("..", "data", "sir_scenarios.csv")
}

simulate_sir <- function(beta, gamma, susceptible0, infected0, recovered0, time_end, dt) {
  time <- seq(0, time_end, by = dt)
  susceptible <- numeric(length(time))
  infected <- numeric(length(time))
  recovered <- numeric(length(time))

  susceptible[1] <- susceptible0
  infected[1] <- infected0
  recovered[1] <- recovered0

  for (i in 2:length(time)) {
    ds <- -beta * susceptible[i - 1] * infected[i - 1]
    di <- beta * susceptible[i - 1] * infected[i - 1] - gamma * infected[i - 1]
    dr <- gamma * infected[i - 1]

    susceptible[i] <- max(susceptible[i - 1] + ds * dt, 0)
    infected[i] <- max(infected[i - 1] + di * dt, 0)
    recovered[i] <- max(recovered[i - 1] + dr * dt, 0)
  }

  data.frame(time = time, susceptible = susceptible, infected = infected, recovered = recovered)
}

scenarios <- read.csv(sir_path)

rows <- list()

for (i in seq_len(nrow(scenarios))) {
  s <- scenarios[i, ]
  sim <- simulate_sir(s$beta, s$gamma, s$susceptible0, s$infected0, s$recovered0, s$time_end, s$dt)
  peak_index <- which.max(sim$infected)

  rows[[i]] <- data.frame(
    scenario = s$scenario,
    R0 = s$beta / s$gamma,
    peak_infected = sim$infected[peak_index],
    time_to_peak = sim$time[peak_index],
    final_recovered = tail(sim$recovered, 1)
  )
}

summary_df <- do.call(rbind, rows)
print(round(summary_df, 5))
