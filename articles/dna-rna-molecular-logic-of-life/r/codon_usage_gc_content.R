# Codon usage and GC-content workflow in R.

library(dplyr)
library(stringr)

coding_path <- file.path("data", "coding_sequence.txt")

if (!file.exists(coding_path)) {
  coding_path <- file.path("..", "data", "coding_sequence.txt")
}

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

print(codon_df)

bases <- str_split(coding_seq, "", simplify = TRUE)
gc_fraction <- mean(bases %in% c("G", "C"))

print(tibble(gc_fraction = gc_fraction))
