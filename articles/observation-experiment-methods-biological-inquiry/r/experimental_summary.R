# Experimental summary in R.

image_path <- file.path("data", "imaging_features.csv")
if (!file.exists(image_path)) {
  image_path <- file.path("..", "data", "imaging_features.csv")
}

cells <- read.csv(image_path)

summary_df <- aggregate(
  cbind(area_um2, mean_intensity, roundness) ~ condition,
  data = cells,
  FUN = mean
)

count_df <- aggregate(cell_id ~ condition, data = cells, FUN = length)
names(count_df)[2] <- "n_cells"

summary_df <- merge(count_df, summary_df, by = "condition")

print(round(summary_df, 3))
