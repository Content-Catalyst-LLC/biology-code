# Logistic density-dependent regulation workflow.

simulate_logistic <- function(N0, r, K, dt = 0.05, t_end = 40) {
  time <- seq(0, t_end, by = dt)
  N <- numeric(length(time))
  N[1] <- N0

  for (i in 2:length(time)) {
    dN <- r * N[i - 1] * (1 - N[i - 1] / K)
    N[i] <- max(N[i - 1] + dN * dt, 0)
  }

  data.frame(time = time, population = N)
}

trajectory <- simulate_logistic(100, 0.30, 2000)

summary_df <- data.frame(
  initial_population = trajectory$population[1],
  final_population = tail(trajectory$population, 1),
  fraction_of_capacity = tail(trajectory$population, 1) / 2000
)

print(round(summary_df, 5))
