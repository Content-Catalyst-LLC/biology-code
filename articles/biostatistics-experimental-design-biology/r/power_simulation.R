# Power simulation workflow in R.

data_path <- file.path("data", "power_scenarios.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "power_scenarios.csv")
}

simulate_power <- function(sample_size, effect_size, sigma, n_sim, seed) {
  set.seed(seed)
  significant <- 0

  for (i in seq_len(n_sim)) {
    control <- rnorm(sample_size, mean = 0, sd = sigma)
    treated <- rnorm(sample_size, mean = effect_size, sd = sigma)

    difference <- mean(treated) - mean(control)
    se <- sqrt(var(control) / sample_size + var(treated) / sample_size)

    if (!is.na(se) && se > 0 && abs(difference / se) > 1.96) {
      significant <- significant + 1
    }
  }

  significant / n_sim
}

scenarios <- read.csv(data_path)

scenarios$estimated_power <- mapply(
  simulate_power,
  scenarios$sample_size_per_group,
  scenarios$effect_size,
  scenarios$sigma,
  scenarios$n_sim,
  scenarios$seed
)

print(round(scenarios, 5))
