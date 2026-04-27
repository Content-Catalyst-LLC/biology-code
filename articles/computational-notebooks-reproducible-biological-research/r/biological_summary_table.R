# Reproducible biological summary table for notebook-oriented research.

samples <- read.csv(file.path("data", "biological_sample_metadata.csv"), stringsAsFactors = FALSE)

required_columns <- c(
  "sample_id",
  "species",
  "tissue_or_environment",
  "treatment",
  "batch",
  "collection_site",
  "collection_date",
  "response_value"
)

missing_columns <- setdiff(required_columns, names(samples))

if (length(missing_columns) > 0) {
  stop(paste("Missing required columns:", paste(missing_columns, collapse = ", ")))
}

if (any(duplicated(samples$sample_id))) {
  stop("Sample identifiers must be unique.")
}

summary_table <- aggregate(
  response_value ~ species + treatment,
  data = samples,
  FUN = function(x) c(mean = mean(x), sd = sd(x), n = length(x))
)

print(summary_table)
