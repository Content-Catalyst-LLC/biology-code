! Compact logistic growth kernel in Fortran.
!
! This example simulates density-dependent population growth with harvest.

program logistic_growth_kernel
  implicit none

  integer, parameter :: years = 50
  integer :: year
  real :: population_size
  real :: growth_rate
  real :: carrying_capacity
  real :: harvest
  real :: delta

  population_size = 80.0
  growth_rate = 0.18
  carrying_capacity = 500.0
  harvest = 5.0

  do year = 1, years
    delta = growth_rate * population_size * &
      (1.0 - population_size / carrying_capacity) - harvest

    population_size = max(0.0, population_size + delta)
  end do

  print *, "Final population size:", population_size
end program logistic_growth_kernel
