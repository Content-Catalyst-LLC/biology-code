# Saturating biological response workflow.

saturating_response <- function(signal, vmax, k_half) {
  vmax * signal / (k_half + signal)
}

signals <- seq(0, 100, by = 1)
response <- saturating_response(signals, vmax = 1.0, k_half = 20)

summary_df <- data.frame(
  response_at_5 = saturating_response(5, 1.0, 20),
  response_at_20 = saturating_response(20, 1.0, 20),
  response_at_80 = saturating_response(80, 1.0, 20),
  max_response = max(response)
)

print(round(summary_df, 5))
