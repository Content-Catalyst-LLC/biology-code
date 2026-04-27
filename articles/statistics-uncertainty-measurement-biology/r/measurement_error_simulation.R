# Measurement error simulation in R.

set.seed(42)

n_samples <- 200

true_values <- rnorm(n_samples, mean = 10.0, sd = 1.5)
systematic_bias <- 0.35
random_error_sd <- 0.45

measured_values <- true_values + systematic_bias + rnorm(
  n_samples,
  mean = 0,
  sd = random_error_sd
)

errors <- measured_values - true_values

summary_df <- data.frame(
  true_mean = mean(true_values),
  measured_mean = mean(measured_values),
  mean_error = mean(errors),
  error_sd = sd(errors),
  rmse = sqrt(mean(errors^2))
)

print(round(summary_df, 5))
