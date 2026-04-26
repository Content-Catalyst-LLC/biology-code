# Sequence distance matrix and clustering input in R.

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

distance_fun <- function(x, y) {
  sx <- str_split(x, "", simplify = TRUE)
  sy <- str_split(y, "", simplify = TRUE)

  mismatches <- sum(sx != sy)
  L <- length(sx)
  p <- mismatches / L
  jc <- ifelse(p >= 0.75, NA_real_, -(3/4) * log(1 - (4/3) * p))

  tibble(
    mismatches = mismatches,
    p_distance = p,
    jukes_cantor = jc
  )
}

pairs <- expand.grid(
  taxon1 = names(seqs),
  taxon2 = names(seqs),
  stringsAsFactors = FALSE
) %>%
  as_tibble() %>%
  filter(taxon1 < taxon2) %>%
  mutate(res = map2(taxon1, taxon2, ~ distance_fun(seqs[[.x]], seqs[[.y]]))) %>%
  unnest(res)

print(pairs)

taxa <- names(seqs)
dist_mat <- matrix(
  0,
  length(taxa),
  length(taxa),
  dimnames = list(taxa, taxa)
)

for (i in seq_len(nrow(pairs))) {
  a <- pairs$taxon1[i]
  b <- pairs$taxon2[i]
  dist_mat[a, b] <- pairs$jukes_cantor[i]
  dist_mat[b, a] <- pairs$jukes_cantor[i]
}

print(round(dist_mat, 4))

hc <- hclust(as.dist(dist_mat), method = "average")
print(hc)
