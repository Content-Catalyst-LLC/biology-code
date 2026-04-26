# Expression matrix and PCA scaffold in R.

library(dplyr)
library(tidyr)

expr_path <- file.path("data", "expression_matrix.csv")
meta_path <- file.path("data", "sample_metadata.csv")

if (!file.exists(expr_path)) {
  expr_path <- file.path("..", "data", "expression_matrix.csv")
  meta_path <- file.path("..", "data", "sample_metadata.csv")
}

expr_df <- read.csv(expr_path)
meta_df <- read.csv(meta_path)

long_df <- expr_df %>%
  pivot_longer(-gene, names_to = "sample", values_to = "count") %>%
  left_join(meta_df, by = "sample")

summary_df <- long_df %>%
  group_by(gene, group) %>%
  summarise(mean_count = mean(count), .groups = "drop") %>%
  pivot_wider(names_from = group, values_from = mean_count) %>%
  mutate(
    log2_fc = log2((treated + 1) / (control + 1)),
    mean_expression = (treated + control) / 2
  ) %>%
  arrange(desc(abs(log2_fc)))

print(summary_df)

expr_mat <- as.matrix(expr_df[, -1])
rownames(expr_mat) <- expr_df$gene

log_expr <- log2(expr_mat + 1)
pca <- prcomp(t(log_expr), center = TRUE, scale. = TRUE)

pca_df <- as.data.frame(pca$x[, 1:2]) %>%
  tibble::rownames_to_column("sample") %>%
  left_join(meta_df, by = "sample")

print(pca_df)
