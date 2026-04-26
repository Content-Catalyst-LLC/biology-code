# Homeostatic setpoint workflow in R.

scenario_path <- file.path("data", "homeostasis_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "homeostasis_scenarios.csv")
}

scenarios <- read.csv(scenario_path)

simulate_homeostasis <- function(initial_value, setpoint, correction_rate, time_end, dt) {
  time <- seq(0, time_end, by = dt)
  state <- setpoint + (initial_value - setpoint) * exp(-correction_rate * time)

  data.frame(
    time = time,
    state = state,
    setpoint = setpoint,
    deviation = state - setpoint
  )
}

summary_rows <- lapply(seq_len(nrow(scenarios)), function(i) {
  s <- scenarios[i, ]

  sim <- simulate_homeostasis(
    s$initial_value,
    s$setpoint,
    s$correction_rate,
    s$time_end,
    s$dt
  )

  data.frame(
    scenario = s$scenario,
    final_state = tail(sim$state, 1),
    final_deviation = tail(sim$deviation, 1),
    half_recovery_time = ifelse(s$correction_rate > 0, log(2) / s$correction_rate, NA)
  )
})

summary_df <- do.call(rbind, summary_rows)

print(round(summary_df, 5))
