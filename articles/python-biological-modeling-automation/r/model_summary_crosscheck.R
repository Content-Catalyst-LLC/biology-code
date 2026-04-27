# Cross-check logistic growth and two-compartment model summaries in R.

simulate_logistic <- function(initial_population, growth_rate, carrying_capacity, dt, steps) {
  population <- initial_population

  for (step in 1:steps) {
    growth <- growth_rate * population * (1 - population / carrying_capacity)
    population <- max(population + dt * growth, 0)
  }

  population
}

simulate_two_compartment <- function(initial_a, initial_b, k_ab, k_ba, k_clear, dt, steps) {
  amount_a <- initial_a
  amount_b <- initial_b

  for (step in 1:steps) {
    flow_ab <- k_ab * amount_a
    flow_ba <- k_ba * amount_b
    clearance <- k_clear * amount_a

    amount_a_next <- max(amount_a + dt * (-flow_ab + flow_ba - clearance), 0)
    amount_b_next <- max(amount_b + dt * (flow_ab - flow_ba), 0)

    amount_a <- amount_a_next
    amount_b <- amount_b_next
  }

  data.frame(
    final_compartment_a = amount_a,
    final_compartment_b = amount_b,
    final_total_amount = amount_a + amount_b
  )
}

logistic_final <- simulate_logistic(25, 0.35, 1000, 0.1, 200)
compartment_final <- simulate_two_compartment(100, 0, 0.18, 0.07, 0.03, 0.1, 150)

print(data.frame(model = "logistic_growth", final_population = logistic_final))
print(compartment_final)
