! Compact host-pathogen-immune dynamics kernel in Fortran.
!
! This example simulates pathogen load, immune activity, and damage burden.

program host_pathogen_immune_kernel
  implicit none

  integer, parameter :: n_steps = 601
  integer :: step
  real :: dt
  real :: pathogen
  real :: immune
  real :: damage
  real :: r
  real :: c
  real :: alpha
  real :: delta
  real :: gamma
  real :: rho
  real :: d_pathogen
  real :: d_immune
  real :: d_damage
  real :: peak_pathogen
  real :: peak_immune
  real :: peak_damage

  dt = 0.05

  r = 0.45
  c = 0.12
  alpha = 0.08
  delta = 0.18
  gamma = 0.06
  rho = 0.10

  pathogen = 50.0
  immune = 2.0
  damage = 0.0

  peak_pathogen = pathogen
  peak_immune = immune
  peak_damage = damage

  do step = 2, n_steps
    d_pathogen = r * pathogen - c * immune * pathogen
    d_immune = alpha * pathogen - delta * immune
    d_damage = gamma * immune - rho * damage

    pathogen = max(0.0, pathogen + d_pathogen * dt)
    immune = max(0.0, immune + d_immune * dt)
    damage = max(0.0, damage + d_damage * dt)

    if (pathogen > peak_pathogen) peak_pathogen = pathogen
    if (immune > peak_immune) peak_immune = immune
    if (damage > peak_damage) peak_damage = damage
  end do

  print *, "Peak pathogen:", peak_pathogen
  print *, "Peak immune:", peak_immune
  print *, "Peak damage:", peak_damage
  print *, "Final pathogen:", pathogen
  print *, "Final damage:", damage
end program host_pathogen_immune_kernel
