# Hardy-Weinberg workflow in R.

hw_path <- file.path("data", "hardy_weinberg_cases.csv")
if (!file.exists(hw_path)) {
  hw_path <- file.path("..", "data", "hardy_weinberg_cases.csv")
}

cases <- read.csv(hw_path)

hardy_weinberg <- function(p) {
  q <- 1 - p
  c(AA = p^2, Aa = 2 * p * q, aa = q^2)
}

rows <- lapply(seq_len(nrow(cases)), function(i) {
  p <- cases$allele_frequency_p[i]
  freqs <- hardy_weinberg(p)

  data.frame(
    case_id = cases$case_id[i],
    p = p,
    AA = freqs[["AA"]],
    Aa = freqs[["Aa"]],
    aa = freqs[["aa"]]
  )
})

summary_df <- do.call(rbind, rows)

print(round(summary_df, 4))
