# Wright-Fisher mutation-selection-drift workflow in R.
#
# Tracks a deleterious allele under recurrent mutation and finite-population drift.

library(dplyr)
library(purrr)

simulate_wf <- function(
  generations = 400,
  N = 500,
  q0 = 0.001,
  mu = 1e-5,
  s = 0.02,
  h = 0.5,
  replicates = 100,
  seed = 123
) {
  set.seed(seed)
  results <- vector("list", replicates)

  for (rep in seq_len(replicates)) {
    q <- numeric(generations + 1)
    q[1] <- q0

    for (t in 1:generations) {
      qt <- q[t]
      pt <- 1 - qt

      w_AA <- 1.0
      w_Aa <- 1 - h * s
      w_aa <- 1 - s

      wbar <- pt^2 * w_AA + 2 * pt * qt * w_Aa + qt^2 * w_aa

      q_sel <- (qt^2 * w_aa + pt * qt * w_Aa) / wbar
      q_mut <- q_sel + (1 - q_sel) * mu

      count_a <- rbinom(1, size = 2 * N, prob = q_mut)
      q[t + 1] <- count_a / (2 * N)
    }

    results[[rep]] <- tibble(
      replicate = rep,
      generation = 0:generations,
      q = q
    )
  }

  bind_rows(results)
}

wf_df <- simulate_wf()

wf_summary <- wf_df %>%
  group_by(generation) %>%
  summarise(
    mean_q = mean(q),
    sd_q = sd(q),
    .groups = "drop"
  )

print(wf_summary %>% slice(c(1, 50, 100, 200, 300, 401)))
