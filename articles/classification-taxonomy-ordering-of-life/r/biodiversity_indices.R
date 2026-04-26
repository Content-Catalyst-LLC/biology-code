# Biodiversity-index workflow in R.

counts_path <- file.path("data", "community_counts.csv")
if (!file.exists(counts_path)) {
  counts_path <- file.path("..", "data", "community_counts.csv")
}

counts <- read.csv(counts_path)
rownames(counts) <- counts$site
counts$site <- NULL

shannon <- apply(counts, 1, function(x) {
  p <- x / sum(x)
  -sum(p[p > 0] * log(p[p > 0]))
})

bray_curtis <- function(x, y) {
  1 - (2 * sum(pmin(x, y))) / (sum(x) + sum(y))
}

bc_matrix <- outer(
  seq_len(nrow(counts)),
  seq_len(nrow(counts)),
  Vectorize(function(i, j) bray_curtis(as.numeric(counts[i, ]), as.numeric(counts[j, ])))
)

rownames(bc_matrix) <- rownames(counts)
colnames(bc_matrix) <- rownames(counts)

print(round(shannon, 4))
print(round(bc_matrix, 4))
