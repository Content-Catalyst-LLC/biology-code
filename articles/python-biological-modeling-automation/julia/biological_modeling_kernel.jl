# Biological modeling kernel in Julia.

function logistic_growth(initial_population, growth_rate, carrying_capacity, dt, steps)
    population = Float64(initial_population)

    for _ in 1:steps
        growth = growth_rate * population * (1.0 - population / carrying_capacity)
        population = max(population + dt * growth, 0.0)
    end

    return population
end

function two_compartment(initial_a, initial_b, k_ab, k_ba, k_clear, dt, steps)
    amount_a = Float64(initial_a)
    amount_b = Float64(initial_b)

    for _ in 1:steps
        flow_ab = k_ab * amount_a
        flow_ba = k_ba * amount_b
        clearance = k_clear * amount_a

        next_a = max(amount_a + dt * (-flow_ab + flow_ba - clearance), 0.0)
        next_b = max(amount_b + dt * (flow_ab - flow_ba), 0.0)

        amount_a = next_a
        amount_b = next_b
    end

    return amount_a, amount_b, amount_a + amount_b
end

final_population = logistic_growth(25.0, 0.35, 1000.0, 0.1, 200)
a, b, total = two_compartment(100.0, 0.0, 0.18, 0.07, 0.03, 0.1, 150)

println("final_population=", round(final_population, digits=5))
println("final_compartment_a=", round(a, digits=5))
println("final_compartment_b=", round(b, digits=5))
println("final_total_amount=", round(total, digits=5))
