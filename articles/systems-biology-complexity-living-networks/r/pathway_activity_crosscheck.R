# Pathway activity cross-check in R.

expression <- read.csv(file.path("data", "expression.csv"), stringsAsFactors = FALSE)
gene_sets <- read.csv(file.path("data", "pathway_gene_sets.csv"), stringsAsFactors = FALSE)

merged <- merge(gene_sets, expression, by.x = "gene", by.y = "gene", all.x = TRUE)

activity <- aggregate(
  z_score ~ pathway,
  data = merged,
  FUN = mean
)

names(activity) <- c("pathway", "pathway_activity")

print(round(activity, 5))
