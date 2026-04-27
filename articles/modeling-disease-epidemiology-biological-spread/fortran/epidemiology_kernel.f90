! Compact epidemiology modeling kernel in Fortran.

program epidemiology_kernel
  implicit none

  integer, parameter :: steps = 240
  real :: population, susceptible, infected, recovered
  real :: beta, gamma, dt, new_infections, new_recoveries
  integer :: step

  population = 10000.0
  susceptible = 9990.0
  infected = 10.0
  recovered = 0.0
  beta = 0.32
  gamma = 0.10
  dt = 0.25

  do step = 1, steps
    new_infections = beta * susceptible * infected / population
    new_recoveries = gamma * infected

    susceptible = susceptible - dt * new_infections
    infected = infected + dt * (new_infections - new_recoveries)
    recovered = recovered + dt * new_recoveries

    if (susceptible < 0.0) susceptible = 0.0
    if (infected < 0.0) infected = 0.0
    if (recovered > population) recovered = population
  end do

  print *, "sir_final_susceptible:", susceptible
  print *, "sir_final_infected:", infected
  print *, "sir_final_recovered:", recovered
end program epidemiology_kernel
