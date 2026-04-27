# Synthetic biology numerical kernel in Julia.
# Synthetic educational example.

function engineering_score(output_signal, host_burden, genetic_stability, measurement_uncertainty)
    return output_signal * 0.40 + genetic_stability * 0.30 - host_burden * 0.20 - measurement_uncertainty * 0.10
end

function circuit_final_output(initial_x, production_rate, input_strength, degradation_rate, dt, steps)
    x = initial_x
    for _ in 1:steps
        dx = production_rate * input_strength - degradation_rate * x
        x = max(x + dt * dx, 0.0)
    end
    return x
end

score = engineering_score(0.82, 0.18, 0.72, 0.12)
final_low = circuit_final_output(0.05, 1.20, 0.25, 0.40, 0.10, 80)
final_high = circuit_final_output(0.05, 1.20, 0.90, 0.40, 0.10, 80)

println("engineering_score=", round(score, digits=5))
println("final_low_input=", round(final_low, digits=5))
println("final_high_input=", round(final_high, digits=5))
