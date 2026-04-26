# Growth and energy-throughput workflow in R.

growth_path <- file.path("data", "growth_observations.csv")

if (!file.exists(growth_path)) {
  growth_path <- file.path("..", "data", "growth_observations.csv")
}

growth <- read.csv(growth_path)

fit_condition <- function(df) {
  fit <- lm(log(abundance) ~ time_h, data = df)

  r_est <- coef(fit)[["time_h"]]
  n0_est <- exp(coef(fit)[["(Intercept)"]])
  td_est <- log(2) / r_est

  data.frame(
    condition = unique(df$condition),
    growth_rate_per_h = r_est,
    initial_abundance = n0_est,
    doubling_time_h = td_est,
    r_squared_log_space = summary(fit)$r.squared
  )
}

fit_df <- do.call(
  rbind,
  lapply(split(growth, growth$condition), fit_condition)
)

print(round(fit_df, 5))
