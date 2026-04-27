# Biosensor signal-to-noise calculation.

measurements <- read.csv(file.path("data", "biosensor_measurements.csv"), stringsAsFactors = FALSE)

measurements$signal_to_noise <- with(
  measurements,
  (mean_signal - mean_background) / background_sd
)

measurements <- measurements[order(-measurements$signal_to_noise), ]

print(round(measurements, 4))
