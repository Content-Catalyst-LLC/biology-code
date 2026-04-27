# Cross-check logistic growth simulation in R.

simulate_logistic <- function(initial_population, growth_rate, carrying_capacity, dt, steps) {
  population <- initial_population
  rows <- data.frame(step = integer(), time = numeric(), population = numeric())

  for (step in 0:steps) {
    rows <- rbind(rows, data.frame(step = step, time = step * dt, population = population))
    growth <- growth_rate * population * (1 - population / carrying_capacity)
    population <- max(population + dt * growth, 0)
  }

  rows
}

trajectory <- simulate_logistic(
  initial_population = 25,
  growth_rate = 0.35,
  carrying_capacity = 1000,
  dt = 0.1,
  steps = 200
)

print(round(tail(trajectory), 5))
