! Compact stage-structured reproductive projection in Fortran.
!
! Stages: juvenile, subadult, adult.

program stage_matrix_reproduction_kernel
  implicit none

  integer, parameter :: stages = 3
  integer, parameter :: time_steps = 20
  integer :: t
  real :: A(stages, stages)
  real :: n(stages)
  real :: next_n(stages)

  A = reshape((/ &
    0.0, 0.45, 0.0, &
    0.0, 0.0, 0.70, &
    1.8, 0.0, 0.82 /), (/stages, stages/))

  n = (/50.0, 20.0, 15.0/)

  do t = 1, time_steps
    next_n = matmul(A, n)
    n = next_n
  end do

  print *, "Final juvenile:", n(1)
  print *, "Final subadult:", n(2)
  print *, "Final adult:", n(3)
  print *, "Final total:", sum(n)
end program stage_matrix_reproduction_kernel
