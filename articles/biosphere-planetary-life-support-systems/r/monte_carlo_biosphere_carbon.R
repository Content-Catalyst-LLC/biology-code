# Monte Carlo biosphere carbon-uptake scenario model.
#
# This workflow simulates uncertain land and ocean uptake under changing
# disturbance pressure. It is a compact research-style prototype rather than
# a full Earth-system model.

set.seed(123)

simulate_biosphere <- function(
  years = 50,
  n_sims = 1000,
  emissions_start = 11.0,
  emissions_growth = 0.01,
  land_uptake_mean = 3.2,
  land_uptake_sd = 0.5,
  ocean_uptake_mean = 2.7,
  ocean_uptake_sd = 0.3,
  disturbance_mean = 0.6,
  disturbance_sd = 0.25,
  shock_prob = 0.08,
  shock_mult = 1.8
) {
  net_atm <- matrix(NA_real_, nrow = years, ncol = n_sims)

  for (sim in seq_len(n_sims)) {
    for (year in seq_len(years)) {
      emissions_t <- emissions_start * (1 + emissions_growth)^(year - 1)

      land_uptake_t <- max(0, rnorm(1, land_uptake_mean, land_uptake_sd))
      ocean_uptake_t <- max(0, rnorm(1, ocean_uptake_mean, ocean_uptake_sd))
      disturbance_t <- max(0, rnorm(1, disturbance_mean, disturbance_sd))

      if (runif(1) < shock_prob) {
        disturbance_t <- disturbance_t * shock_mult
      }

      net_atm[year, sim] <- emissions_t + disturbance_t -
        land_uptake_t - ocean_uptake_t
    }
  }

  list(
    net_atm = net_atm,
    yearly_mean = rowMeans(net_atm),
    yearly_q05 = apply(net_atm, 1, quantile, probs = 0.05),
    yearly_q95 = apply(net_atm, 1, quantile, probs = 0.95)
  )
}

result <- simulate_biosphere()

summary <- data.frame(
  final_year_mean = tail(result$yearly_mean, 1),
  final_year_q05 = tail(result$yearly_q05, 1),
  final_year_q95 = tail(result$yearly_q95, 1)
)

print(round(summary, 3))
