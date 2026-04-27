# Ecological diversity and ordination scaffold.
#
# Run from article directory:
#   Rscript r/02_ecology_diversity_ordination.R

input_path <- file.path("data", "ecology_counts.csv")
output_path <- file.path("outputs", "tables", "ecology_diversity_ordination.csv")

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

ecology <- read.csv(input_path, stringsAsFactors = FALSE)
ecology$count <- as.numeric(ecology$count)

if (any(ecology$count < 0, na.rm = TRUE)) {
  stop("Species counts must be non-negative.")
}

sites <- unique(ecology$site)
species <- unique(ecology$species)

community_matrix <- matrix(
  0,
  nrow = length(sites),
  ncol = length(species),
  dimnames = list(sites, species)
)

for (i in seq_len(nrow(ecology))) {
  community_matrix[ecology$site[i], ecology$species[i]] <- ecology$count[i]
}

shannon_diversity <- function(counts) {
  positive_counts <- counts[counts > 0]
  proportions <- positive_counts / sum(positive_counts)
  -sum(proportions * log(proportions))
}

bray_curtis <- function(x, y) {
  denominator <- sum(x) + sum(y)
  if (denominator == 0) return(0)
  1 - (2 * sum(pmin(x, y)) / denominator)
}

diversity_table <- data.frame(
  site = rownames(community_matrix),
  total_abundance = rowSums(community_matrix),
  richness = apply(community_matrix, 1, function(x) sum(x > 0)),
  shannon = apply(community_matrix, 1, shannon_diversity),
  row.names = NULL
)

distance_matrix <- outer(
  seq_len(nrow(community_matrix)),
  seq_len(nrow(community_matrix)),
  Vectorize(function(i, j) bray_curtis(community_matrix[i, ], community_matrix[j, ]))
)

rownames(distance_matrix) <- rownames(community_matrix)
colnames(distance_matrix) <- rownames(community_matrix)

ordination <- cmdscale(as.dist(distance_matrix), k = 2)

ordination_table <- data.frame(
  site = rownames(community_matrix),
  axis_1 = ordination[, 1],
  axis_2 = ordination[, 2],
  row.names = NULL
)

output_table <- merge(diversity_table, ordination_table, by = "site")

write.csv(output_table, output_path, row.names = FALSE)

print(round(output_table, 5))
print(round(distance_matrix, 5))
