# Life, death, and biological definition model in Julia.

function viability_decay(time, initial_count, loss_rate)
    return initial_count * exp(-loss_rate * time)
end

function survival_probability(time, hazard_rate)
    return exp(-hazard_rate * time)
end

function dormancy_state(time, dormant_initial, mortality_rate, reactivation_rate)
    return dormant_initial * exp(-(mortality_rate + reactivation_rate) * time)
end

function activated_integral(time, dormant_initial, mortality_rate, reactivation_rate)
    total_rate = mortality_rate + reactivation_rate
    if total_rate == 0
        return 0.0
    end
    return reactivation_rate * dormant_initial * (1 - exp(-total_rate * time)) / total_rate
end

function heuristic_life_score(values, weights)
    return sum(values .* weights)
end

weights = [0.18, 0.18, 0.16, 0.18, 0.12, 0.18]
bacterium = [0.95, 0.90, 0.88, 0.90, 0.85, 0.90]
virus = [0.55, 0.05, 0.10, 0.82, 0.25, 0.88]

println("viable_count_48h=", round(viability_decay(48.0, 1.0e6, log(4.0) / 48.0), digits=3))
println("survival_probability_48h=", round(survival_probability(48.0, log(4.0) / 48.0), digits=6))
println("dormant_20=", round(dormancy_state(20.0, 1.0e6, 0.02, 0.05), digits=3))
println("activated_20=", round(activated_integral(20.0, 1.0e6, 0.02, 0.05), digits=3))
println("bacterium_score=", round(heuristic_life_score(bacterium, weights), digits=6))
println("virus_score=", round(heuristic_life_score(virus, weights), digits=6))
