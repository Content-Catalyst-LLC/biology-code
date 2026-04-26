# Regulatory-state switching and methylation summary in R.

library(dplyr)

meth_path <- file.path("data", "methylation_counts.csv")

if (!file.exists(meth_path)) {
  meth_path <- file.path("..", "data", "methylation_counts.csv")
}

simulate_state_switch <- function(
  times,
  kon = 0.35,
  koff = 0.08,
  p_on0 = 0.05
) {
  p_on <- numeric(length(times))
  p_on[1] <- p_on0

  for (i in 2:length(times)) {
    dt <- times[i] - times[i - 1]
    dp <- kon * (1 - p_on[i - 1]) - koff * p_on[i - 1]
    p_on[i] <- min(max(p_on[i - 1] + dp * dt, 0), 1)
  }

  tibble(time = times, p_on = p_on, p_off = 1 - p_on)
}

times <- seq(0, 25, by = 0.1)
state_df <- simulate_state_switch(times)

print(state_df %>% slice_head(n = 12))
print(state_df %>% slice_tail(n = 12))

meth_df <- read.csv(meth_path) %>%
  mutate(
    meth_fraction = methylated / (methylated + unmethylated)
  )

print(meth_df)
