# Bootstrap mean-difference uncertainty in R.

data_path <- file.path("data", "two_group_measurements.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "two_group_measurements.csv")
}

set.seed(42)

data <- read.csv(data_path)

control <- data$value[data$group == "control"]
treated <- data$value[data$group == "treated"]

n_boot <- 5000

boot <- replicate(n_boot, {
  mean(sample(treated, replace = TRUE)) - mean(sample(control, replace = TRUE))
})

summary_df <- data.frame(
  bootstrap_mean_difference = mean(boot),
  ci_lower = quantile(boot, 0.025),
  ci_upper = quantile(boot, 0.975)
)

print(round(summary_df, 5))
