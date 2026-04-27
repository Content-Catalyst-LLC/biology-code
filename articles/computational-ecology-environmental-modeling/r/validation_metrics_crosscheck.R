# Validation metrics cross-check in R.

validation <- read.csv(file.path("data", "validation_observations.csv"), stringsAsFactors = FALSE)

errors <- validation$observed_abundance - validation$predicted_abundance

metrics <- data.frame(
  metric = c("RMSE", "MAE", "Bias"),
  value = c(
    sqrt(mean(errors^2)),
    mean(abs(errors)),
    mean(errors)
  )
)

print(round(metrics, 5))
