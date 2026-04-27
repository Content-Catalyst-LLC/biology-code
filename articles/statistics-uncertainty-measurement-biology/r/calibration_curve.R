# Calibration curve workflow in R.

data_path <- file.path("data", "calibration_standards.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "calibration_standards.csv")
}

standards <- read.csv(data_path)

fit <- lm(response ~ concentration, data = standards)

unknown_response <- 6.25

estimated_concentration <- (
  unknown_response - coef(fit)[["(Intercept)"]]
) / coef(fit)[["concentration"]]

summary_df <- data.frame(
  intercept = coef(fit)[["(Intercept)"]],
  slope = coef(fit)[["concentration"]],
  r_squared = summary(fit)$r.squared,
  unknown_response = unknown_response,
  estimated_concentration = estimated_concentration
)

print(round(summary_df, 5))
