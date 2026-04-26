# Respirometry summary workflow in R.

resp_path <- file.path("data", "respirometry.csv")

if (!file.exists(resp_path)) {
  resp_path <- file.path("..", "data", "respirometry.csv")
}

resp_df <- read.csv(resp_path)

fit_sample <- function(df) {
  fit <- lm(oxygen_mg_L ~ time_min, data = df)
  slope <- coef(fit)[["time_min"]]

  data.frame(
    sample = unique(df$sample),
    oxygen_slope_mg_L_min = slope,
    oxygen_consumption_mg_L_min = -slope,
    temperature_C = mean(df$temperature_C)
  )
}

summary_df <- do.call(
  rbind,
  lapply(split(resp_df, resp_df$sample), fit_sample)
)

print(round(summary_df, 5))
