# Mathematical biology model kernels in Julia.

function logistic_growth(t, n0, r, k)
    return k / (1.0 + ((k - n0) / n0) * exp(-r * t))
end

function michaelis_menten(substrate, vmax, km)
    return vmax * substrate / (km + substrate)
end

function sir_step(s, i, r_comp, beta, gamma, dt)
    ds = -beta * s * i
    di = beta * s * i - gamma * i
    dr = gamma * i
    return max(s + ds * dt, 0.0), max(i + di * dt, 0.0), max(r_comp + dr * dt, 0.0)
end

function simulate_sir(beta, gamma, s0, i0, r0, time_end, dt)
    steps = Int(floor(time_end / dt)) + 1
    s = s0
    i = i0
    r_comp = r0
    peak_i = i
    time_to_peak = 0.0

    for step in 1:steps
        current_time = (step - 1) * dt
        if i > peak_i
            peak_i = i
            time_to_peak = current_time
        end
        s, i, r_comp = sir_step(s, i, r_comp, beta, gamma, dt)
    end

    return peak_i, time_to_peak, r_comp
end

function predator_prey_step(prey, predator, alpha, beta, delta, gamma, dt)
    dprey = alpha * prey - beta * prey * predator
    dpredator = delta * prey * predator - gamma * predator
    return max(prey + dprey * dt, 0.0), max(predator + dpredator * dt, 0.0)
end

function simulate_predator_prey(prey0, predator0, alpha, beta, delta, gamma, time_end, dt)
    steps = Int(floor(time_end / dt)) + 1
    prey = prey0
    predator = predator0

    for step in 1:steps
        prey, predator = predator_prey_step(prey, predator, alpha, beta, delta, gamma, dt)
    end

    return prey, predator
end

println("logistic_40=", round(logistic_growth(40.0, 100.0, 0.30, 2000.0), digits=4))
println("enzyme_velocity=", round(michaelis_menten(5.0, 10.0, 2.0), digits=4))

peak_i, time_peak, final_r = simulate_sir(0.35, 0.10, 0.99, 0.01, 0.0, 120.0, 0.05)
println("sir_peak=", round(peak_i, digits=6), " time_to_peak=", round(time_peak, digits=3), " final_recovered=", round(final_r, digits=6))

final_prey, final_predator = simulate_predator_prey(40.0, 9.0, 0.60, 0.025, 0.018, 0.35, 80.0, 0.01)
println("predator_prey_final=", round(final_prey, digits=4), " ", round(final_predator, digits=4))
