! Restoration Recovery Table
!
! Simple recovery model:
!
! dR/dt = k(T - R)

program restoration_recovery_table
  implicit none

  real(8) :: R
  real(8) :: target
  real(8) :: k
  real(8) :: dt
  real(8) :: time
  integer :: step
  integer :: n_steps

  R = 40.0d0
  target = 80.0d0
  k = 0.1d0
  dt = 0.5d0
  n_steps = 100

  print *, "step,time,recovery_state"

  do step = 0, n_steps
     time = step * dt
     print '(I5,A,F10.4,A,F12.6)', step, ",", time, ",", R
     R = R + k * (target - R) * dt
  end do

end program restoration_recovery_table
