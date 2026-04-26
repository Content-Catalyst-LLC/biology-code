! Compact extinction survivorship and recovery kernel in Fortran.

program extinction_kernel
  implicit none

  integer :: step
  real :: initial
  real :: survivors
  real :: survivorship
  real :: extinction
  real :: lambda
  real :: time
  real :: n0
  real :: r
  real :: k
  real :: richness

  initial = 120.0
  survivors = 30.0
  survivorship = survivors / initial
  extinction = 1.0 - survivorship

  print *, "Survivorship:", survivorship
  print *, "Extinction:", extinction

  lambda = 0.18

  do step = 0, 10
    time = real(step)
    print *, "Time:", time, " Hazard survivorship:", exp(-lambda * time)
  end do

  n0 = 5.0
  r = 0.14
  k = 60.0
  time = 30.0

  richness = k / (1.0 + ((k - n0) / n0) * exp(-r * time))

  print *, "Recovery richness at t=30:", richness
end program extinction_kernel
