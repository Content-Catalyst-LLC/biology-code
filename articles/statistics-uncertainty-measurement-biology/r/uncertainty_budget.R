# Uncertainty budget workflow in R.

data_path <- file.path("data", "uncertainty_components.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "uncertainty_components.csv")
}

components <- read.csv(data_path)

combined <- sqrt(sum(components$standard_uncertainty^2))
expanded <- 2 * combined

summary_df <- data.frame(
  combined_standard_uncertainty = combined,
  coverage_factor = 2,
  expanded_uncertainty = expanded,
  unit = components$unit[1]
)

print(components)
print(round(summary_df, 5))
