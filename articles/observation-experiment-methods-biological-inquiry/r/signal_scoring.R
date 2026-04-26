# Signal-quality scoring in R.

signal_path <- file.path("data", "experimental_signal_scores.csv")
if (!file.exists(signal_path)) {
  signal_path <- file.path("..", "data", "experimental_signal_scores.csv")
}

signals <- read.csv(signal_path)

signals$signal_quality_score <-
  0.30 * signals$signal_strength +
  0.30 * signals$reproducibility +
  0.25 * signals$control_separation -
  0.15 * signals$noise_penalty

signals$signal_class <- ifelse(
  signals$signal_quality_score >= 0.72,
  "strong_signal",
  ifelse(signals$signal_quality_score >= 0.50, "moderate_signal", "weak_or_uncertain_signal")
)

signals <- signals[order(-signals$signal_quality_score), ]

print(round(signals, 3))
