! Compact evolution and deep-time numerical kernel in Fortran.

program evolution_kernel
  implicit none

  real :: p
  real :: q
  real :: w_AA
  real :: w_Aa
  real :: w_aa
  real :: wbar
  real :: p_next
  real :: d
  real :: jc
  real :: lambda
  real :: mu
  real :: r
  real :: n0
  real :: t
  real :: nt

  p = 0.2
  q = 1.0 - p

  w_AA = 1.12
  w_Aa = 1.05
  w_aa = 1.0

  wbar = p ** 2 * w_AA + 2.0 * p * q * w_Aa + q ** 2 * w_aa
  p_next = (p ** 2 * w_AA + p * q * w_Aa) / wbar

  print *, "Mean fitness:", wbar
  print *, "p_next:", p_next
  print *, "delta_p:", p_next - p

  d = 0.15
  jc = -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d)

  print *, "Jukes-Cantor distance:", jc

  lambda = 0.10
  mu = 0.03
  r = lambda - mu
  n0 = 8.0
  t = 50.0
  nt = n0 * exp(r * t)

  print *, "Net diversification:", r
  print *, "Expected richness:", nt
end program evolution_kernel
