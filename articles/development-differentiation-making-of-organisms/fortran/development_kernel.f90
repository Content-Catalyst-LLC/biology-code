! Compact developmental growth and differentiation kernel in Fortran.

program development_kernel
  implicit none

  real :: N0
  real :: N24
  real :: r
  real :: doubling_time
  real :: K
  real :: dN
  real :: N
  real :: dt
  real :: k1
  real :: k2
  real :: lineage1_fraction
  real :: x
  real :: morphogen

  N0 = 1.0e4
  N24 = 4.0e4
  r = log(N24 / N0) / 24.0
  doubling_time = log(2.0) / r

  print *, "Growth rate:", r
  print *, "Doubling time:", doubling_time

  N = 1.0e4
  K = 6.2e4
  dt = 1.0
  dN = r * N * (1.0 - N / K)
  N = N + dN * dt

  print *, "Logistic next N:", N

  k1 = 0.14
  k2 = 0.09
  lineage1_fraction = k1 / (k1 + k2)

  print *, "Lineage 1 fraction:", lineage1_fraction

  x = 0.2
  morphogen = exp(-5.0 * x)

  print *, "Morphogen at x=0.2:", morphogen
end program development_kernel
