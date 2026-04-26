# Restoration Model Scaffold in Julia

function simulate_restoration(; S=1.0, B=0.8, D=0.5, dt=0.05, t_end=50.0)
    a = 0.8
    b = 0.15
    c = 0.20
    p = 0.10
    q = 0.25
    r = 0.12
    u = 0.08
    v = 0.10
    w = 0.18

    time = collect(0.0:dt:t_end)

    V = zeros(length(time))
    M = zeros(length(time))
    F = zeros(length(time))

    V[1] = 10.0
    M[1] = 8.0
    F[1] = 6.0

    for i in 2:length(time)
        dV = a*S - b*V[i-1] - c*D
        dM = p*V[i-1] + q*B - r*M[i-1]
        dF = u*V[i-1] + v*M[i-1] - w*D

        V[i] = max(0.0, V[i-1] + dV*dt)
        M[i] = max(0.0, M[i-1] + dM*dt)
        F[i] = max(0.0, F[i-1] + dF*dt)
    end

    return time, V, M, F
end

function main()
    scenarios = [
        ("low_effort_high_disturbance", 0.7, 0.8, 0.8),
        ("moderate_effort_moderate_disturbance", 1.0, 0.8, 0.5),
        ("high_effort_low_disturbance", 1.4, 0.8, 0.2),
        ("soil_limited_recovery", 1.1, 0.3, 0.4)
    ]

    println("scenario,final_V,final_M,final_F,peak_F")

    for (name, S, B, D) in scenarios
        time, V, M, F = simulate_restoration(S=S, B=B, D=D)
        println("$name,$(V[end]),$(M[end]),$(F[end]),$(maximum(F))")
    end
end

main()
