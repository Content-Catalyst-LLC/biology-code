# Factorial design workflow in R.

data_path <- file.path("data", "factorial_design_observations.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "factorial_design_observations.csv")
}

data <- read.csv(data_path)

fit <- lm(response ~ temperature * nutrient, data = data)

print(aggregate(response ~ temperature + nutrient, data = data, FUN = mean))
print(anova(fit))
print(round(coef(summary(fit)), 5))
