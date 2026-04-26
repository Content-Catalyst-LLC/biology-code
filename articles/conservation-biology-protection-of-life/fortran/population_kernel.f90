! Compact stochastic-style population kernel in Fortran.
!
! This example uses deterministic inputs to demonstrate the numerical
! structure of a logistic population update with a catastrophe year.

program population_kernel
  implicit none

  integer, parameter :: years = 50
  integer :: year
  real :: population_size
  real :: growth_rate
  real :: carrying_capacity
  real :: catastrophe_multiplier

  population_size = 120.0
  growth_rate = 0.04
  carrying_capacity = 250.0
  catastrophe_multiplier = 0.65

  do year = 1, years
    population_size = population_size + growth_rate * population_size * &
      (1.0 - population_size / carrying_capacity)

    ! Apply an illustrative catastrophe every 17 years.
    if (mod(year, 17) == 0) then
      population_size = population_size * catastrophe_multiplier
    end if

    if (population_size < 0.0) population_size = 0.0
  end do

  print *, "Final population size:", population_size
end program population_kernel
