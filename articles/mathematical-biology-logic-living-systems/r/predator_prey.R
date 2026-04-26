# Predator-prey workflow in R.

param_path <- file.path("data", "predator_prey_parameters.csv")
if (!file.exists(param_path)) {
  param_path <- file.path("..", "data", "predator_prey_parameters.csv")
}

simulate_predator_prey <- function(prey0, predator0, alpha, beta, delta, gamma, time_end, dt) {
  time <- seq(0, time_end, by = dt)
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

params <- read.csv(param_path)

rows <- list()

for (i in seq_len(nrow(params))) {
  p <- params[i, ]
  sim <- simulate_predator_prey(p$prey0, p$predator0, p$alpha, p$beta, p$delta, p$gamma, p$time_end, p$dt)

  rows[[i]] <- data.frame(
    scenario = p$scenario,
    final_prey = tail(sim$prey, 1),
    final_predator = tail(sim$predator, 1),
    max_prey = max(sim$prey),
    max_predator = max(sim$predator),
    mean_prey = mean(sim$prey),
    mean_predator = mean(sim$predator)
  )
}

summary_df <- do.call(rbind, rows)
print(round(summary_df, 4))
