! Compact Shannon diversity kernel in Fortran.
!
! Calculates Shannon diversity and Hill q=1 for a small abundance vector.

program shannon_kernel
  implicit none

  integer, parameter :: n = 5
  real :: counts(n)
  real :: total
  real :: p
  real :: shannon
  real :: hill_q1
  integer :: i

  counts = (/12.0, 8.0, 0.0, 5.0, 3.0/)
  total = sum(counts)
  shannon = 0.0

  do i = 1, n
    if (counts(i) > 0.0) then
      p = counts(i) / total
      shannon = shannon - p * log(p)
    end if
  end do

  hill_q1 = exp(shannon)

  print *, "Shannon diversity:", shannon
  print *, "Hill q=1 effective diversity:", hill_q1
end program shannon_kernel
