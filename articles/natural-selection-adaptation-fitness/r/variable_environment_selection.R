# Variable-environment selection workflow in R.

library(dplyr)

simulate_variable_selection <- function(
  generations = 120,
  p0 = 0.5,
  env_cycle = c("habitat1", "habitat2"),
  fit_table = list(
    habitat1 = c(w_AA = 1.10, w_Aa = 1.00, w_aa = 0.85),
    habitat2 = c(w_AA = 0.80, w_Aa = 1.00, w_aa = 1.10)
  )
) {
  p <- numeric(generations + 1)
  env <- character(generations + 1)

  p[1] <- p0
  env[1] <- "start"

  for (t in 1:generations) {
    current_env <- env_cycle[((t - 1) %% length(env_cycle)) + 1]
    env[t + 1] <- current_env

    w <- fit_table[[current_env]]
    pt <- p[t]
    qt <- 1 - pt

    wbar <- pt^2 * w["w_AA"] + 2 * pt * qt * w["w_Aa"] + qt^2 * w["w_aa"]
    p[t + 1] <- (pt^2 * w["w_AA"] + pt * qt * w["w_Aa"]) / wbar
  }

  tibble(
    generation = 0:generations,
    p = p,
    environment = env
  )
}

variable_selection <- simulate_variable_selection()

print(variable_selection %>% slice_head(n = 12))
print(variable_selection %>% slice_tail(n = 12))
