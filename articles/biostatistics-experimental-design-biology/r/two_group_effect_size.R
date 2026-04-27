# Two-group effect-size workflow in R.

data_path <- file.path("data", "two_group_measurements.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "two_group_measurements.csv")
}

data <- read.csv(data_path)

control <- data$value[data$group == "control"]
treated <- data$value[data$group == "treated"]

n0 <- length(control)
n1 <- length(treated)

mean0 <- mean(control)
mean1 <- mean(treated)

sd0 <- sd(control)
sd1 <- sd(treated)

pooled_sd <- sqrt(((n0 - 1) * sd0^2 + (n1 - 1) * sd1^2) / (n0 + n1 - 2))

difference <- mean1 - mean0
effect_size_d <- difference / pooled_sd

se_difference <- sqrt(sd0^2 / n0 + sd1^2 / n1)

summary_df <- data.frame(
  control_mean = mean0,
  treated_mean = mean1,
  mean_difference = difference,
  pooled_sd = pooled_sd,
  effect_size_d = effect_size_d,
  se_difference = se_difference,
  ci_lower = difference - 1.96 * se_difference,
  ci_upper = difference + 1.96 * se_difference
)

print(round(summary_df, 5))
