# Growth-model workflow in R.

growth_path <- file.path("data", "growth_observations.csv")
if (!file.exists(growth_path)) {
  growth_path <- file.path("..", "data", "growth_observations.csv")
}

growth <- read.csv(growth_path)

fit_scenario <- function(df) {
  fit <- lm(log(population) ~ time, data = df)
  r <- coef(fit)[["time"]]

  data.frame(
    scenario = unique(df$scenario),
    growth_rate = r,
    initial_population = exp(coef(fit)[["(Intercept)"]]),
    doubling_time = log(2) / r,
    r_squared_log_space = summary(fit)$r.squared
  )
}

summary_df <- do.call(
  rbind,
  lapply(split(growth, growth$scenario), fit_scenario)
)

print(round(summary_df, 5))
