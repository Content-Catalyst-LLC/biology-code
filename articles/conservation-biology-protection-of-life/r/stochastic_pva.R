# Stochastic population viability analysis in R.
#
# This script simulates many population trajectories under environmental
# variation and estimates extinction and quasi-extinction risk.

set.seed(42)

simulate_pva <- function(
  n0 = 120,
  years = 50,
  n_sims = 1000,
  r_mean = 0.04,
  r_sd = 0.08,
  k_mean = 250,
  k_sd = 20,
  catastrophe_prob = 0.05,
  catastrophe_mult = 0.65,
  quasi_extinction = 20
) {
  trajectories <- matrix(NA_real_, nrow = years + 1, ncol = n_sims)
  trajectories[1, ] <- n0

  for (sim in seq_len(n_sims)) {
    population_size <- n0

    for (year in seq_len(years)) {
      r_t <- rnorm(1, mean = r_mean, sd = r_sd)
      k_t <- max(10, rnorm(1, mean = k_mean, sd = k_sd))

      population_size <- population_size +
        r_t * population_size * (1 - population_size / k_t)

      if (runif(1) < catastrophe_prob) {
        population_size <- population_size * catastrophe_mult
      }

      population_size <- max(0, round(population_size))
      trajectories[year + 1, sim] <- population_size

      if (population_size == 0) {
        trajectories[(year + 1):(years + 1), sim] <- 0
        break
      }
    }
  }

  minimum_sizes <- apply(trajectories, 2, min, na.rm = TRUE)
  final_sizes <- trajectories[years + 1, ]

  list(
    trajectories = trajectories,
    extinction_risk = mean(final_sizes == 0, na.rm = TRUE),
    quasi_extinction_risk = mean(minimum_sizes <= quasi_extinction, na.rm = TRUE),
    median_final_size = median(final_sizes, na.rm = TRUE),
    mean_final_size = mean(final_sizes, na.rm = TRUE)
  )
}

results <- simulate_pva()

summary <- data.frame(
  extinction_risk = results$extinction_risk,
  quasi_extinction_risk = results$quasi_extinction_risk,
  median_final_size = results$median_final_size,
  mean_final_size = results$mean_final_size
)

print(round(summary, 3))
