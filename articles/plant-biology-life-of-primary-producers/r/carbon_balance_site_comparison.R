# Carbon balance and site comparison in R.

library(dplyr)

sites_path <- file.path("data", "productivity_sites.csv")

if (!file.exists(sites_path)) {
  sites_path <- file.path("..", "data", "productivity_sites.csv")
}

sites <- read.csv(sites_path) %>%
  mutate(
    NPP = GPP - Ra,
    NEP = GPP - (Ra + Rh),
    carbon_balance_class = case_when(
      NEP > 250 ~ "strong_net_sink",
      NEP > 0 ~ "weak_net_sink",
      TRUE ~ "net_source_or_unstable"
    )
  )

print(sites)
