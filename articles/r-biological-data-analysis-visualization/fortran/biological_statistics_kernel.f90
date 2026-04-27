! Biological statistics kernel in Fortran.

program biological_statistics_kernel
  implicit none

  integer, parameter :: n = 6
  real :: values(n)
  real :: mean_value, sd_value, cv
  integer :: i

  values = (/10.2, 10.5, 10.1, 10.4, 10.3, 10.6/)

  mean_value = sum(values) / real(n)

  sd_value = 0.0
  do i = 1, n
    sd_value = sd_value + (values(i) - mean_value)**2
  end do

  sd_value = sqrt(sd_value / real(n - 1))
  cv = sd_value / mean_value

  print *, "mean_value:", mean_value
  print *, "sample_sd:", sd_value
  print *, "coefficient_of_variation:", cv
end program biological_statistics_kernel
