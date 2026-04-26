# Viability-decay fitting in R.

viability_path <- file.path("data", "viability_observations.csv")

if (!file.exists(viability_path)) {
  viability_path <- file.path("..", "data", "viability_observations.csv")
}

viability <- read.csv(viability_path)

fit_condition <- function(df) {
  fit <- lm(log(viable_cells) ~ time_h, data = df)

  slope <- coef(fit)[["time_h"]]
  loss_rate <- -slope
  initial_count <- exp(coef(fit)[["(Intercept)"]])
  half_life <- log(2) / loss_rate

  data.frame(
    condition = unique(df$condition),
    loss_rate_per_h = loss_rate,
    initial_viable_count = initial_count,
    half_life_h = half_life,
    r_squared_log_space = summary(fit)$r.squared
  )
}

summary_df <- do.call(
  rbind,
  lapply(split(viability, viability$condition), fit_condition)
)

print(round(summary_df, 5))
