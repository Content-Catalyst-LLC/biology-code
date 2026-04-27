# Threshold segmentation cross-check in R.

pixels <- data.frame(
  pixel_id = 1:10,
  intensity = c(18, 22, 35, 68, 91, 110, 74, 42, 20, 15)
)

threshold <- 65
pixels$mask <- pixels$intensity >= threshold

summary_table <- data.frame(
  threshold = threshold,
  foreground_pixels = sum(pixels$mask),
  mean_foreground_intensity = mean(pixels$intensity[pixels$mask])
)

print(round(summary_table, 5))
