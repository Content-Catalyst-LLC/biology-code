! Compact ecological interaction and biomass kernel in Fortran.
!
! This example simulates producer-herbivore-carnivore dynamics and a simple
! biomass or detrital pool.

program ecological_interaction_kernel
  implicit none

  integer, parameter :: time_steps = 150
  integer :: t
  real :: producers
  real :: herbivores
  real :: carnivores
  real :: biomass_pool
  real :: delta_producers
  real :: delta_herbivores
  real :: delta_carnivores
  real :: delta_biomass_pool

  producers = 100.0
  herbivores = 30.0
  carnivores = 8.0
  biomass_pool = 60.0

  do t = 1, time_steps
    delta_producers = 0.10 * producers * (1.0 - producers / 250.0) - &
      0.0035 * producers * herbivores

    delta_herbivores = 0.15 * 0.0035 * producers * herbivores - &
      0.04 * herbivores - 0.0020 * herbivores * carnivores

    delta_carnivores = 0.10 * 0.0020 * herbivores * carnivores - &
      0.03 * carnivores

    delta_biomass_pool = 0.18 * producers - 0.07 * herbivores - &
      0.05 * carnivores - 0.05 * biomass_pool + &
      0.02 * (herbivores + carnivores)

    producers = max(0.0, producers + delta_producers)
    herbivores = max(0.0, herbivores + delta_herbivores)
    carnivores = max(0.0, carnivores + delta_carnivores)
    biomass_pool = max(0.0, biomass_pool + delta_biomass_pool)
  end do

  print *, "Final producers:", producers
  print *, "Final herbivores:", herbivores
  print *, "Final carnivores:", carnivores
  print *, "Final biomass pool:", biomass_pool
end program ecological_interaction_kernel
