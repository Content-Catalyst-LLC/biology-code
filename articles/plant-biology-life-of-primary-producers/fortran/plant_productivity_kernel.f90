! Compact plant productivity and biomass recovery kernel in Fortran.

program plant_productivity_kernel
  implicit none

  integer :: day
  real :: gpp
  real :: ra
  real :: rh
  real :: npp
  real :: nep
  real :: irradiance
  real :: alpha
  real :: amax
  real :: rd
  real :: assimilation
  real :: biomass
  real :: r
  real :: k
  real :: m
  real :: d_biomass

  gpp = 1800.0
  ra = 700.0
  rh = 680.0

  npp = gpp - ra
  nep = gpp - (ra + rh)

  print *, "NPP:", npp
  print *, "NEP:", nep

  irradiance = 1000.0
  alpha = 0.05
  amax = 18.0
  rd = 1.5

  assimilation = (alpha * irradiance * amax) / (alpha * irradiance + amax) - rd

  print *, "Assimilation:", assimilation

  biomass = 40.0
  r = 0.010
  k = 220.0
  m = 0.0025

  do day = 1, 365
    d_biomass = r * biomass * (1.0 - biomass / k) - m * biomass
    biomass = max(0.0, biomass + d_biomass)
  end do

  print *, "Final biomass:", biomass
end program plant_productivity_kernel
