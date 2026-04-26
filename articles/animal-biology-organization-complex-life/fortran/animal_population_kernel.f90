! Animal allometry and population projection kernel in Fortran.

program animal_population_kernel
  implicit none

  integer :: year
  real :: mass
  real :: b0
  real :: metabolic_rate
  real :: survival
  real :: hazard
  real :: t
  real :: juveniles
  real :: adults
  real :: new_juveniles
  real :: new_adults

  b0 = 4.2
  mass = 80.0
  metabolic_rate = b0 * mass ** 0.75

  print *, "Metabolic rate:", metabolic_rate
  print *, "Mass-specific rate:", metabolic_rate / mass

  hazard = 0.012
  t = 100.0
  survival = exp(-hazard * t)

  print *, "Survival at day 100:", survival

  juveniles = 40.0
  adults = 25.0

  do year = 0, 20
    print *, "Year:", year, " Juveniles:", juveniles, " Adults:", adults, " Total:", juveniles + adults

    new_juveniles = 1.4 * adults
    new_adults = 0.35 * juveniles + 0.72 * adults

    juveniles = new_juveniles
    adults = new_adults
  end do
end program animal_population_kernel
