# Sensitivity summary for logistic growth in R.

logistic_growth <- function(time, N0, r, K) {
  K / (1 + ((K - N0) / N0) * exp(-r * time))
}

base_N0 <- 100
base_r <- 0.30
base_K <- 2000
time <- 40

base_output <- logistic_growth(time, base_N0, base_r, base_K)

sensitivity <- function(base_output, perturbed_output, base_parameter, perturbed_parameter) {
  (base_parameter / base_output) * ((perturbed_output - base_output) / (perturbed_parameter - base_parameter))
}

rows <- data.frame(
  parameter = c("growth_rate", "carrying_capacity", "initial_population"),
  base_value = c(base_r, base_K, base_N0),
  perturbed_value = c(base_r + 0.01, base_K + 50, base_N0 + 5)
)

rows$base_output <- base_output

rows$perturbed_output <- c(
  logistic_growth(time, base_N0, base_r + 0.01, base_K),
  logistic_growth(time, base_N0, base_r, base_K + 50),
  logistic_growth(time, base_N0 + 5, base_r, base_K)
)

rows$normalized_local_sensitivity <- mapply(
  sensitivity,
  rows$base_output,
  rows$perturbed_output,
  rows$base_value,
  rows$perturbed_value
)

print(round(rows, 6))
