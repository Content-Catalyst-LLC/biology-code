! Compact nonlinear feedback numerical kernel in Fortran.

program nonlinear_feedback_kernel
  implicit none

  integer :: step, steps
  real :: response_sat, response_hill
  real :: signal, vmax, k_half, hill_n
  real :: x, set_point, k, dx, dt
  real :: alpha, beta, production, loss

  signal = 20.0
  vmax = 1.0
  k_half = 20.0
  response_sat = vmax * signal / (k_half + signal)

  signal = 60.0
  k_half = 40.0
  hill_n = 4.0
  response_hill = signal**hill_n / (k_half**hill_n + signal**hill_n)

  dt = 0.05
  x = 180.0
  set_point = 100.0
  k = 0.18
  steps = int(30.0 / dt) + 1

  do step = 2, steps
    dx = -k * (x - set_point)
    x = x + dx * dt
  end do

  print *, "Saturating response at 20:", response_sat
  print *, "Hill response at 60:", response_hill
  print *, "Negative feedback final:", x

  dt = 0.01
  x = 2.0
  alpha = 3.0
  beta = 0.8
  k_half = 1.5
  hill_n = 4.0
  steps = int(80.0 / dt) + 1

  do step = 2, steps
    production = alpha * x**hill_n / (k_half**hill_n + x**hill_n)
    loss = beta * x
    dx = production - loss
    x = max(x + dx * dt, 0.0)
  end do

  print *, "Positive feedback final:", x
end program nonlinear_feedback_kernel
