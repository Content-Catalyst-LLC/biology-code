# Descriptive uncertainty workflow in R.

data_path <- file.path("data", "measurements.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "measurements.csv")
}

data <- read.csv(data_path)

summarize_group <- function(x) {
  n <- length(x)
  mean_value <- mean(x)
  sd_value <- sd(x)
  se_value <- sd_value / sqrt(n)
  t_crit <- qt(0.975, df = n - 1)

  data.frame(
    n = n,
    mean = mean_value,
    standard_deviation = sd_value,
    standard_error = se_value,
    ci_lower = mean_value - t_crit * se_value,
    ci_upper = mean_value + t_crit * se_value
  )
}

rows <- lapply(split(data$value, data$group), summarize_group)

summary_df <- data.frame(
  group = names(rows),
  do.call(rbind, rows),
  row.names = NULL
)

print(round(summary_df, 5))
