! Compact modern-biology numerical kernel in Fortran.

program modern_biology_kernel
  implicit none

  real :: r
  real :: doubling_time
  real :: logistic_20
  real :: p
  real :: q
  real :: aa_capital
  real :: heterozygote
  real :: aa_lower
  real :: p_next
  real :: wbar

  r = log(708.0 / 100.0) / 10.0
  doubling_time = log(2.0) / r
  logistic_20 = 2000.0 / (1.0 + ((2000.0 - 100.0) / 100.0) * exp(-0.35 * 20.0))

  p = 0.7
  q = 1.0 - p

  aa_capital = p**2
  heterozygote = 2.0 * p * q
  aa_lower = q**2

  p = 0.5
  q = 1.0 - p
  wbar = p**2 * 1.1 + 2.0 * p * q * 1.05 + q**2 * 1.0
  p_next = (p**2 * 1.1 + p * q * 1.05) / wbar

  print *, "Growth rate:", r
  print *, "Doubling time:", doubling_time
  print *, "Logistic 20:", logistic_20
  print *, "HW AA:", aa_capital
  print *, "HW Aa:", heterozygote
  print *, "HW aa:", aa_lower
  print *, "Selection p next:", p_next
end program modern_biology_kernel
