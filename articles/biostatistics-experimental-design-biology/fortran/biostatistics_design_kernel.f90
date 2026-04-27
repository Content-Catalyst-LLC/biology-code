! Compact biostatistics and experimental-design numerical kernel in Fortran.

program biostatistics_design_kernel
  implicit none

  integer, parameter :: n0 = 8, n1 = 8
  real :: control(n0), treated(n1)
  real :: mean0, mean1, sd0, sd1, pooled_sd, difference, effect_size_d
  real :: se_difference, approx_n
  integer :: i

  control = (/10.2, 11.1, 9.8, 10.5, 10.9, 11.0, 9.9, 10.4/)
  treated = (/12.1, 11.7, 12.4, 11.9, 12.0, 12.6, 11.8, 12.3/)

  mean0 = sum(control) / real(n0)
  mean1 = sum(treated) / real(n1)

  sd0 = 0.0
  do i = 1, n0
    sd0 = sd0 + (control(i) - mean0)**2
  end do
  sd0 = sqrt(sd0 / real(n0 - 1))

  sd1 = 0.0
  do i = 1, n1
    sd1 = sd1 + (treated(i) - mean1)**2
  end do
  sd1 = sqrt(sd1 / real(n1 - 1))

  pooled_sd = sqrt(((n0 - 1) * sd0**2 + (n1 - 1) * sd1**2) / real(n0 + n1 - 2))
  difference = mean1 - mean0
  effect_size_d = difference / pooled_sd
  se_difference = sqrt(sd0**2 / real(n0) + sd1**2 / real(n1))
  approx_n = 2.0 * (1.96 + 0.84)**2 / (0.8**2)

  print *, "Control mean:", mean0
  print *, "Treated mean:", mean1
  print *, "Mean difference:", difference
  print *, "Pooled SD:", pooled_sd
  print *, "Effect size d:", effect_size_d
  print *, "SE difference:", se_difference
  print *, "Approx n per group for d=0.8:", approx_n
end program biostatistics_design_kernel
