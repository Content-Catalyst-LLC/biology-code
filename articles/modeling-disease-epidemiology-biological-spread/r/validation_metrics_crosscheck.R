# Forecast validation metrics cross-check in R.

validation <- read.csv(file.path("data", "forecast_validation.csv"), stringsAsFactors = FALSE)

errors <- validation$observed_cases - validation$predicted_cases

metrics <- data.frame(
  metric = c("MAE", "RMSE", "Bias"),
  value = c(
    mean(abs(errors)),
    sqrt(mean(errors^2)),
    mean(errors)
  )
)

print(round(metrics, 5))
