# Surface-area-to-volume scaling in R.

radius_um <- seq(1, 25, length.out = 200)

surface_area_um2 <- 4 * pi * radius_um^2
volume_um3 <- (4 / 3) * pi * radius_um^3
sa_to_volume <- surface_area_um2 / volume_um3

scaling_df <- data.frame(
  radius_um = radius_um,
  surface_area_um2 = surface_area_um2,
  volume_um3 = volume_um3,
  sa_to_volume = sa_to_volume
)

print(head(round(scaling_df, 4), 12))
print(tail(round(scaling_df, 4), 12))
