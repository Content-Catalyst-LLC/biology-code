! Compact fungal decomposition and biomass recovery kernel in Fortran.
!
! This example calculates an effective decomposition rate and simulates
! fungal biomass recovery after disturbance.

program decomposition_biomass_kernel
  implicit none

  integer, parameter :: days = 240
  integer :: day

  real :: M0
  real :: k0
  real :: temp
  real :: tref
  real :: q10
  real :: moisture
  real :: m_opt
  real :: sigma
  real :: lignin_n
  real :: slope
  real :: f_temp
  real :: f_moisture
  real :: f_quality
  real :: guild_effect
  real :: k_eff
  real :: remaining_mass

  real :: biomass
  real :: r
  real :: K
  real :: mortality
  real :: d_biomass

  M0 = 100.0
  k0 = 0.07
  temp = 18.0
  tref = 10.0
  q10 = 2.0
  moisture = 0.58
  m_opt = 0.6
  sigma = 0.22
  lignin_n = 14.0
  slope = 0.03
  guild_effect = 1.0

  f_temp = q10 ** ((temp - tref) / 10.0)
  f_moisture = exp(-((moisture - m_opt) ** 2) / (2.0 * sigma ** 2))
  f_quality = exp(-slope * lignin_n)

  k_eff = k0 * f_temp * f_moisture * f_quality * guild_effect
  remaining_mass = M0 * exp(-k_eff * 24.0)

  print *, "Effective decomposition rate:", k_eff
  print *, "Remaining mass at t=24:", remaining_mass
  print *, "Half-life:", log(2.0) / k_eff

  biomass = 3.0
  r = 0.045
  K = 60.0
  mortality = 0.018

  do day = 1, days
    d_biomass = r * biomass * (1.0 - biomass / K) - mortality * biomass
    biomass = max(0.0, biomass + d_biomass)
  end do

  print *, "Final fungal biomass:", biomass
end program decomposition_biomass_kernel
