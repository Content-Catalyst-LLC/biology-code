# Measurement uncertainty budget workflow.

data_path <- file.path("data", "uncertainty_components.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "uncertainty_components.csv")
}

components <- read.csv(data_path)

combined_standard_uncertainty <- sqrt(sum(components$standard_uncertainty^2))
coverage_factor <- 2.0
expanded_uncertainty <- coverage_factor * combined_standard_uncertainty

summary_df <- data.frame(
  combined_standard_uncertainty = combined_standard_uncertainty,
  coverage_factor = coverage_factor,
  expanded_uncertainty = expanded_uncertainty
)

print(components)
print(round(summary_df, 5))
