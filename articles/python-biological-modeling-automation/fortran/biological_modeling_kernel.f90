! Biological modeling kernel in Fortran.

program biological_modeling_kernel
  implicit none

  integer, parameter :: logistic_steps = 200, compartment_steps = 150
  real :: population, growth_rate, carrying_capacity, dt, growth
  real :: amount_a, amount_b, flow_ab, flow_ba, clearance
  real :: next_a, next_b
  integer :: step

  population = 25.0
  growth_rate = 0.35
  carrying_capacity = 1000.0
  dt = 0.1

  do step = 1, logistic_steps
    growth = growth_rate * population * (1.0 - population / carrying_capacity)
    population = population + dt * growth
    if (population < 0.0) population = 0.0
  end do

  amount_a = 100.0
  amount_b = 0.0

  do step = 1, compartment_steps
    flow_ab = 0.18 * amount_a
    flow_ba = 0.07 * amount_b
    clearance = 0.03 * amount_a

    next_a = amount_a + dt * (-flow_ab + flow_ba - clearance)
    next_b = amount_b + dt * (flow_ab - flow_ba)

    if (next_a < 0.0) next_a = 0.0
    if (next_b < 0.0) next_b = 0.0

    amount_a = next_a
    amount_b = next_b
  end do

  print *, "final_population:", population
  print *, "final_compartment_a:", amount_a
  print *, "final_compartment_b:", amount_b
  print *, "final_total_amount:", amount_a + amount_b
end program biological_modeling_kernel
