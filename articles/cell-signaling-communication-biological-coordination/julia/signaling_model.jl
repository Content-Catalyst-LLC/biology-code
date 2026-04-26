# Cell signaling model in Julia.

function receptor_occupancy(L, Kd)
    return L / (Kd + L)
end

function hill_response(L, K, n)
    return L^n / (K^n + L^n)
end

function messenger_decay(M0, k, t)
    return M0 * exp(-k * t)
end

function signaling_half_life(k)
    return log(2.0) / k
end

function quorum_signal_update(Q, N, a, d, dt)
    return max(Q + (a * N - d * Q) * dt, 0.0)
end

L = 3.0
Kd = 1.5
K = 2.0
n = 3.0

k = log(4.0) / 4.0

Q_next = quorum_signal_update(0.5, 1e8, 1e-9, 0.35, 0.1)

println("occupancy=", round(receptor_occupancy(L, Kd), digits=6))
println("hill_response=", round(hill_response(L, K, n), digits=6))
println("messenger_at_4_min=", round(messenger_decay(100.0, k, 4.0), digits=6))
println("half_life_min=", round(signaling_half_life(k), digits=6))
println("quorum_signal_next=", round(Q_next, digits=6))
