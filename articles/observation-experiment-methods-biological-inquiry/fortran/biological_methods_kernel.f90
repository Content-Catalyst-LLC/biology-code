! Compact biological-methods numerical kernel in Fortran.

program biological_methods_kernel
  implicit none

  real :: r
  real :: doubling_time
  real :: logistic_24
  real :: sensitivity
  real :: specificity
  real :: ppv
  real :: npv
  real :: accuracy

  r = log(10.0) / 10.0
  doubling_time = log(2.0) / r

  logistic_24 = 2000000.0 / (1.0 + ((2000000.0 - 100000.0) / 100000.0) * exp(-0.45 * 24.0))

  sensitivity = 84.0 / (84.0 + 16.0)
  specificity = 91.0 / (91.0 + 9.0)
  ppv = 84.0 / (84.0 + 9.0)
  npv = 91.0 / (91.0 + 16.0)
  accuracy = (84.0 + 91.0) / (84.0 + 16.0 + 91.0 + 9.0)

  print *, "Growth rate:", r
  print *, "Doubling time:", doubling_time
  print *, "Logistic abundance at 24:", logistic_24
  print *, "Sensitivity:", sensitivity
  print *, "Specificity:", specificity
  print *, "PPV:", ppv
  print *, "NPV:", npv
  print *, "Accuracy:", accuracy
end program biological_methods_kernel
