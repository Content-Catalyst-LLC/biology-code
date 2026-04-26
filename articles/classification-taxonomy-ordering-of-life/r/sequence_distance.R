# Sequence-distance workflow in R.

seq_path <- file.path("data", "aligned_sequences.csv")
if (!file.exists(seq_path)) {
  seq_path <- file.path("..", "data", "aligned_sequences.csv")
}

seq_df <- read.csv(seq_path)

p_distance <- function(a, b) {
  a_chars <- strsplit(a, "")[[1]]
  b_chars <- strsplit(b, "")[[1]]
  if (length(a_chars) != length(b_chars)) stop("Sequences must be aligned.")
  sum(a_chars != b_chars) / length(a_chars)
}

jukes_cantor <- function(p) {
  if (p >= 0.75) return(NA_real_)
  -0.75 * log(1 - (4 / 3) * p)
}

taxa <- seq_df$taxon
p_mat <- matrix(0, nrow = length(taxa), ncol = length(taxa), dimnames = list(taxa, taxa))
jc_mat <- p_mat

for (i in seq_along(taxa)) {
  for (j in seq_along(taxa)) {
    p <- p_distance(seq_df$sequence[i], seq_df$sequence[j])
    p_mat[i, j] <- p
    jc_mat[i, j] <- jukes_cantor(p)
  }
}

print(round(p_mat, 4))
print(round(jc_mat, 4))
