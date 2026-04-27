! Compact measurement uncertainty kernel in Fortran.

program measurement_uncertainty_kernel
  implicit none

  integer, parameter :: n = 10, m = 4
  real :: values(n), components(m)
  real :: mean_value, sd_value, cv, uc, expanded_uncertainty
  integer :: i

  values = (/10.2, 10.5, 10.1, 10.4, 10.8, 10.7, 10.6, 10.3, 10.9, 10.4/)
  components = (/0.08, 0.05, 0.11, 0.06/)

  mean_value = sum(values) / real(n)

  sd_value = 0.0
  do i = 1, n
    sd_value = sd_value + (values(i) - mean_value)**2
  end do
  sd_value = sqrt(sd_value / real(n - 1))

  cv = sd_value / mean_value

  uc = 0.0
  do i = 1, m
    uc = uc + components(i)**2
  end do
  uc = sqrt(uc)

  expanded_uncertainty = 2.0 * uc

  print *, "Mean value:", mean_value
  print *, "Sample SD:", sd_value
  print *, "Coefficient of variation:", cv
  print *, "Combined standard uncertainty:", uc
  print *, "Expanded uncertainty:", expanded_uncertainty
end program measurement_uncertainty_kernel
