! Compact cell-theory numerical kernel in Fortran.

program cell_theory_kernel
  implicit none

  real :: growth_rate
  real :: doubling_time
  real :: logistic_96
  real :: loss_rate
  real :: viability_48
  real :: flux
  real :: condition_score

  growth_rate = log(4.0) / 48.0
  doubling_time = log(2.0) / growth_rate

  logistic_96 = 1000000.0 / (1.0 + ((1000000.0 - 100000.0) / 100000.0) * exp(-0.035 * 96.0))

  loss_rate = log(1000000.0 / 320000.0) / 48.0
  viability_48 = 1000000.0 * exp(-loss_rate * 48.0)

  flux = -0.000002 * ((0.2 - 1.0) / 0.01)

  condition_score = 0.18*0.92 + 0.22*0.88 + 0.18*0.84 + 0.17*0.90 + 0.15*0.86 + 0.10*(1.0 - 0.12)

  print *, "Growth rate:", growth_rate
  print *, "Doubling time:", doubling_time
  print *, "Logistic 96h:", logistic_96
  print *, "Viability 48h:", viability_48
  print *, "Membrane flux:", flux
  print *, "Cell condition score:", condition_score
end program cell_theory_kernel
