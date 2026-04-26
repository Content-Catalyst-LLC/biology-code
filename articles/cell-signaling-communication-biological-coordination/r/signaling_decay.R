# Signaling decay and half-life estimation in R.

decay_path <- file.path("data", "signaling_decay.csv")

if (!file.exists(decay_path)) {
  decay_path <- file.path("..", "data", "signaling_decay.csv")
}

decay_df <- read.csv(decay_path)

fit <- lm(log(signal) ~ time_min, data = decay_df)

k_est <- -coef(fit)[["time_min"]]
m0_est <- exp(coef(fit)[["(Intercept)"]])
half_life <- log(2) / k_est

summary_df <- data.frame(
  k_est = k_est,
  m0_est = m0_est,
  half_life_min = half_life
)

decay_df$predicted_signal <- exp(predict(fit))
decay_df$residual <- decay_df$signal - decay_df$predicted_signal

print(round(summary_df, 4))
print(round(decay_df, 4))
