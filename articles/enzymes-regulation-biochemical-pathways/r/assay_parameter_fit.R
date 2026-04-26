# Fit Michaelis-Menten parameters from synthetic assay data in R.

assay_path <- file.path("data", "enzyme_assay.csv")

if (!file.exists(assay_path)) {
  assay_path <- file.path("..", "data", "enzyme_assay.csv")
}

assay_df <- read.csv(assay_path)

fit <- nls(
  velocity_units_min ~ (Vmax * substrate_mM) / (Km + substrate_mM),
  data = assay_df,
  start = list(Vmax = 100, Km = 4)
)

print(summary(fit))

assay_df$predicted_velocity <- predict(fit)
assay_df$residual <- assay_df$velocity_units_min - assay_df$predicted_velocity

print(round(assay_df, 4))
