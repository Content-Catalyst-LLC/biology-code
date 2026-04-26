! Compact evolutionary-scale numerical kernel in Fortran.

program evolutionary_scale_kernel
  implicit none

  real :: p
  real :: q
  real :: f_AA
  real :: f_Aa
  real :: f_aa
  real :: w_AA
  real :: w_Aa
  real :: w_aa
  real :: wbar
  real :: p_next
  real :: lambda
  real :: mu
  real :: net_diversification
  real :: n0
  real :: r
  real :: t
  real :: n_t

  p = 0.8
  q = 1.0 - p

  print *, "Hardy-Weinberg AA:", p ** 2
  print *, "Hardy-Weinberg Aa:", 2.0 * p * q
  print *, "Hardy-Weinberg aa:", q ** 2

  p = 0.2
  q = 1.0 - p

  f_AA = p ** 2
  f_Aa = 2.0 * p * q
  f_aa = q ** 2

  w_AA = 1.15
  w_Aa = 1.08
  w_aa = 1.0

  wbar = f_AA * w_AA + f_Aa * w_Aa + f_aa * w_aa
  p_next = (f_AA * w_AA + 0.5 * f_Aa * w_Aa) / wbar

  print *, "Selection p_next:", p_next
  print *, "Mean fitness:", wbar

  lambda = 0.12
  mu = 0.08
  net_diversification = lambda - mu

  print *, "Net diversification:", net_diversification

  n0 = 20.0
  r = net_diversification
  t = 50.0
  n_t = n0 * exp(r * t)

  print *, "Expected lineages:", n_t
end program evolutionary_scale_kernel
