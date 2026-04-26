# Cell theory quantitative model in Julia.

function exponential_growth(time, initial_count, growth_rate)
    return initial_count * exp(growth_rate * time)
end

function doubling_time(growth_rate)
    if growth_rate <= 0
        return NaN
    end
    return log(2.0) / growth_rate
end

function logistic_growth(time, initial_count, growth_rate, carrying_capacity)
    return carrying_capacity / (1.0 + ((carrying_capacity - initial_count) / initial_count) * exp(-growth_rate * time))
end

function viability_decay(time, initial_count, loss_rate)
    return initial_count * exp(-loss_rate * time)
end

function membrane_flux(diffusion_coefficient, concentration_inside, concentration_outside, distance)
    gradient = (concentration_outside - concentration_inside) / distance
    return -diffusion_coefficient * gradient
end

function cell_condition_score(membrane, metabolism, proliferation, genome, organelle, stress)
    return 0.18 * membrane + 0.22 * metabolism + 0.18 * proliferation + 0.17 * genome + 0.15 * organelle + 0.10 * (1.0 - stress)
end

r = log(4.0) / 48.0
k = log(1000000.0 / 320000.0) / 48.0

println("growth_rate=", round(r, digits=6))
println("doubling_time_h=", round(doubling_time(r), digits=6))
println("logistic_96h=", round(logistic_growth(96.0, 1.0e5, 0.035, 1.0e6), digits=3))
println("viability_48h=", round(viability_decay(48.0, 1.0e6, k), digits=3))
println("membrane_flux=", membrane_flux(2.0e-6, 1.0, 0.2, 0.01))
println("condition_score=", round(cell_condition_score(0.92, 0.88, 0.84, 0.90, 0.86, 0.12), digits=6))
