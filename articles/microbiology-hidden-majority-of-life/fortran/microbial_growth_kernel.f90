! Compact microbial growth kernel in Fortran.
!
! This example simulates substrate-limited growth using Monod kinetics.

program microbial_growth_kernel
  implicit none

  integer, parameter :: n_steps = 481
  integer :: step

  real :: dt
  real :: abundance
  real :: substrate
  real :: mu
  real :: mu_max
  real :: ks
  real :: yield_coeff
  real :: d_abundance
  real :: d_substrate

  dt = 0.1
  abundance = 10000.0
  substrate = 100.0
  mu_max = 0.8
  ks = 20.0
  yield_coeff = 1000000.0

  do step = 2, n_steps
    mu = mu_max * substrate / (ks + substrate)
    d_abundance = mu * abundance * dt
    d_substrate = -(d_abundance / yield_coeff)

    abundance = max(0.0, abundance + d_abundance)
    substrate = max(0.0, substrate + d_substrate)
  end do

  print *, "Final abundance:", abundance
  print *, "Remaining substrate:", substrate
end program microbial_growth_kernel
