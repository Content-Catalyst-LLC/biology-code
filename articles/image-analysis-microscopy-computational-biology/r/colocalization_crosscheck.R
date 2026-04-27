# Colocalization cross-check in R.

pixels <- read.csv(file.path("data", "colocalization_pixels.csv"), stringsAsFactors = FALSE)

pearson <- cor(pixels$channel_a, pixels$channel_b)
a_positive <- pixels$channel_a >= 30
b_positive <- pixels$channel_b >= 30

summary_table <- data.frame(
  metric = c("pearson_colocalization", "overlap_fraction_a_positive", "overlap_fraction_b_positive"),
  value = c(
    pearson,
    sum(a_positive & b_positive) / max(sum(a_positive), 1),
    sum(a_positive & b_positive) / max(sum(b_positive), 1)
  )
)

print(round(summary_table, 5))
