# Membrane permeability flux workflow in R.

transport_path <- file.path("data", "membrane_transport_observations.csv")

if (!file.exists(transport_path)) {
  transport_path <- file.path("..", "data", "membrane_transport_observations.csv")
}

transport <- read.csv(transport_path)

transport$flux_concentration_units_um_s <-
  transport$permeability_um_s *
  (transport$external_concentration - transport$internal_concentration)

transport$area_scaled_flux <-
  transport$flux_concentration_units_um_s * transport$membrane_area_um2

print(round(transport, 5))
