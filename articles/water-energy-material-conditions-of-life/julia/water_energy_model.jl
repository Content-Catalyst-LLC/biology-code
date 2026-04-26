# Water, energy, and material conditions model in Julia.

const R_GAS = 0.082057

function osmotic_pressure(i, c, t)
    return i * c * R_GAS * t
end

function water_potential(solute, pressure, gravitational, matric)
    return solute + pressure + gravitational + matric
end

function homeostatic_state(time, initial_value, setpoint, k)
    return setpoint + (initial_value - setpoint) * exp(-k * time)
end

function exponential_growth(time, n0, r)
    return n0 * exp(r * time)
end

function doubling_time(r)
    if r <= 0
        return NaN
    end
    return log(2.0) / r
end

function monod_rate(substrate, mu_max, ks)
    return mu_max * substrate / (ks + substrate)
end

function oxygen_limited_rate(oxygen, half_saturation, max_rate)
    return max_rate * oxygen / (half_saturation + oxygen)
end

println("osmotic_pressure_atm=", round(osmotic_pressure(1.0, 0.30, 298.0), digits=6))
println("water_potential_MPa=", round(water_potential(-0.60, 0.45, 0.01, -0.02), digits=6))
println("homeostatic_state_t5=", round(homeostatic_state(5.0, 10.0, 2.0, 0.4), digits=6))
println("exponential_growth_48h=", round(exponential_growth(48.0, 1.0e5, log(4.0)/48.0), digits=3))
println("doubling_time_h=", round(doubling_time(log(4.0)/48.0), digits=3))
println("monod_rate=", round(monod_rate(4.0, 0.08, 2.5), digits=6))
println("oxygen_limited_rate=", round(oxygen_limited_rate(4.0, 2.0, 1.0), digits=6))
