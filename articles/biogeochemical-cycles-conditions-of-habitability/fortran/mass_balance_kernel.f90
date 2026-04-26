! Compact biogeochemical mass-balance kernel in Fortran.
!
! Computes a simplified atmospheric carbon increment:
! dC = fossil + land_use + disturbance - land_uptake - ocean_uptake

program mass_balance_kernel
  implicit none

  real :: fossil_emissions
  real :: land_use_emissions
  real :: disturbance_release
  real :: land_uptake
  real :: ocean_uptake
  real :: carbon_increment

  fossil_emissions = 10.0
  land_use_emissions = 1.0
  disturbance_release = 0.5
  land_uptake = 3.0
  ocean_uptake = 2.6

  carbon_increment = fossil_emissions + land_use_emissions + disturbance_release - &
    land_uptake - ocean_uptake

  print *, "Net atmospheric carbon increment:", carbon_increment
end program mass_balance_kernel
