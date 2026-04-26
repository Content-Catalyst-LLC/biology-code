! Compact heredity numerical kernel in Fortran.

program heredity_kernel
  implicit none

  real :: p
  real :: q
  real :: AA
  real :: Aa
  real :: aa
  real :: He
  real :: obs_dom
  real :: obs_rec
  real :: exp_dom
  real :: exp_rec
  real :: chi
  real :: recomb
  real :: total
  real :: r
  real :: VA
  real :: VP
  real :: h2
  real :: S
  real :: response

  p = 0.7
  q = 1.0 - p

  AA = p ** 2
  Aa = 2.0 * p * q
  aa = q ** 2
  He = 2.0 * p * q

  print *, "AA:", AA
  print *, "Aa:", Aa
  print *, "aa:", aa
  print *, "Expected heterozygosity:", He

  obs_dom = 315.0
  obs_rec = 105.0
  exp_dom = 315.0
  exp_rec = 105.0

  chi = ((obs_dom - exp_dom) ** 2) / exp_dom + ((obs_rec - exp_rec) ** 2) / exp_rec

  print *, "Chi-square:", chi

  recomb = 185.0
  total = 1000.0
  r = recomb / total

  print *, "Recombination fraction:", r

  VA = 4.0
  VP = 13.0
  h2 = VA / VP
  S = 5.0
  response = h2 * S

  print *, "h2:", h2
  print *, "Predicted response:", response
end program heredity_kernel
