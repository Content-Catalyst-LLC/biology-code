# Genomics count normalization and log fold-change scaffold.
#
# This is a teaching scaffold, not a substitute for DESeq2, edgeR,
# limma-voom, or a validated Bioconductor workflow.
#
# Run from article directory:
#   Rscript r/03_genomics_count_workflow.R

counts_path <- file.path("data", "genomics_counts.csv")
metadata_path <- file.path("data", "genomics_metadata.csv")
output_path <- file.path("outputs", "tables", "genomics_count_summary.csv")

dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)

counts_table <- read.csv(counts_path, stringsAsFactors = FALSE)
metadata <- read.csv(metadata_path, stringsAsFactors = FALSE)

gene_ids <- counts_table$gene_id
count_matrix <- as.matrix(counts_table[, setdiff(names(counts_table), "gene_id")])
rownames(count_matrix) <- gene_ids
storage.mode(count_matrix) <- "numeric"

if (!all(metadata$sample_id %in% colnames(count_matrix))) {
  stop("All metadata sample identifiers must appear in the count matrix.")
}

count_matrix <- count_matrix[, metadata$sample_id]

library_sizes <- colSums(count_matrix)
cpm <- t(t(count_matrix) / library_sizes) * 1e6

control_samples <- metadata$sample_id[metadata$condition == "control"]
treated_samples <- metadata$sample_id[metadata$condition == "treated"]

pseudocount <- 1

log2_fold_change <- log2(
  (rowMeans(cpm[, treated_samples, drop = FALSE]) + pseudocount) /
  (rowMeans(cpm[, control_samples, drop = FALSE]) + pseudocount)
)

summary_table <- data.frame(
  gene_id = rownames(count_matrix),
  raw_count_total = rowSums(count_matrix),
  mean_cpm_control = rowMeans(cpm[, control_samples, drop = FALSE]),
  mean_cpm_treated = rowMeans(cpm[, treated_samples, drop = FALSE]),
  log2_fold_change = log2_fold_change,
  low_count_flag = rowSums(count_matrix) < 50,
  row.names = NULL
)

write.csv(summary_table, output_path, row.names = FALSE)

print(round(summary_table, 5))

if (requireNamespace("DESeq2", quietly = TRUE)) {
  message("DESeq2 is installed. A validated DESeq2 workflow can be added for real RNA-seq analysis.")
} else {
  message("DESeq2 not installed; using teaching scaffold only.")
}
