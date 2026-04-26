# Homeostatic setpoint dynamics in R.

home_path <- file.path("data", "homeostasis_scenarios.csv")

if (!file.exists(home_path)) {
  home_path <- file.path("..", "data", "homeostasis_scenarios.csv")
}

homeostasis <- read.csv(home_path)

homeostatic_solution <- function(time, initial_value, setpoint, correction_rate) {
  setpoint + (initial_value - setpoint) * exp(-correction_rate * time)
}

recovery_index <- function(initial_value, final_value, setpoint) {
  initial_deviation <- abs(initial_value - setpoint)

  if (initial_deviation == 0) {
    return(1)
  }

  1 - abs(final_value - setpoint) / initial_deviation
}

rows <- lapply(seq_len(nrow(homeostasis)), function(i) {
  s <- homeostasis[i, ]
  time <- seq(0, s$time_end, by = s$dt)
  state <- homeostatic_solution(time, s$initial_value, s$setpoint, s$correction_rate)
  final_state <- tail(state, 1)

  data.frame(
    scenario = s$scenario,
    initial_value = s$initial_value,
    setpoint = s$setpoint,
    correction_rate = s$correction_rate,
    final_state = final_state,
    final_deviation = final_state - s$setpoint,
    half_recovery_time = ifelse(s$correction_rate > 0, log(2) / s$correction_rate, NA),
    recovery_index = recovery_index(s$initial_value, final_state, s$setpoint)
  )
})

summary_df <- do.call(rbind, rows)

print(round(summary_df, 5))
