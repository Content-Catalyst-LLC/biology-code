! Compact physiological feedback kernel in Fortran.
!
! This example simulates a regulated variable, hormonal signal, and effector
! response under coupled feedback dynamics.

program physiological_feedback_kernel
  implicit none

  integer, parameter :: n_steps = 801
  integer :: step
  real :: dt
  real :: regulated
  real :: hormone
  real :: effector
  real :: x_star
  real :: input_rate
  real :: a
  real :: b
  real :: c
  real :: d
  real :: u0
  real :: u1
  real :: uptake
  real :: d_regulated
  real :: d_hormone
  real :: d_effector
  real :: peak_regulated
  real :: peak_hormone
  real :: peak_effector

  dt = 0.05

  x_star = 5.0
  input_rate = 0.6
  a = 0.9
  b = 0.5
  c = 0.7
  d = 0.4
  u0 = 0.3
  u1 = 0.25

  regulated = 10.0
  hormone = 0.0
  effector = 0.0

  peak_regulated = regulated
  peak_hormone = hormone
  peak_effector = effector

  do step = 2, n_steps
    uptake = u0 + u1 * hormone * regulated

    d_regulated = input_rate - uptake
    d_hormone = a * (regulated - x_star) - b * hormone
    d_effector = c * hormone - d * effector

    regulated = max(0.0, regulated + d_regulated * dt)
    hormone = max(0.0, hormone + d_hormone * dt)
    effector = max(0.0, effector + d_effector * dt)

    if (regulated > peak_regulated) peak_regulated = regulated
    if (hormone > peak_hormone) peak_hormone = hormone
    if (effector > peak_effector) peak_effector = effector
  end do

  print *, "Peak regulated variable:", peak_regulated
  print *, "Peak hormone:", peak_hormone
  print *, "Peak effector:", peak_effector
  print *, "Final regulated variable:", regulated
  print *, "Recovery error:", abs(regulated - x_star)
end program physiological_feedback_kernel
