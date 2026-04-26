# Coupled population-community-ecosystem simulation in R.
#
# This script simulates producer, herbivore, and carnivore dynamics while
# tracking a simple ecosystem biomass or detrital pool.

set.seed(42)

simulate_ecology <- function(
  time_steps = 200,
  producers_initial = 80,
  herbivores_initial = 20,
  carnivores_initial = 5,
  biomass_pool_initial = 50,
  producer_growth_rate = 0.08,
  producer_carrying_capacity = 200,
  producer_herbivore_attack = 0.003,
  producer_to_herbivore_efficiency = 0.12,
  herbivore_mortality = 0.03,
  herbivore_carnivore_attack = 0.002,
  herbivore_to_carnivore_efficiency = 0.10,
  carnivore_mortality = 0.02,
  biomass_loss_rate = 0.04,
  disturbance_probability = 0.04,
  disturbance_multiplier = 0.70
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

  for (t in seq_len(time_steps)) {
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

    delta_biomass_pool <- 0.20 * producers -
      0.08 * herbivores -
      0.05 * carnivores -
      biomass_loss_rate * biomass_pool +
      0.03 * (herbivores + carnivores)

    producers <- max(0, producers + delta_producers)
    herbivores <- max(0, herbivores + delta_herbivores)
    carnivores <- max(0, carnivores + delta_carnivores)
    biomass_pool <- max(0, biomass_pool + delta_biomass_pool)

    output[t, "producers"] <- producers
    output[t, "herbivores"] <- herbivores
    output[t, "carnivores"] <- carnivores
    output[t, "biomass_pool"] <- biomass_pool
  }

  output
}

result <- simulate_ecology()
print(tail(round(result, 3)))
print(summary(result))
