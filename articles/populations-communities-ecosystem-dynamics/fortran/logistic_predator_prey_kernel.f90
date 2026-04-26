! Compact logistic predator-prey kernel in Fortran.
!
! This example simulates producer and herbivore dynamics with logistic
! producer growth and herbivore consumption.

program logistic_predator_prey_kernel
  implicit none

  integer, parameter :: time_steps = 200
  integer :: t
  real :: producers
  real :: herbivores
  real :: delta_producers
  real :: delta_herbivores

  producers = 80.0
  herbivores = 20.0

  do t = 1, time_steps
    delta_producers = 0.08 * producers * (1.0 - producers / 200.0) - &
      0.003 * producers * herbivores

    delta_herbivores = 0.12 * 0.003 * producers * herbivores - &
      0.03 * herbivores

    producers = max(0.0, producers + delta_producers)
    herbivores = max(0.0, herbivores + delta_herbivores)
  end do

  print *, "Final producers:", producers
  print *, "Final herbivores:", herbivores
end program logistic_predator_prey_kernel
