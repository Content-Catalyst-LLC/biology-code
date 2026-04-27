# SEIR model cross-check in R.

simulate_seir <- function(population, initial_exposed, initial_infected, beta, sigma, gamma, dt, steps) {
  susceptible <- population - initial_exposed - initial_infected
  exposed <- initial_exposed
  infected <- initial_infected
  recovered <- 0

  rows <- data.frame(
    step = integer(),
    susceptible = numeric(),
    exposed = numeric(),
    infected = numeric(),
    recovered = numeric()
  )

  for (step in 0:steps) {
    rows <- rbind(
      rows,
      data.frame(
        step = step,
        susceptible = susceptible,
        exposed = exposed,
        infected = infected,
        recovered = recovered
      )
    )

    new_exposures <- beta * susceptible * infected / population
    new_infections <- sigma * exposed
    new_recoveries <- gamma * infected

    susceptible <- max(susceptible - dt * new_exposures, 0)
    exposed <- max(exposed + dt * (new_exposures - new_infections), 0)
    infected <- max(infected + dt * (new_infections - new_recoveries), 0)
    recovered <- min(recovered + dt * new_recoveries, population)
  }

  rows
}

trajectory <- simulate_seir(
  population = 10000,
  initial_exposed = 20,
  initial_infected = 10,
  beta = 0.32,
  sigma = 0.20,
  gamma = 0.10,
  dt = 0.25,
  steps = 240
)

print(round(tail(trajectory), 5))
