# Integrated expression and accessibility workflow in R.

library(dplyr)

reg_path <- file.path("data", "expression_accessibility.csv")

if (!file.exists(reg_path)) {
  reg_path <- file.path("..", "data", "expression_accessibility.csv")
}

reg_df <- read.csv(reg_path) %>%
  mutate(
    log2FC_expr = log2((treated_expr + 1e-6) / (control_expr + 1e-6)),
    delta_access = treated_access - control_access,
    regulatory_pattern = case_when(
      log2FC_expr > 0 & delta_access > 0 ~ "up_with_opening",
      log2FC_expr < 0 & delta_access < 0 ~ "down_with_closing",
      TRUE ~ "discordant_or_complex"
    )
  )

print(reg_df %>% arrange(desc(log2FC_expr)))
