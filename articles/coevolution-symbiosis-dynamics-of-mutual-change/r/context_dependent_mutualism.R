# Context-dependent host-symbiont outcome screening in R.

library(dplyr)

env <- tibble(
  stress = seq(0, 1, by = 0.02)
) %>%
  mutate(
    benefit = 0.8 - 0.3 * stress,
    cost = 0.2 + 0.4 * stress,
    net_effect = benefit - cost,
    relationship_state = case_when(
      net_effect > 0.05 ~ "beneficial",
      net_effect >= -0.05 ~ "near_neutral",
      TRUE ~ "costly"
    )
  )

threshold <- env %>%
  filter(net_effect <= 0) %>%
  slice(1)

print(head(env))
print(threshold)
