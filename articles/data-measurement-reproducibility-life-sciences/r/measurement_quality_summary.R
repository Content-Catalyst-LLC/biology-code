# Measurement quality summary workflow.

data_path <- file.path("data", "measurements.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "measurements.csv")
}

measurements <- read.csv(data_path)

values <- suppressWarnings(as.numeric(measurements$measurement_value))
pass_values <- values[measurements$qc_flag == "pass" & !is.na(values)]

summary_df <- data.frame(
  n_total = nrow(measurements),
  n_missing = sum(is.na(values)),
  n_pass = sum(measurements$qc_flag == "pass"),
  n_review = sum(measurements$qc_flag == "review"),
  n_fail = sum(measurements$qc_flag == "fail"),
  completeness_rate = 1 - sum(is.na(values)) / nrow(measurements),
  qc_pass_rate = sum(measurements$qc_flag == "pass") / nrow(measurements),
  mean_value = mean(pass_values),
  sd_value = sd(pass_values),
  coefficient_of_variation = sd(pass_values) / mean(pass_values)
)

print(round(summary_df, 5))
