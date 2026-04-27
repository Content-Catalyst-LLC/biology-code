# Habitat suitability cross-check in R.

sites <- read.csv(file.path("data", "sites.csv"), stringsAsFactors = FALSE)

logistic <- function(x) {
  1 / (1 + exp(-x))
}

sites$suitability <- logistic(
  -2.0 +
    0.05 * sites$temperature_c +
    0.0015 * sites$precipitation_mm +
    2.4 * sites$habitat_quality -
    2.0 * sites$disturbance
)

sites$predicted_presence <- as.integer(sites$suitability >= 0.5)

print(round(sites[, c("site_id", "suitability", "predicted_presence", "observed_presence")], 5))
