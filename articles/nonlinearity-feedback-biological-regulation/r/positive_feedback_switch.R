# Positive feedback switch workflow.

simulate_positive_feedback <- function(x0, alpha, beta, k_half, hill_coefficient, dt = 0.01, t_end = 80) {
  time <- seq(0, t_end, by = dt)
  x <- numeric(length(time))
  x[1] <- x0

  for (i in 2:length(time)) {
    production <- alpha * x[i - 1]^hill_coefficient /
      (k_half^hill_coefficient + x[i - 1]^hill_coefficient)
    loss <- beta * x[i - 1]
    dx <- production - loss
    x[i] <- max(x[i - 1] + dx * dt, 0)
  }

  data.frame(time = time, state = x)
}

initial_states <- c(0.1, 0.8, 2.0, 5.0)

rows <- lapply(initial_states, function(x0) {
  trajectory <- simulate_positive_feedback(x0, 3.0, 0.8, 1.5, 4)

  data.frame(
    initial_state = x0,
    final_state = tail(trajectory$state, 1),
    max_state = max(trajectory$state)
  )
})

summary_df <- do.call(rbind, rows)

print(round(summary_df, 5))
