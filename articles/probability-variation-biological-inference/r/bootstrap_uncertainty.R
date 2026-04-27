# Bootstrap uncertainty workflow in R.

measure_path <- file.path("data", "biological_measurements.csv")
if (!file.exists(measure_path)) {
  measure_path <- file.path("..", "data", "biological_measurements.csv")
}

set.seed(42)

data <- read.csv(measure_path)

bootstrap_mean <- function(x, n_boot = 5000) {
  boot <- replicate(n_boot, mean(sample(x, replace = TRUE)))

  c(
    observed_mean = mean(x),
    bootstrap_mean = mean(boot),
    ci_lower = quantile(boot, 0.025),
    ci_upper = quantile(boot, 0.975)
  )
}

rows <- lapply(split(data$value, data$group), bootstrap_mean)

summary_df <- data.frame(
  group = names(rows),
  do.call(rbind, rows),
  row.names = NULL
)

print(round(summary_df, 5))
