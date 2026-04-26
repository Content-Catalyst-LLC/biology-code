# Growth-curve fitting in R.

growth_path <- file.path("data", "growth_observations.csv")
if (!file.exists(growth_path)) {
  growth_path <- file.path("..", "data", "growth_observations.csv")
}

growth <- read.csv(growth_path)

fit_condition <- function(df) {
  fit <- lm(log(abundance) ~ time_h, data = df)
  r <- coef(fit)[["time_h"]]

  data.frame(
    condition = unique(df$condition),
    growth_rate = r,
    initial_abundance = exp(coef(fit)[["(Intercept)"]]),
    doubling_time = log(2) / r,
    r_squared_log_space = summary(fit)$r.squared
  )
}

summary_df <- do.call(
  rbind,
  lapply(split(growth, growth$condition), fit_condition)
)

print(round(summary_df, 5))
