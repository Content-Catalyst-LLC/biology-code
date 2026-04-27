# Blocked design workflow in R.

data_path <- file.path("data", "blocked_design.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "blocked_design.csv")
}

data <- read.csv(data_path)

fit <- lm(response ~ treatment + block, data = data)

print(anova(fit))
print(round(coef(summary(fit)), 5))
