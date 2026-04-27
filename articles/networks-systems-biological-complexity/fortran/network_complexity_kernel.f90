! Compact biological network numerical kernel in Fortran.

program network_complexity_kernel
  implicit none

  integer, parameter :: n = 6
  real :: A(n,n), state(n), next_state(n)
  real :: degrees(n)
  real :: density, alpha, decay
  integer :: i, j, step, edge_count

  A = reshape((/ &
    0.0, 1.0, 0.8, 0.0, 0.0, 0.0, &
    1.0, 0.0, 0.7, 1.2, 0.0, 0.0, &
    0.8, 0.7, 0.0, 0.0, 0.9, 0.0, &
    0.0, 1.2, 0.0, 0.0, 1.1, 0.6, &
    0.0, 0.0, 0.9, 1.1, 0.0, 0.5, &
    0.0, 0.0, 0.0, 0.6, 0.5, 0.0 /), (/n,n/))

  edge_count = 0

  do i = 1, n
    degrees(i) = 0.0
    do j = 1, n
      if (A(i,j) > 0.0) degrees(i) = degrees(i) + 1.0
      if (j > i .and. A(i,j) > 0.0) edge_count = edge_count + 1
    end do
  end do

  density = real(edge_count) / (real(n) * real(n - 1) / 2.0)

  state = (/1.0, 0.0, 0.0, 0.0, 0.0, 0.0/)
  alpha = 0.08
  decay = 0.04

  do step = 1, 20
    next_state = state

    do i = 1, n
      next_state(i) = state(i) - decay * state(i)
      do j = 1, n
        next_state(i) = next_state(i) + alpha * A(i,j) * state(j)
      end do
      if (next_state(i) < 0.0) next_state(i) = 0.0
    end do

    state = next_state
  end do

  print *, "Density:", density
  print *, "Mean degree:", sum(degrees) / real(n)
  print *, "Max degree:", maxval(degrees)
  print *, "Final diffusion state:", state
end program network_complexity_kernel
