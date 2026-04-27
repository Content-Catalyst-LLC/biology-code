# SIR model cross-check in R.

simulate_sir <- function(population, initial_infected, beta, gamma, dt, steps) {
  susceptible <- population - initial_infected
  infected <- initial_infected
  recovered <- 0

  rows <- data.frame(
    step = integer(),
    time = numeric(),
    susceptible = numeric(),
    infected = numeric(),
    recovered = numeric()
  )

  for (step in 0:steps) {
    rows <- rbind(
      rows,
      data.frame(
        step = step,
        time = step * dt,
        susceptible = susceptible,
        infected = infected,
        recovered = recovered
      )
    )

    new_infections <- beta * susceptible * infected / population
    new_recoveries <- gamma * infected

    susceptible <- max(susceptible - dt * new_infections, 0)
    infected <- max(infected + dt * (new_infections - new_recoveries), 0)
    recovered <- min(recovered + dt * new_recoveries, population)
  }

  rows
}

trajectory <- simulate_sir(
  population = 10000,
  initial_infected = 10,
  beta = 0.32,
  gamma = 0.10,
  dt = 0.25,
  steps = 240
)

print(round(tail(trajectory), 5))
