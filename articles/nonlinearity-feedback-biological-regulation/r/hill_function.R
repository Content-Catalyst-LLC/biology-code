# Hill function threshold workflow.

hill_response <- function(signal, k_half, hill_coefficient) {
  signal^hill_coefficient / (k_half^hill_coefficient + signal^hill_coefficient)
}

signals <- c(20, 40, 60, 80)
hill_values <- c(1, 2, 4, 8)

rows <- lapply(hill_values, function(n) {
  response <- hill_response(signals, 40, n)

  data.frame(
    hill_coefficient = n,
    response_at_20 = response[1],
    response_at_40 = response[2],
    response_at_60 = response[3],
    response_at_80 = response[4]
  )
})

summary_df <- do.call(rbind, rows)

print(round(summary_df, 5))
