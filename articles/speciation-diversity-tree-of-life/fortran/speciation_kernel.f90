! Compact speciation and phylogenetic-distance numerical kernel in Fortran.

program speciation_kernel
  implicit none

  real :: p1
  real :: p2
  real :: delta_p
  real :: h1
  real :: h2
  real :: pbar
  real :: ht
  real :: hs
  real :: fst
  real :: p_distance
  real :: jukes_cantor
  real :: lambda
  real :: mu
  real :: net_diversification

  p1 = 0.70
  p2 = 0.42

  delta_p = abs(p1 - p2)

  h1 = 2.0 * p1 * (1.0 - p1)
  h2 = 2.0 * p2 * (1.0 - p2)
  pbar = (p1 + p2) / 2.0
  ht = 2.0 * pbar * (1.0 - pbar)
  hs = (h1 + h2) / 2.0

  if (ht > 0.0) then
    fst = (ht - hs) / ht
  else
    fst = 0.0
  end if

  p_distance = 0.15
  jukes_cantor = -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * p_distance)

  lambda = 0.10
  mu = 0.03
  net_diversification = lambda - mu

  print *, "Delta p:", delta_p
  print *, "FST-style value:", fst
  print *, "Jukes-Cantor distance:", jukes_cantor
  print *, "Net diversification:", net_diversification
end program speciation_kernel
