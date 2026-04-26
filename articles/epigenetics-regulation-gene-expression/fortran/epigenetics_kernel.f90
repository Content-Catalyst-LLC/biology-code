! Compact epigenetics and expression kinetics kernel in Fortran.

program epigenetics_kernel
  implicit none

  real :: m0
  real :: k
  real :: t
  real :: expr
  real :: half_life
  real :: methylated
  real :: unmethylated
  real :: meth_fraction
  real :: kon
  real :: koff
  real :: p_on_ss
  real :: treated_expr
  real :: control_expr
  real :: log2fc

  m0 = 120.0
  k = log(4.0) / 6.0
  t = 6.0

  expr = m0 * exp(-k * t)
  half_life = log(2.0) / k

  methylated = 85.0
  unmethylated = 15.0
  meth_fraction = methylated / (methylated + unmethylated)

  kon = 0.28
  koff = 0.10
  p_on_ss = kon / (kon + koff)

  treated_expr = 25.0
  control_expr = 12.0
  log2fc = log((treated_expr + 1.0e-6) / (control_expr + 1.0e-6)) / log(2.0)

  print *, "Expression at 6h:", expr
  print *, "Half-life:", half_life
  print *, "Methylation fraction:", meth_fraction
  print *, "Steady-state p_on:", p_on_ss
  print *, "log2FC:", log2fc
end program epigenetics_kernel
