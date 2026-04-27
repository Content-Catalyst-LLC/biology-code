# Evolutionary medicine numerical kernel in Julia.
# Synthetic educational example.

function simulate_resistance(initial_frequency, selection_advantage, fitness_cost, steps)
    frequency = initial_frequency
    for _ in 1:steps
        frequency = frequency * (1.0 + selection_advantage - fitness_cost)
        frequency = max(0.0, min(frequency, 1.0))
    end
    return frequency
end

function clonal_expansion(initial_clone_size, growth_rate, time)
    return initial_clone_size * exp(growth_rate * time)
end

final_frequency = simulate_resistance(0.02, 0.18, 0.04, 20)
clone_size = clonal_expansion(100.0, 0.12, 20)

println("final_resistant_frequency=", round(final_frequency, digits=5))
println("clone_size=", round(clone_size, digits=5))
