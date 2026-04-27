# Negative feedback homeostasis workflow.

simulate_negative_feedback <- function(x0, set_point, k, dt = 0.05, t_end = 30) {
  time <- seq(0, t_end, by = dt)
  x <- numeric(length(time))
  x[1] <- x0

  for (i in 2:length(time)) {
    dx <- -k * (x[i - 1] - set_point)
    x[i] <- x[i - 1] + dx * dt
  }

  data.frame(time = time, state = x)
}

trajectory <- simulate_negative_feedback(180, 100, 0.18)

summary_df <- data.frame(
  initial_state = trajectory$state[1],
  final_state = tail(trajectory$state, 1),
  set_point = 100,
  final_error = abs(tail(trajectory$state, 1) - 100)
)

print(round(summary_df, 5))
