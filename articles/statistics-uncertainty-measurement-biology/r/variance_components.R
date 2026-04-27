# Variance components workflow in R.

data_path <- file.path("data", "biological_technical_replicates.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "biological_technical_replicates.csv")
}

data <- read.csv(data_path)

unit_means <- aggregate(measurement ~ biological_unit, data = data, FUN = mean)
unit_vars <- aggregate(measurement ~ biological_unit, data = data, FUN = var)

between_unit_variance <- var(unit_means$measurement)
within_unit_variance <- mean(unit_vars$measurement)

summary_df <- data.frame(
  between_biological_unit_variance = between_unit_variance,
  within_technical_variance = within_unit_variance,
  variance_ratio_biological_to_technical = between_unit_variance / within_unit_variance
)

print(round(summary_df, 5))
