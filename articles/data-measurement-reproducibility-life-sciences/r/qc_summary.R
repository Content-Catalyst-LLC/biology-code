# QC summary by batch.

data_path <- file.path("data", "measurements.csv")
if (!file.exists(data_path)) {
  data_path <- file.path("..", "data", "measurements.csv")
}

measurements <- read.csv(data_path)

qc_counts <- aggregate(
  sample_id ~ batch_id + qc_flag,
  data = measurements,
  FUN = length
)

names(qc_counts)[names(qc_counts) == "sample_id"] <- "n_records"

batch_totals <- aggregate(
  sample_id ~ batch_id,
  data = measurements,
  FUN = length
)

names(batch_totals)[names(batch_totals) == "sample_id"] <- "batch_total"

summary_df <- merge(qc_counts, batch_totals, by = "batch_id")
summary_df$flag_fraction <- summary_df$n_records / summary_df$batch_total

print(summary_df[order(summary_df$batch_id, summary_df$qc_flag), ])
