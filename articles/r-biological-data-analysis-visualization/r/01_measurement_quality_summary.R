# Biological measurement quality summary.
#
# Run from article directory:
#   Rscript r/01_measurement_quality_summary.R

input_path <- file.path("data", "measurements.csv")
output_path <- file.path("outputs", "tables", "measurement_summary.csv")

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

measurements <- read.csv(input_path, stringsAsFactors = FALSE)

measurements$value <- suppressWarnings(as.numeric(measurements$value))

valid_data <- measurements[
  measurements$qc_flag == "pass" & !is.na(measurements$value),
]

summary_function <- function(x) {
  c(
    n = length(x),
    mean = mean(x),
    sd = sd(x),
    se = sd(x) / sqrt(length(x)),
    cv = sd(x) / mean(x),
    min = min(x),
    max = max(x)
  )
}

summary_by_treatment <- aggregate(
  value ~ treatment,
  data = valid_data,
  FUN = summary_function
)

summary_table <- do.call(data.frame, summary_by_treatment)

names(summary_table) <- c(
  "treatment",
  "n",
  "mean",
  "sd",
  "se",
  "coefficient_of_variation",
  "min",
  "max"
)

summary_table$n <- as.integer(summary_table$n)

write.csv(summary_table, output_path, row.names = FALSE)

print(round(summary_table, 5))
