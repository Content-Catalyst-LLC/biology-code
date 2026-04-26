# Multi-species ecological simulation in R.
#
# This example includes producers, herbivores, carnivores, a biomass pool,
# density dependence, trophic interaction terms, and stochastic disturbance.

set.seed(42)

simulate_ecosystem <- function(
  time_steps = 150,
  producers_initial = 100,
  herbivores_initial = 30,
  carnivores_initial = 8,
  biomass_pool_initial = 60,
  producer_growth_rate = 0.10,
  producer_carrying_capacity = 250,
  producer_herbivore_attack = 0.0035,
  producer_to_herbivore_efficiency = 0.15,
  herbivore_carnivore_attack = 0.0020,
  herbivore_to_carnivore_efficiency = 0.10,
  herbivore_mortality = 0.04,
  carnivore_mortality = 0.03,
  biomass_loss_rate = 0.05,
  disturbance_probability = 0.04,
  disturbance_multiplier = 0.75
) {
  output <- data.frame(
    time = seq_len(time_steps),
    producers = NA_real_,
    herbivores = NA_real_,
    carnivores = NA_real_,
    biomass_pool = NA_real_
  )

  producers <- producers_initial
  herbivores <- herbivores_initial
  carnivores <- carnivores_initial
  biomass_pool <- biomass_pool_initial

  for (time_step in seq_len(time_steps)) {
    if (runif(1) < disturbance_probability) {
      producers <- producers * disturbance_multiplier
      herbivores <- herbivores * disturbance_multiplier
      biomass_pool <- biomass_pool * disturbance_multiplier
    }

    delta_producers <- producer_growth_rate * producers *
      (1 - producers / producer_carrying_capacity) -
      producer_herbivore_attack * producers * herbivores

    delta_herbivores <- producer_to_herbivore_efficiency *
      producer_herbivore_attack * producers * herbivores -
      herbivore_mortality * herbivores -
      herbivore_carnivore_attack * herbivores * carnivores

    delta_carnivores <- herbivore_to_carnivore_efficiency *
      herbivore_carnivore_attack * herbivores * carnivores -
      carnivore_mortality * carnivores

    delta_biomass_pool <- 0.18 * producers -
      0.07 * herbivores -
      0.05 * carnivores -
      biomass_loss_rate * biomass_pool +
      0.02 * (herbivores + carnivores)

    producers <- max(0, producers + delta_producers)
    herbivores <- max(0, herbivores + delta_herbivores)
    carnivores <- max(0, carnivores + delta_carnivores)
    biomass_pool <- max(0, biomass_pool + delta_biomass_pool)

    output[time_step, ] <- c(
      time_step,
      producers,
      herbivores,
      carnivores,
      biomass_pool
    )
  }

  output
}

result <- simulate_ecosystem()

print(tail(round(result, 3)))
print(summary(result))
