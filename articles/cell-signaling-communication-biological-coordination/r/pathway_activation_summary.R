# Pathway activation summary workflow in R.

library(dplyr)

pathway_path <- file.path("data", "pathway_activation.csv")

if (!file.exists(pathway_path)) {
  pathway_path <- file.path("..", "data", "pathway_activation.csv")
}

pathway_df <- read.csv(pathway_path)

context_summary <- pathway_df %>%
  group_by(cell_context) %>%
  summarise(
    mean_activation = mean(activation_score),
    max_activation = max(activation_score),
    n_observations = n(),
    .groups = "drop"
  ) %>%
  arrange(desc(mean_activation))

print(context_summary)
print(pathway_df %>% arrange(desc(activation_score)))
