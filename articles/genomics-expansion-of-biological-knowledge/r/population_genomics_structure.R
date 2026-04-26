# Population genomics workflow in R.
#
# Estimates nucleotide diversity and FST-style differentiation.

library(dplyr)

variant_path <- file.path("data", "variant_site_summary.csv")

if (!file.exists(variant_path)) {
  variant_path <- file.path("..", "data", "variant_site_summary.csv")
}

geno_df <- read.csv(variant_path) %>%
  mutate(
    p1 = alt_count_pop1 / n_chrom_pop1,
    p2 = alt_count_pop2 / n_chrom_pop2,
    pi1 = 2 * p1 * (1 - p1),
    pi2 = 2 * p2 * (1 - p2),
    pbar = (p1 + p2) / 2,
    HT = 2 * pbar * (1 - pbar),
    HS = (pi1 + pi2) / 2,
    fst = ifelse(HT > 0, (HT - HS) / HT, 0),
    delta_p = abs(p1 - p2)
  )

summary_tbl <- geno_df %>%
  summarise(
    mean_pi1 = mean(pi1),
    mean_pi2 = mean(pi2),
    mean_fst = mean(fst),
    mean_delta_p = mean(delta_p)
  )

print(summary_tbl)
print(geno_df %>% arrange(desc(fst)))
