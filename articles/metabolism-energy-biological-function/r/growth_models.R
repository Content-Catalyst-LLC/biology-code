# Growth-model workflows for metabolism in R.

growth_path <- file.path("data", "growth_observations.csv")

if (!file.exists(growth_path)) {
  growth_path <- file.path("..", "data", "growth_observations.csv")
}

growth_df <- read.csv(growth_path)

fit_condition <- function(df) {
  fit <- lm(log(abundance) ~ time_h, data = df)

  r_est <- coef(fit)[["time_h"]]
  n0_est <- exp(coef(fit)[["(Intercept)"]])
  td_est <- log(2) / r_est

  data.frame(
    condition = unique(df$condition),
    growth_rate_per_h = r_est,
    estimated_initial_abundance = n0_est,
    doubling_time_h = td_est,
    r_squared_log_space = summary(fit)$r.squared
  )
}

fit_df <- do.call(
  rbind,
  lapply(split(growth_df, growth_df$condition), fit_condition)
)

print(round(fit_df, 5))

logistic_growth <- function(t, N0, r, K) {
  K / (1 + ((K - N0) / N0) * exp(-r * t))
}

time_h <- seq(0, 96, length.out = 25)

logistic_df <- data.frame(
  time_h = time_h,
  control = logistic_growth(time_h, 1.0e5, 0.035, 1.0e6),
  stressed = logistic_growth(time_h, 1.0e5, 0.020, 1.0e6)
)

print(round(logistic_df, 2))
