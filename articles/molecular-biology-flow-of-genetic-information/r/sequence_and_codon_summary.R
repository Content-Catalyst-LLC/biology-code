# Sequence comparison, codon usage, and GC-content workflow in R.

library(dplyr)
library(stringr)
library(tidyr)
library(purrr)

sequence_path <- file.path("data", "sequences.csv")
coding_path <- file.path("data", "coding_sequence.txt")

if (!file.exists(sequence_path)) {
  sequence_path <- file.path("..", "data", "sequences.csv")
  coding_path <- file.path("..", "data", "coding_sequence.txt")
}

sequence_df <- read.csv(sequence_path)
seqs <- setNames(sequence_df$sequence, sequence_df$sample)

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

coding_seq <- readLines(coding_path, warn = FALSE)[1]

codons <- str_sub(
  coding_seq,
  seq(1, nchar(coding_seq), by = 3),
  seq(3, nchar(coding_seq), by = 3)
)

codons <- codons[codons != ""]

codon_df <- tibble(codon = codons) %>%
  count(codon, sort = TRUE) %>%
  mutate(fraction = n / sum(n))

bases <- str_split(coding_seq, "", simplify = TRUE)
gc_fraction <- mean(bases %in% c("G", "C"))

print(codon_df)
print(tibble(gc_fraction = gc_fraction))
