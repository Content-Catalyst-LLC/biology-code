# Biodiversity summary workflow in R.

counts_path <- file.path("data", "biodiversity_counts.csv")
if (!file.exists(counts_path)) {
  counts_path <- file.path("..", "data", "biodiversity_counts.csv")
}

counts <- read.csv(counts_path)
rownames(counts) <- counts$site
counts$site <- NULL

shannon <- apply(counts, 1, function(x) {
  p <- x / sum(x)
  -sum(p[p > 0] * log(p[p > 0]))
})

summary_df <- data.frame(
  site = rownames(counts),
  richness = rowSums(counts > 0),
  total_abundance = rowSums(counts),
  shannon_diversity = shannon
)

print(round(summary_df, 4))
