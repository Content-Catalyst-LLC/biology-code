! Compact metabolism numerical kernel in Fortran.

program metabolism_kernel
  implicit none

  real :: n0
  real :: n48
  real :: r
  real :: td
  real :: K
  real :: logistic_96
  real :: substrate
  real :: mu_max
  real :: Ks
  real :: mu
  real :: delta_x
  real :: delta_s
  real :: Yxs
  real :: maintenance
  real :: substrate_input
  real :: maintenance_fraction
  real :: biomass_flux
  real :: product_flux
  real :: objective

  n0 = 1.0e5
  r = log(4.0) / 48.0
  n48 = n0 * exp(r * 48.0)
  td = log(2.0) / r

  K = 1.0e6
  logistic_96 = K / (1.0 + ((K - n0) / n0) * exp(-0.035 * 96.0))

  substrate = 5.0
  mu_max = 0.08
  Ks = 2.5
  mu = mu_max * substrate / (Ks + substrate)

  delta_x = 0.75
  delta_s = 1.50
  Yxs = delta_x / delta_s

  maintenance = 0.70
  substrate_input = 2.0
  maintenance_fraction = maintenance / substrate_input

  biomass_flux = 8.0
  product_flux = 2.0
  objective = biomass_flux + 0.25 * product_flux

  print *, "Exponential abundance at 48h:", n48
  print *, "Doubling time:", td
  print *, "Logistic abundance at 96h:", logistic_96
  print *, "Monod growth rate:", mu
  print *, "Biomass yield:", Yxs
  print *, "Maintenance fraction:", maintenance_fraction
  print *, "Toy flux objective:", objective
end program metabolism_kernel
