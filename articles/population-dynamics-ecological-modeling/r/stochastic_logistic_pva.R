# Stochastic logistic population model with harvest and quasi-extinction analysis.
#
# This workflow simulates many population trajectories and summarizes
# persistence risk under environmental variability, harvest, and catastrophes.

set.seed(123)

simulate_population <- function(
  years = 50,
  n_sims = 1000,
  initial_population = 80,
  growth_rate_mean = 0.18,
  growth_rate_sd = 0.08,
  carrying_capacity_mean = 500,
  carrying_capacity_sd = 40,
  harvest = 5,
  catastrophe_probability = 0.05,
  catastrophe_multiplier = 0.60,
  quasi_extinction_threshold = 20
) {
  trajectories <- matrix(
    NA_real_,
    nrow = years + 1,
    ncol = n_sims
  )

  trajectories[1, ] <- initial_population

  for (sim in seq_len(n_sims)) {
    population_size <- initial_population

    for (year in seq_len(years)) {
      growth_rate_t <- rnorm(
        1,
        mean = growth_rate_mean,
        sd = growth_rate_sd
      )

      carrying_capacity_t <- max(
        quasi_extinction_threshold,
        rnorm(
          1,
          mean = carrying_capacity_mean,
          sd = carrying_capacity_sd
        )
      )

      population_size <- population_size +
        growth_rate_t * population_size *
        (1 - population_size / carrying_capacity_t) -
        harvest

      if (runif(1) < catastrophe_probability) {
        population_size <- population_size * catastrophe_multiplier
      }

      population_size <- max(0, population_size)
      trajectories[year + 1, sim] <- population_size

      if (population_size == 0) {
        trajectories[(year + 1):(years + 1), sim] <- 0
        break
      }
    }
  }

  final_sizes <- trajectories[years + 1, ]
  minimum_sizes <- apply(trajectories, 2, min, na.rm = TRUE)

  list(
    trajectories = trajectories,
    extinction_risk = mean(final_sizes == 0),
    quasi_extinction_risk = mean(
      minimum_sizes <= quasi_extinction_threshold
    ),
    mean_final = mean(final_sizes),
    median_final = median(final_sizes)
  )
}

result <- simulate_population()

summary <- data.frame(
  extinction_risk = result$extinction_risk,
  quasi_extinction_risk = result$quasi_extinction_risk,
  mean_final = result$mean_final,
  median_final = result$median_final
)

print(round(summary, 3))
