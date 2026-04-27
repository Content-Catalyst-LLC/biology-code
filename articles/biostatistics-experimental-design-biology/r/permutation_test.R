# Permutation test workflow in R.

data_path <- file.path("data", "two_group_measurements.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "two_group_measurements.csv")
}

set.seed(42)

data <- read.csv(data_path)

control <- data$value[data$group == "control"]
treated <- data$value[data$group == "treated"]

observed_difference <- mean(treated) - mean(control)
combined <- c(control, treated)
n_control <- length(control)

n_permutations <- 10000

null <- replicate(n_permutations, {
  shuffled <- sample(combined)
  mean(shuffled[(n_control + 1):length(shuffled)]) - mean(shuffled[1:n_control])
})

p_value <- mean(abs(null) >= abs(observed_difference))

summary_df <- data.frame(
  observed_difference = observed_difference,
  permutation_p_value = p_value,
  null_mean = mean(null),
  null_sd = sd(null)
)

print(round(summary_df, 6))
