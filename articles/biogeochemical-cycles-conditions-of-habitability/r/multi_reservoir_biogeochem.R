# Multi-reservoir biogeochemical simulation.
#
# This prototype tracks carbon and reactive nitrogen across atmosphere, land,
# ocean, and a coastal receiving system under uncertain uptake and nutrient
# loading. It is compact enough for inspection and structured enough to extend.

set.seed(42)

simulate_biogeochem <- function(
  years = 60,
  n_sims = 500,
  fossil_start = 10,
  fossil_growth = 0.008,
  land_uptake_mean = 3.0,
  land_uptake_sd = 0.4,
  ocean_uptake_mean = 2.6,
  ocean_uptake_sd = 0.3,
  disturbance_mean = 0.5,
  disturbance_sd = 0.2,
  reactive_n_start = 1.0,
  reactive_n_growth = 0.015,
  coastal_assimilation_mean = 0.65,
  coastal_assimilation_sd = 0.08
) {
  atm_carbon <- matrix(NA_real_, nrow = years, ncol = n_sims)
  coastal_n_surplus <- matrix(NA_real_, nrow = years, ncol = n_sims)

  for (sim in seq_len(n_sims)) {
    carbon_state <- 0
    nitrogen_state <- 0

    for (year in seq_len(years)) {
      fossil_t <- fossil_start * (1 + fossil_growth)^(year - 1)
      land_uptake_t <- max(0, rnorm(1, land_uptake_mean, land_uptake_sd))
      ocean_uptake_t <- max(0, rnorm(1, ocean_uptake_mean, ocean_uptake_sd))
      disturbance_t <- max(0, rnorm(1, disturbance_mean, disturbance_sd))

      reactive_n_t <- reactive_n_start * (1 + reactive_n_growth)^(year - 1)
      coastal_assimilation_t <- min(
        1,
        max(0, rnorm(1, coastal_assimilation_mean, coastal_assimilation_sd))
      )

      carbon_increment <- fossil_t + disturbance_t -
        land_uptake_t - ocean_uptake_t

      carbon_state <- carbon_state + carbon_increment

      n_surplus <- reactive_n_t * (1 - coastal_assimilation_t)
      nitrogen_state <- nitrogen_state + n_surplus

      atm_carbon[year, sim] <- carbon_state
      coastal_n_surplus[year, sim] <- nitrogen_state
    }
  }

  list(
    atm_carbon = atm_carbon,
    coastal_n_surplus = coastal_n_surplus,
    carbon_mean = rowMeans(atm_carbon),
    nitrogen_mean = rowMeans(coastal_n_surplus)
  )
}

result <- simulate_biogeochem()

summary <- data.frame(
  final_year_mean_carbon_burden = tail(result$carbon_mean, 1),
  final_year_mean_nitrogen_surplus = tail(result$nitrogen_mean, 1)
)

print(round(summary, 3))
