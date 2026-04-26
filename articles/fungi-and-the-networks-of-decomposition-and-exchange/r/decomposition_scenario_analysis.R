# Quantitative fungal ecology workflow in R.
#
# This script compares decomposition across ecological scenarios using
# temperature, moisture, substrate-quality, and fungal guild modifiers.

library(dplyr)
library(tidyr)
library(purrr)

f_temp_q10 <- function(temp, tref = 10, q10 = 2) {
  q10 ^ ((temp - tref) / 10)
}

f_moisture <- function(m, m_opt = 0.6, sigma = 0.22) {
  exp(-((m - m_opt)^2) / (2 * sigma^2))
}

f_quality <- function(lignin_n, slope = 0.03) {
  exp(-slope * lignin_n)
}

guild_effect <- function(guild) {
  case_when(
    guild == "white_rot" ~ 1.20,
    guild == "brown_rot" ~ 0.95,
    guild == "mixed_saprotroph" ~ 1.00,
    guild == "disturbance_simplified" ~ 0.72,
    TRUE ~ 1.00
  )
}

decomp_curve <- function(M0, k0, temp, moisture, lignin_n, guild, time_steps = 0:24) {
  k_eff <- k0 *
    f_temp_q10(temp) *
    f_moisture(moisture) *
    f_quality(lignin_n) *
    guild_effect(guild)

  tibble(
    time = time_steps,
    remaining_mass = M0 * exp(-k_eff * time),
    mass_lost = M0 - remaining_mass,
    cumulative_carbon_released = 0.5 * mass_lost,
    k_eff = k_eff
  )
}

sites_path <- file.path("data", "decomposition_sites.csv")

if (!file.exists(sites_path)) {
  sites_path <- file.path("..", "data", "decomposition_sites.csv")
}

sites <- read.csv(sites_path)

results <- sites %>%
  mutate(
    sim = pmap(
      list(M0, k0, temp, moisture, lignin_n, guild),
      ~ decomp_curve(..1, ..2, ..3, ..4, ..5, ..6)
    )
  ) %>%
  select(site, sim) %>%
  unnest(sim)

rate_summary <- results %>%
  group_by(site) %>%
  summarise(
    k_eff = first(k_eff),
    mass_remaining_t24 = remaining_mass[time == 24],
    carbon_released_t24 = cumulative_carbon_released[time == 24],
    half_life = log(2) / first(k_eff),
    .groups = "drop"
  )

print(round(rate_summary, 3))
