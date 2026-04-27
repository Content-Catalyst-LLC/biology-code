! R biology statistics kernel in Fortran.

program r_biology_statistics_kernel
  implicit none

  integer, parameter :: n = 6, s = 4
  real :: values(n), counts(s)
  real :: mean_value, sd_value, shannon, total, p
  integer :: i

  values = (/10.2, 10.5, 10.1, 10.4, 10.3, 10.6/)
  counts = (/18.0, 7.0, 3.0, 0.0/)

  mean_value = sum(values) / real(n)

  sd_value = 0.0
  do i = 1, n
    sd_value = sd_value + (values(i) - mean_value)**2
  end do
  sd_value = sqrt(sd_value / real(n - 1))

  total = 0.0
  do i = 1, s
    if (counts(i) > 0.0) total = total + counts(i)
  end do

  shannon = 0.0
  do i = 1, s
    if (counts(i) > 0.0) then
      p = counts(i) / total
      shannon = shannon - p * log(p)
    end if
  end do

  print *, "mean_value:", mean_value
  print *, "sample_sd:", sd_value
  print *, "shannon_diversity:", shannon
end program r_biology_statistics_kernel
