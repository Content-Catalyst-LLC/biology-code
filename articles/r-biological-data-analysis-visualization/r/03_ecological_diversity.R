# Ecological diversity summary.
#
# Run from article directory:
#   Rscript r/03_ecological_diversity.R

input_path <- file.path("data", "species_counts.csv")
output_path <- file.path("outputs", "tables", "ecological_diversity.csv")

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

species_counts <- read.csv(input_path, stringsAsFactors = FALSE)
species_counts$count <- suppressWarnings(as.numeric(species_counts$count))

if (any(species_counts$count < 0, na.rm = TRUE)) {
  stop("Species counts cannot be negative.")
}

shannon_diversity <- function(counts) {
  positive_counts <- counts[counts > 0]
  proportions <- positive_counts / sum(positive_counts)
  -sum(proportions * log(proportions))
}

site_levels <- unique(species_counts$site)

summary_rows <- lapply(site_levels, function(site_name) {
  subset_data <- species_counts[species_counts$site == site_name, ]
  counts <- subset_data$count

  data.frame(
    site = site_name,
    habitat = unique(subset_data$habitat)[1],
    total_abundance = sum(counts, na.rm = TRUE),
    richness = sum(counts > 0, na.rm = TRUE),
    shannon_diversity = shannon_diversity(counts),
    survey_effort_hours = unique(subset_data$survey_effort_hours)[1]
  )
})

summary_table <- do.call(rbind, summary_rows)

write.csv(summary_table, output_path, row.names = FALSE)

print(round(summary_table, 5))
