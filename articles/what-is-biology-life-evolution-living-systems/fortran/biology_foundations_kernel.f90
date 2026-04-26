! Compact biology-foundations numerical kernel in Fortran.

program biology_foundations_kernel
  implicit none

  real :: r
  real :: doubling_time
  real :: logistic_20
  real :: p
  real :: q
  real :: counts(5)
  real :: total
  real :: shannon
  integer :: i

  r = log(735.0 / 100.0) / 10.0
  doubling_time = log(2.0) / r
  logistic_20 = 2000.0 / (1.0 + ((2000.0 - 100.0) / 100.0) * exp(-0.35 * 20.0))

  p = 0.7
  q = 1.0 - p

  counts = (/25.0, 18.0, 11.0, 6.0, 4.0/)
  total = sum(counts)
  shannon = 0.0

  do i = 1, 5
    if (counts(i) > 0.0) then
      shannon = shannon - (counts(i) / total) * log(counts(i) / total)
    end if
  end do

  print *, "Growth rate:", r
  print *, "Doubling time:", doubling_time
  print *, "Logistic 20:", logistic_20
  print *, "HW AA:", p**2
  print *, "HW Aa:", 2.0 * p * q
  print *, "HW aa:", q**2
  print *, "Shannon diversity:", shannon
end program biology_foundations_kernel
