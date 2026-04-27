# Delayed negative feedback scaffold.

simulate_delayed_negative_feedback <- function(x0, production_rate, feedback_strength, delay, dt = 0.01, t_end = 80) {
  time <- seq(0, t_end, by = dt)
  x <- numeric(length(time))
  x[1] <- x0
  delay_steps <- max(as.integer(delay / dt), 1)

  for (i in 2:length(time)) {
    delayed_index <- max(i - delay_steps, 1)
    delayed_state <- x[delayed_index]
    dx <- production_rate - feedback_strength * delayed_state
    x[i] <- max(x[i - 1] + dx * dt, 0)
  }

  data.frame(time = time, state = x)
}

delays <- c(0.1, 1.0, 4.0, 8.0)

rows <- lapply(delays, function(delay) {
  trajectory <- simulate_delayed_negative_feedback(1.0, 1.0, 0.8, delay)

  data.frame(
    delay = delay,
    final_state = tail(trajectory$state, 1),
    max_state = max(trajectory$state),
    state_range = max(trajectory$state) - min(trajectory$state)
  )
})

summary_df <- do.call(rbind, rows)

print(round(summary_df, 5))
