# Multi-locus diversity workflow in R.
#
# Simulates allele frequencies across two populations and estimates
# nucleotide diversity and FST-like differentiation.

library(dplyr)

set.seed(42)

loci <- 500
p_ancestral <- runif(loci, 0.05, 0.95)

n1 <- 150
n2 <- 60

p1 <- rbinom(loci, size = n1, prob = p_ancestral) / n1
p2 <- rbinom(loci, size = n2, prob = p_ancestral) / n2

div_df <- tibble(
  locus = 1:loci,
  p1 = p1,
  p2 = p2
) %>%
  mutate(
    pi1 = 2 * p1 * (1 - p1),
    pi2 = 2 * p2 * (1 - p2),
    pbar = (p1 + p2) / 2,
    HT = 2 * pbar * (1 - pbar),
    HS = (pi1 + pi2) / 2,
    fst = ifelse(HT > 0, (HT - HS) / HT, 0),
    delta_p = abs(p1 - p2)
  )

summary_tbl <- div_df %>%
  summarise(
    mean_pi1 = mean(pi1),
    mean_pi2 = mean(pi2),
    mean_fst = mean(fst),
    mean_delta_p = mean(delta_p)
  )

print(summary_tbl)

top_fst <- div_df %>%
  arrange(desc(fst)) %>%
  slice_head(n = 20)

print(top_fst)
