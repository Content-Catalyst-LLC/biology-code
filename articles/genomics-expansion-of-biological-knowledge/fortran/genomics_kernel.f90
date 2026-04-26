! Compact genomics numerical kernel in Fortran.

program genomics_kernel
  implicit none

  real :: p
  real :: q
  real :: he
  real :: p1
  real :: p2
  real :: pbar
  real :: ht
  real :: hs
  real :: fst
  real :: d
  real :: jc
  real :: treated
  real :: control
  real :: log2fc

  p = 0.8
  q = 1.0 - p
  he = 2.0 * p * q

  print *, "AA:", p ** 2
  print *, "Aa:", 2.0 * p * q
  print *, "aa:", q ** 2
  print *, "Expected heterozygosity:", he

  p1 = 0.40
  p2 = 0.75
  pbar = (p1 + p2) / 2.0
  ht = 2.0 * pbar * (1.0 - pbar)
  hs = (2.0 * p1 * (1.0 - p1) + 2.0 * p2 * (1.0 - p2)) / 2.0
  fst = (ht - hs) / ht

  print *, "FST-style value:", fst

  d = 0.15
  jc = -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d)

  print *, "Jukes-Cantor distance:", jc

  treated = 160.0
  control = 100.0
  log2fc = log((treated + 1.0) / (control + 1.0)) / log(2.0)

  print *, "log2FC:", log2fc
end program genomics_kernel
