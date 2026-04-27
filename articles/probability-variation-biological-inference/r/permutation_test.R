# Permutation test workflow in R.

measure_path <- file.path("data", "biological_measurements.csv")
if (!file.exists(measure_path)) {
  measure_path <- file.path("..", "data", "biological_measurements.csv")
}

set.seed(42)

data <- read.csv(measure_path)

control <- data$value[data$group == "control"]
treated <- data$value[data$group == "treated"]

observed_difference <- mean(treated) - mean(control)
combined <- c(control, treated)
n_control <- length(control)

n_permutations <- 10000

permuted <- replicate(n_permutations, {
  shuffled <- sample(combined, replace = FALSE)
  mean(shuffled[(n_control + 1):length(shuffled)]) - mean(shuffled[1:n_control])
})

p_value <- mean(abs(permuted) >= abs(observed_difference))

summary_df <- data.frame(
  observed_difference = observed_difference,
  permutation_p_value = p_value,
  null_mean = mean(permuted),
  null_sd = sd(permuted)
)

print(round(summary_df, 6))
