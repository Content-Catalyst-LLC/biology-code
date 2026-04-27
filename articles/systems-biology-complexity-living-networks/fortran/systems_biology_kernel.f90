! Compact systems biology feedback-dynamics kernel in Fortran.

program systems_biology_kernel
  implicit none

  integer, parameter :: steps = 80
  real :: x, y, dx, dy
  real :: production_x, production_y, degradation_x, degradation_y, hill_n, dt
  integer :: step

  x = 0.20
  y = 0.10
  production_x = 1.20
  production_y = 0.80
  degradation_x = 0.40
  degradation_y = 0.30
  hill_n = 2.0
  dt = 0.10

  do step = 1, steps
    dx = production_x / (1.0 + y**hill_n) - degradation_x * x
    dy = production_y * x - degradation_y * y

    x = x + dt * dx
    y = y + dt * dy

    if (x < 0.0) x = 0.0
    if (y < 0.0) y = 0.0
  end do

  print *, "final_x:", x
  print *, "final_y:", y
end program systems_biology_kernel
