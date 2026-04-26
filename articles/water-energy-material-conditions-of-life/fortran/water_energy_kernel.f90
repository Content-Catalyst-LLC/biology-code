! Compact water-energy biology numerical kernel in Fortran.

program water_energy_kernel
  implicit none

  real :: R_gas
  real :: osmotic_pressure
  real :: water_potential
  real :: homeostatic_state
  real :: r
  real :: abundance_48
  real :: doubling_time
  real :: monod
  real :: oxygen_rate

  R_gas = 0.082057

  osmotic_pressure = 1.0 * 0.30 * R_gas * 298.0
  water_potential = -0.60 + 0.45 + 0.01 - 0.02
  homeostatic_state = 2.0 + (10.0 - 2.0) * exp(-0.4 * 5.0)

  r = log(4.0) / 48.0
  abundance_48 = 1.0e5 * exp(r * 48.0)
  doubling_time = log(2.0) / r

  monod = 0.08 * 4.0 / (2.5 + 4.0)
  oxygen_rate = 1.0 * 4.0 / (2.0 + 4.0)

  print *, "Osmotic pressure atm:", osmotic_pressure
  print *, "Water potential MPa:", water_potential
  print *, "Homeostatic state at t=5:", homeostatic_state
  print *, "Abundance at 48h:", abundance_48
  print *, "Doubling time:", doubling_time
  print *, "Monod rate:", monod
  print *, "Oxygen-limited rate:", oxygen_rate
end program water_energy_kernel
