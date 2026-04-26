! Compact population genetics numerical kernel in Fortran.

program population_genetics_kernel
  implicit none

  real :: p
  real :: q
  real :: f_AA
  real :: f_Aa
  real :: f_aa
  real :: W_AA
  real :: W_Aa
  real :: W_aa
  real :: Wbar
  real :: p_next
  real :: mu
  real :: nu
  real :: m
  real :: p_migrant
  real :: p_mut
  real :: p_mig

  p = 0.7
  q = 1.0 - p

  print *, "Expected AA:", p ** 2
  print *, "Expected Aa:", 2.0 * p * q
  print *, "Expected aa:", q ** 2
  print *, "Expected heterozygosity:", 2.0 * p * q

  p = 0.2
  q = 1.0 - p

  f_AA = p ** 2
  f_Aa = 2.0 * p * q
  f_aa = q ** 2

  W_AA = 1.15
  W_Aa = 1.08
  W_aa = 1.0

  Wbar = f_AA * W_AA + f_Aa * W_Aa + f_aa * W_aa
  p_next = (f_AA * W_AA + 0.5 * f_Aa * W_Aa) / Wbar

  print *, "Selection p_next:", p_next
  print *, "Mean fitness:", Wbar

  mu = 0.0015
  nu = 0.0001
  p_mut = p_next * (1.0 - mu) + (1.0 - p_next) * nu

  m = 0.04
  p_migrant = 0.15
  p_mig = (1.0 - m) * p_mut + m * p_migrant

  print *, "Mutation update:", p_mut
  print *, "Migration update:", p_mig
end program population_genetics_kernel
