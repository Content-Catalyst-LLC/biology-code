# Comparative genomics workflow in R.
#
# Builds pairwise sequence distances and exploratory clustering.

library(dplyr)
library(tidyr)
library(purrr)
library(stringr)

sequence_path <- file.path("data", "sequences.csv")

if (!file.exists(sequence_path)) {
  sequence_path <- file.path("..", "data", "sequences.csv")
}

sequence_df <- read.csv(sequence_path)
seqs <- setNames(sequence_df$sequence, sequence_df$taxon)

pair_dist <- function(s1, s2) {
  x <- str_split(s1, "", simplify = TRUE)
  y <- str_split(s2, "", simplify = TRUE)

  mismatches <- sum(x != y)
  L <- length(x)
  p <- mismatches / L
  jc <- ifelse(p >= 0.75, NA_real_, -(3/4) * log(1 - (4/3) * p))

  tibble(
    mismatches = mismatches,
    p_distance = p,
    jukes_cantor = jc
  )
}

pairs <- expand.grid(
  seq1 = names(seqs),
  seq2 = names(seqs),
  stringsAsFactors = FALSE
) %>%
  as_tibble() %>%
  filter(seq1 < seq2) %>%
  mutate(res = map2(seq1, seq2, ~ pair_dist(seqs[[.x]], seqs[[.y]]))) %>%
  unnest(res)

print(pairs)

taxa <- names(seqs)
dist_mat <- matrix(
  0,
  nrow = length(taxa),
  ncol = length(taxa),
  dimnames = list(taxa, taxa)
)

for (i in seq_len(nrow(pairs))) {
  a <- pairs$seq1[i]
  b <- pairs$seq2[i]
  dist_mat[a, b] <- pairs$jukes_cantor[i]
  dist_mat[b, a] <- pairs$jukes_cantor[i]
}

print(round(dist_mat, 4))

hc <- hclust(as.dist(dist_mat), method = "average")
print(hc)
