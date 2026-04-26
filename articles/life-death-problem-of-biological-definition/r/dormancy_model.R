# Dormancy loss and reactivation model in R.

scenario_path <- file.path("data", "dormancy_scenarios.csv")

if (!file.exists(scenario_path)) {
  scenario_path <- file.path("..", "data", "dormancy_scenarios.csv")
}

simulate_dormancy <- function(dormant_initial, active_initial, mortality_rate, reactivation_rate, time_end, dt) {
  time <- seq(0, time_end, by = dt)

  dormant <- numeric(length(time))
  active <- numeric(length(time))
  dead_or_lost <- numeric(length(time))

  dormant[1] <- dormant_initial
  active[1] <- active_initial
  dead_or_lost[1] <- 0

  for (i in 2:length(time)) {
    d_dormant <- -(mortality_rate + reactivation_rate) * dormant[i - 1]
    d_active <- reactivation_rate * dormant[i - 1]
    d_lost <- mortality_rate * dormant[i - 1]

    dormant[i] <- max(dormant[i - 1] + d_dormant * dt, 0)
    active[i] <- active[i - 1] + d_active * dt
    dead_or_lost[i] <- dead_or_lost[i - 1] + d_lost * dt
  }

  data.frame(
    time = time,
    dormant = dormant,
    active = active,
    dead_or_lost = dead_or_lost
  )
}

scenarios <- read.csv(scenario_path)

rows <- lapply(seq_len(nrow(scenarios)), function(i) {
  s <- scenarios[i, ]

  sim <- simulate_dormancy(
    s$dormant_initial,
    s$active_initial,
    s$mortality_rate,
    s$reactivation_rate,
    s$time_end,
    s$dt
  )

  initial_total <- s$dormant_initial + s$active_initial

  data.frame(
    scenario = s$scenario,
    final_dormant = tail(sim$dormant, 1),
    final_active = tail(sim$active, 1),
    final_dead_or_lost = tail(sim$dead_or_lost, 1),
    retained_viable_fraction = (tail(sim$dormant, 1) + tail(sim$active, 1)) / initial_total,
    activated_fraction = tail(sim$active, 1) / initial_total
  )
})

summary_df <- do.call(rbind, rows)

print(round(summary_df, 5))
