# Enzyme and biochemical pathway model in Julia.

function michaelis_menten(S, Vmax, Km)
    return (Vmax * S) / (Km + S)
end

function competitive_inhibition(S, Vmax, Km, I, Ki)
    return (Vmax * S) / (Km * (1.0 + I / Ki) + S)
end

function noncompetitive_inhibition(S, Vmax, Km, I, Ki)
    return (Vmax / (1.0 + I / Ki)) * S / (Km + S)
end

function hill_response(S, Vmax, K, n)
    return Vmax * S^n / (K^n + S^n)
end

function catalytic_efficiency(kcat, Km)
    return kcat / Km
end

function feedback_velocity(S, P, Vmax, Km, Kf)
    base = michaelis_menten(S, Vmax, Km)
    return base / (1.0 + P / Kf)
end

S = 10.0
Vmax = 120.0
Km = 5.0
I = 4.0
Ki = 2.0

println("michaelis_menten=", round(michaelis_menten(S, Vmax, Km), digits=6))
println("competitive_inhibition=", round(competitive_inhibition(S, Vmax, Km, I, Ki), digits=6))
println("noncompetitive_inhibition=", round(noncompetitive_inhibition(S, Vmax, Km, I, Ki), digits=6))
println("hill_response=", round(hill_response(S, Vmax, 6.0, 2.5), digits=6))
println("catalytic_efficiency=", round(catalytic_efficiency(75.0, 5.0), digits=6))
println("feedback_velocity=", round(feedback_velocity(S, 8.0, Vmax, Km, 6.0), digits=6))
