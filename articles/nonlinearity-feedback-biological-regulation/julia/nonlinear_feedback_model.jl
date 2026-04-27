# Nonlinear feedback model kernels in Julia.

function saturating_response(signal, vmax, k_half)
    return vmax * signal / (k_half + signal)
end

function hill_response(signal, k_half, hill_coefficient)
    return signal^hill_coefficient / (k_half^hill_coefficient + signal^hill_coefficient)
end

function simulate_negative_feedback(x0, set_point, k, dt, t_end)
    steps = Int(floor(t_end / dt)) + 1
    x = x0
    for _ in 2:steps
        dx = -k * (x - set_point)
        x = x + dx * dt
    end
    return x
end

function simulate_positive_feedback(x0, alpha, beta, k_half, hill_coefficient, dt, t_end)
    steps = Int(floor(t_end / dt)) + 1
    x = x0
    for _ in 2:steps
        production = alpha * x^hill_coefficient / (k_half^hill_coefficient + x^hill_coefficient)
        loss = beta * x
        dx = production - loss
        x = max(x + dx * dt, 0.0)
    end
    return x
end

println("saturating_at_20=", round(saturating_response(20.0, 1.0, 20.0), digits=5))
println("hill_at_60_n4=", round(hill_response(60.0, 40.0, 4.0), digits=5))
println("negative_feedback_final=", round(simulate_negative_feedback(180.0, 100.0, 0.18, 0.05, 30.0), digits=5))
println("positive_feedback_final=", round(simulate_positive_feedback(2.0, 3.0, 0.8, 1.5, 4.0, 0.01, 80.0), digits=5))
