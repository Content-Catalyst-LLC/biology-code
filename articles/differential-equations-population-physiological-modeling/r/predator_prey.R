# Predator-prey model using Euler integration.

simulate_predator_prey <- function(prey0, predator0, alpha, beta, delta, gamma, dt = 0.01, t_end = 80) {
  time <- seq(0, t_end, by = dt)
  prey <- numeric(length(time))
  predator <- numeric(length(time))

  prey[1] <- prey0
  predator[1] <- predator0

  for (i in 2:length(time)) {
    dprey <- alpha * prey[i - 1] - beta * prey[i - 1] * predator[i - 1]
    dpredator <- delta * prey[i - 1] * predator[i - 1] - gamma * predator[i - 1]

    prey[i] <- max(prey[i - 1] + dprey * dt, 0)
    predator[i] <- max(predator[i - 1] + dpredator * dt, 0)
  }

  data.frame(time = time, prey = prey, predator = predator)
}

trajectory <- simulate_predator_prey(40, 9, 0.60, 0.025, 0.018, 0.35)

summary_df <- data.frame(
  final_prey = tail(trajectory$prey, 1),
  final_predator = tail(trajectory$predator, 1),
  max_prey = max(trajectory$prey),
  max_predator = max(trajectory$predator)
)

print(round(summary_df, 5))
