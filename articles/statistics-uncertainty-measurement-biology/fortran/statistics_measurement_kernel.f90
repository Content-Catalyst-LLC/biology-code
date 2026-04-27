! Compact statistics and measurement numerical kernel in Fortran.

program statistics_measurement_kernel
  implicit none

  integer, parameter :: n = 10
  real :: values(n)
  real :: mean_value, sd_value, se_value, ci_lower, ci_upper
  real :: components(5)
  real :: combined_uncertainty, expanded_uncertainty
  real :: sumsq
  integer :: i

  values = (/10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4, 11.3, 10.7/)

  mean_value = sum(values) / real(n)
  sumsq = 0.0

  do i = 1, n
    sumsq = sumsq + (values(i) - mean_value)**2
  end do

  sd_value = sqrt(sumsq / real(n - 1))
  se_value = sd_value / sqrt(real(n))
  ci_lower = mean_value - 1.96 * se_value
  ci_upper = mean_value + 1.96 * se_value

  components = (/0.12, 0.08, 0.15, 0.06, 0.05/)
  combined_uncertainty = sqrt(sum(components**2))
  expanded_uncertainty = 2.0 * combined_uncertainty

  print *, "Mean:", mean_value
  print *, "Standard deviation:", sd_value
  print *, "Standard error:", se_value
  print *, "CI lower:", ci_lower
  print *, "CI upper:", ci_upper
  print *, "Combined uncertainty:", combined_uncertainty
  print *, "Expanded uncertainty:", expanded_uncertainty
end program statistics_measurement_kernel
