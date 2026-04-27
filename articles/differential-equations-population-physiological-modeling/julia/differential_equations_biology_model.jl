# Differential-equation biology model kernels in Julia.

function simulate_logistic(N0, r, K, dt, t_end)
    steps = Int(floor(t_end / dt)) + 1
    N = N0
    for _ in 2:steps
        dN = r * N * (1 - N / K)
        N = max(N + dN * dt, 0.0)
    end
    return N
end

function simulate_homeostasis(x0, set_point, k, dt, t_end)
    steps = Int(floor(t_end / dt)) + 1
    x = x0
    for _ in 2:steps
        dx = -k * (x - set_point)
        x = x + dx * dt
    end
    return x
end

function simulate_pk(C0, elimination_rate, dt, t_end)
    steps = Int(floor(t_end / dt)) + 1
    C = C0
    for _ in 2:steps
        dC = -elimination_rate * C
        C = max(C + dC * dt, 0.0)
    end
    return C
end

function simulate_sir(beta, gamma, S0, I0, R0, dt, t_end)
    steps = Int(floor(t_end / dt)) + 1
    S = S0
    I = I0
    R = R0
    peak_i = I
    time_to_peak = 0.0

    for step in 2:steps
        current_time = (step - 1) * dt
        if I > peak_i
            peak_i = I
            time_to_peak = current_time
        end

        dS = -beta * S * I
        dI = beta * S * I - gamma * I
        dR = gamma * I

        S = max(S + dS * dt, 0.0)
        I = max(I + dI * dt, 0.0)
        R = max(R + dR * dt, 0.0)
    end

    return peak_i, time_to_peak, R
end

println("logistic_final=", round(simulate_logistic(100.0, 0.30, 2000.0, 0.05, 40.0), digits=5))
println("homeostasis_final=", round(simulate_homeostasis(180.0, 100.0, 0.18, 0.05, 30.0), digits=5))
println("pk_final=", round(simulate_pk(20.0, 0.12, 0.05, 48.0), digits=5))

peak_i, time_to_peak, final_recovered = simulate_sir(0.35, 0.10, 0.99, 0.01, 0.0, 0.05, 120.0)
println("sir_peak=", round(peak_i, digits=6), " time_to_peak=", round(time_to_peak, digits=3), " final_recovered=", round(final_recovered, digits=6))
