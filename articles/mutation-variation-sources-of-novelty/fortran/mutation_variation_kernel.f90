! Compact mutation and variation numerical kernel in Fortran.

program mutation_variation_kernel
  implicit none

  real :: mu
  real :: L
  real :: n_genomes
  real :: lambda
  real :: p
  real :: q
  real :: d
  real :: d_jc
  real :: sel
  real :: q_star
  real :: pi_site

  mu = 1.0e-8
  L = 1.2e8
  n_genomes = 500.0

  lambda = n_genomes * L * mu

  p = 0.6
  q = 1.0 - p

  d = 0.15
  d_jc = -(3.0 / 4.0) * log(1.0 - (4.0 / 3.0) * d)

  sel = 0.01
  q_star = sqrt(1.0e-5 / sel)

  pi_site = 2.0 * p * (1.0 - p)

  print *, "Expected mutations:", lambda
  print *, "Hardy-Weinberg AA:", p ** 2
  print *, "Hardy-Weinberg Aa:", 2.0 * p * q
  print *, "Hardy-Weinberg aa:", q ** 2
  print *, "Jukes-Cantor distance:", d_jc
  print *, "Mutation-selection balance q:", q_star
  print *, "Pi at p=0.6:", pi_site
end program mutation_variation_kernel
