! Compact stage-structured population projection in Fortran.
!
! Stages: juveniles, subadults, adults.

program stage_matrix_kernel
  implicit none

  integer, parameter :: stages = 3
  integer, parameter :: years = 20
  integer :: year
  real :: A(stages, stages)
  real :: n(stages)
  real :: next_n(stages)

  A = reshape((/ &
    0.0, 0.45, 0.0, &
    0.0, 0.0, 0.70, &
    1.8, 0.0, 0.82 /), (/stages, stages/))

  n = (/50.0, 20.0, 15.0/)

  do year = 1, years
    next_n = matmul(A, n)
    n = next_n
  end do

  print *, "Final juveniles:", n(1)
  print *, "Final subadults:", n(2)
  print *, "Final adults:", n(3)
  print *, "Final total population:", sum(n)
end program stage_matrix_kernel
