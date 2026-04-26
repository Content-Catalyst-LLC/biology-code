# Multi-population FST-style structure and bottleneck screening in R.

library(dplyr)
library(tidyr)

freq_path <- file.path("data", "multipop_allele_frequencies.csv")

if (!file.exists(freq_path)) {
  freq_path <- file.path("..", "data", "multipop_allele_frequencies.csv")
}

freqs <- read.csv(freq_path)
pop_cols <- grep("^pop", names(freqs), value = TRUE)

long_df <- freqs %>%
  pivot_longer(all_of(pop_cols), names_to = "population", values_to = "p")

fst_summary <- long_df %>%
  group_by(locus) %>%
  summarise(
    pbar = mean(p),
    HS = mean(2 * p * (1 - p)),
    HT = 2 * pbar * (1 - pbar),
    fst = ifelse(HT > 0, (HT - HS) / HT, 0),
    .groups = "drop"
  ) %>%
  arrange(desc(fst))

print(fst_summary)
cat("Genome-wide mean FST-style value:", round(mean(fst_summary$fst), 4), "\n")
